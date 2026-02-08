import 'dart:convert';

import '../protocol_adapter.dart';
import '../llm_client.dart';

/// Protocol adapter for the Anthropic Messages API.
///
/// Transforms between the canonical OpenAI format used internally
/// and the Anthropic wire format:
///
/// - Auth via `x-api-key` header instead of `Authorization: Bearer`.
/// - System messages extracted to a top-level `system` field.
/// - Tool `parameters` mapped to `input_schema`.
/// - `tool` role messages mapped to `user` role with `tool_result`
///   content blocks.
/// - SSE events dispatched by `type` field (`content_block_delta`,
///   `message_delta`, `message_stop`).
class AnthropicAdapter extends ProtocolAdapter {
  final String anthropicVersion;

  AnthropicAdapter({this.anthropicVersion = '2023-06-01'});

  @override
  String get chatEndpoint => '/v1/messages';

  @override
  String? get modelsEndpoint => '/v1/models';

  // ── Headers ──────────────────────────────────────────────────

  @override
  Map<String, String> buildHeaders(LlmClientConfig config) {
    return {
      if (config.apiKey != null) 'x-api-key': config.apiKey!,
      'anthropic-version': anthropicVersion,
    };
  }

  // ── Request transform ────────────────────────────────────────

  @override
  Map<String, dynamic> transformRequest(Map<String, dynamic> canonicalJson) {
    final messages =
        (canonicalJson['messages'] as List?)?.cast<Map<String, dynamic>>() ??
            [];

    // Extract system messages into top-level `system` field.
    final systemParts = <String>[];
    final nonSystemMessages = <Map<String, dynamic>>[];

    for (final msg in messages) {
      if (msg['role'] == 'system') {
        systemParts.add(msg['content'] as String);
      } else {
        nonSystemMessages.add(_transformMessage(msg));
      }
    }

    final result = <String, dynamic>{
      'model': canonicalJson['model'],
      'messages': nonSystemMessages,
      'max_tokens': canonicalJson['max_tokens'] ?? 4096,
    };

    if (systemParts.isNotEmpty) {
      result['system'] = systemParts.join('\n\n');
    }

    if (canonicalJson['temperature'] != null) {
      result['temperature'] = canonicalJson['temperature'];
    }
    if (canonicalJson['top_p'] != null) {
      result['top_p'] = canonicalJson['top_p'];
    }
    if (canonicalJson['stream'] == true) {
      result['stream'] = true;
    }

    // Transform tools
    if (canonicalJson['tools'] != null) {
      final tools = (canonicalJson['tools'] as List).cast<Map<String, dynamic>>();
      result['tools'] = tools.map(_transformToolDef).toList();
    }

    return result;
  }

  Map<String, dynamic> _transformMessage(Map<String, dynamic> msg) {
    final role = msg['role'] as String;

    // Tool result messages: OpenAI `tool` role → Anthropic `user` + tool_result block
    if (role == 'tool') {
      return {
        'role': 'user',
        'content': [
          {
            'type': 'tool_result',
            'tool_use_id': msg['tool_call_id'],
            'content': msg['content'],
          }
        ],
      };
    }

    // Assistant messages with tool_calls → content blocks
    if (role == 'assistant' && msg['tool_calls'] != null) {
      final content = <Map<String, dynamic>>[];

      // Leading text content (if any)
      final textContent = msg['content'] as String?;
      if (textContent != null && textContent.isNotEmpty) {
        content.add({'type': 'text', 'text': textContent});
      }

      for (final tc in (msg['tool_calls'] as List)) {
        final tcMap = tc as Map<String, dynamic>;
        final fn = tcMap['function'] as Map<String, dynamic>;
        content.add({
          'type': 'tool_use',
          'id': tcMap['id'],
          'name': fn['name'],
          'input': fn['arguments'] is String
              ? jsonDecode(fn['arguments'] as String)
              : fn['arguments'],
        });
      }

      return {'role': 'assistant', 'content': content};
    }

    // Regular messages
    return {'role': role, 'content': msg['content']};
  }

  Map<String, dynamic> _transformToolDef(Map<String, dynamic> tool) {
    final fn = tool['function'] as Map<String, dynamic>;
    return {
      'name': fn['name'],
      if (fn['description'] != null) 'description': fn['description'],
      'input_schema': fn['parameters'] ?? {'type': 'object', 'properties': {}},
    };
  }

  // ── Response transform ───────────────────────────────────────

  @override
  Map<String, dynamic> transformResponse(Map<String, dynamic> wireJson) {
    final contentBlocks =
        (wireJson['content'] as List?)?.cast<Map<String, dynamic>>() ?? [];

    // Collect text content
    final textParts = contentBlocks
        .where((b) => b['type'] == 'text')
        .map((b) => b['text'] as String)
        .toList();

    // Collect tool_use blocks → OpenAI tool_calls
    final toolUseBlocks =
        contentBlocks.where((b) => b['type'] == 'tool_use').toList();

    final message = <String, dynamic>{
      'role': 'assistant',
      'content': textParts.join(),
    };

    if (toolUseBlocks.isNotEmpty) {
      message['tool_calls'] = toolUseBlocks.map((b) {
        return {
          'id': b['id'],
          'type': 'function',
          'function': {
            'name': b['name'],
            'arguments': jsonEncode(b['input']),
          },
        };
      }).toList();
    }

    // Map stop_reason
    final stopReason = wireJson['stop_reason'] as String?;
    final finishReason = _mapStopReason(stopReason);

    return {
      'id': wireJson['id'] ?? '',
      'object': 'chat.completion',
      'created': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'model': wireJson['model'] ?? '',
      'choices': [
        {
          'index': 0,
          'message': message,
          'finish_reason': finishReason,
        }
      ],
      if (wireJson['usage'] != null)
        'usage': {
          'prompt_tokens': wireJson['usage']['input_tokens'] ?? 0,
          'completion_tokens': wireJson['usage']['output_tokens'] ?? 0,
          'total_tokens': (wireJson['usage']['input_tokens'] ?? 0) +
              (wireJson['usage']['output_tokens'] ?? 0),
        },
    };
  }

  String _mapStopReason(String? reason) {
    switch (reason) {
      case 'end_turn':
        return 'stop';
      case 'max_tokens':
        return 'length';
      case 'tool_use':
        return 'tool_calls';
      case 'stop_sequence':
        return 'stop';
      default:
        return reason ?? 'stop';
    }
  }

  // ── SSE parsing ──────────────────────────────────────────────

  /// Anthropic streams JSON objects prefixed with `data: `, each
  /// containing a `type` field that determines the event kind.
  @override
  Map<String, dynamic>? parseStreamLine(String line) {
    if (!line.startsWith('data: ')) return null;
    final data = line.substring(6);

    final json = jsonDecode(data) as Map<String, dynamic>;
    final type = json['type'] as String?;

    switch (type) {
      case 'message_start':
        // Initial message metadata — skip as chunk content.
        return null;

      case 'content_block_start':
        final block = json['content_block'] as Map<String, dynamic>?;
        if (block != null && block['type'] == 'tool_use') {
          return _buildStreamChunk(
            toolCallDelta: {
              'index': json['index'] ?? 0,
              'id': block['id'],
              'type': 'function',
              'function': {
                'name': block['name'],
                'arguments': '',
              },
            },
          );
        }
        return null;

      case 'content_block_delta':
        final delta = json['delta'] as Map<String, dynamic>?;
        if (delta == null) return null;

        if (delta['type'] == 'text_delta') {
          return _buildStreamChunk(content: delta['text'] as String?);
        }
        if (delta['type'] == 'input_json_delta') {
          return _buildStreamChunk(
            toolCallDelta: {
              'index': json['index'] ?? 0,
              'function': {
                'arguments': delta['partial_json'] ?? '',
              },
            },
          );
        }
        return null;

      case 'content_block_stop':
        return null;

      case 'message_delta':
        final delta = json['delta'] as Map<String, dynamic>?;
        final stopReason = delta?['stop_reason'] as String?;
        if (stopReason != null) {
          return _buildStreamChunk(
            finishReason: _mapStopReason(stopReason),
          );
        }
        return null;

      case 'message_stop':
        throw const StreamDoneSignal();

      case 'ping':
        return null;

      default:
        return null;
    }
  }

  Map<String, dynamic> _buildStreamChunk({
    String? content,
    String? finishReason,
    Map<String, dynamic>? toolCallDelta,
  }) {
    final delta = <String, dynamic>{};
    if (content != null) delta['content'] = content;
    if (toolCallDelta != null) delta['tool_calls'] = [toolCallDelta];

    return {
      'id': '',
      'object': 'chat.completion.chunk',
      'created': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'model': '',
      'choices': [
        {
          'index': 0,
          'delta': delta,
          if (finishReason != null) 'finish_reason': finishReason,
        }
      ],
    };
  }

  // ── Models list ──────────────────────────────────────────────

  @override
  List<String> parseModelsResponse(Map<String, dynamic> wireJson) {
    final data = wireJson['data'] as List?;
    if (data == null) return [];
    return data.map((m) => m['id'] as String).toList();
  }
}
