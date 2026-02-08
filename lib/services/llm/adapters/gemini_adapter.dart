import 'dart:convert';

import '../protocol_adapter.dart';
import '../llm_client.dart';

/// Protocol adapter for the Google Gemini API.
///
/// Key differences from OpenAI format:
/// - Auth via `?key=` query parameter (or Bearer token).
/// - Endpoint includes model name: `/v1beta/models/{model}:generateContent`.
/// - Messages mapped to `contents[{role, parts}]` with `assistant` → `model`.
/// - System message mapped to `systemInstruction`.
/// - Tools mapped to `functionDeclarations`.
/// - Parameters mapped to `generationConfig`.
/// - SSE lines are JSON objects without `data:` prefix in some modes,
///   but the REST streaming endpoint wraps each in `data: `.
class GeminiAdapter extends ProtocolAdapter {
  final bool useApiKeyAuth;

  GeminiAdapter({this.useApiKeyAuth = true});

  @override
  String get chatEndpoint => '/v1beta/models/{model}:generateContent';

  @override
  String get streamEndpoint =>
      '/v1beta/models/{model}:streamGenerateContent?alt=sse';

  @override
  String? get modelsEndpoint => '/v1beta/models';

  // ── Headers ──────────────────────────────────────────────────

  @override
  Map<String, String> buildHeaders(LlmClientConfig config) {
    if (useApiKeyAuth) return {};
    return {
      if (config.apiKey != null) 'Authorization': 'Bearer ${config.apiKey}',
    };
  }

  @override
  Map<String, String> buildQueryParams(LlmClientConfig config) {
    if (useApiKeyAuth && config.apiKey != null) {
      return {'key': config.apiKey!};
    }
    return {};
  }

  // ── Endpoint resolution ──────────────────────────────────────

  @override
  String resolveEndpoint(String path, Map<String, dynamic> requestJson) {
    final model = requestJson['model'] as String? ?? '';
    return path.replaceAll('{model}', model);
  }

  // ── Request transform ────────────────────────────────────────

  @override
  Map<String, dynamic> transformRequest(Map<String, dynamic> canonicalJson) {
    final messages =
        (canonicalJson['messages'] as List?)?.cast<Map<String, dynamic>>() ??
            [];

    // Separate system messages
    final systemParts = <String>[];
    final contents = <Map<String, dynamic>>[];

    for (final msg in messages) {
      final role = msg['role'] as String;

      if (role == 'system') {
        systemParts.add(msg['content'] as String);
        continue;
      }

      contents.add(_transformMessage(msg));
    }

    final result = <String, dynamic>{
      'contents': contents,
    };

    if (systemParts.isNotEmpty) {
      result['systemInstruction'] = {
        'parts': [
          {'text': systemParts.join('\n\n')},
        ],
      };
    }

    // Generation config
    final genConfig = <String, dynamic>{};
    if (canonicalJson['temperature'] != null) {
      genConfig['temperature'] = canonicalJson['temperature'];
    }
    if (canonicalJson['top_p'] != null) {
      genConfig['topP'] = canonicalJson['top_p'];
    }
    if (canonicalJson['max_tokens'] != null) {
      genConfig['maxOutputTokens'] = canonicalJson['max_tokens'];
    }
    if (genConfig.isNotEmpty) {
      result['generationConfig'] = genConfig;
    }

    // Transform tools
    if (canonicalJson['tools'] != null) {
      final tools = (canonicalJson['tools'] as List).cast<Map<String, dynamic>>();
      final declarations = tools.map(_transformToolDef).toList();
      result['tools'] = [
        {'functionDeclarations': declarations},
      ];
    }

    return result;
  }

  Map<String, dynamic> _transformMessage(Map<String, dynamic> msg) {
    final role = msg['role'] as String;

    // Tool result: OpenAI `tool` role → Gemini `user` with functionResponse part
    if (role == 'tool') {
      return {
        'role': 'user',
        'parts': [
          {
            'functionResponse': {
              'name': msg['name'] ?? '',
              'response': {'result': msg['content']},
            },
          }
        ],
      };
    }

    // Assistant with tool_calls → model with functionCall parts
    if (role == 'assistant' && msg['tool_calls'] != null) {
      final parts = <Map<String, dynamic>>[];

      final textContent = msg['content'] as String?;
      if (textContent != null && textContent.isNotEmpty) {
        parts.add({'text': textContent});
      }

      for (final tc in (msg['tool_calls'] as List)) {
        final tcMap = tc as Map<String, dynamic>;
        final fn = tcMap['function'] as Map<String, dynamic>;
        parts.add({
          'functionCall': {
            'name': fn['name'],
            'args': fn['arguments'] is String
                ? jsonDecode(fn['arguments'] as String)
                : fn['arguments'],
          },
        });
      }

      return {'role': 'model', 'parts': parts};
    }

    // Map role: assistant → model
    final geminiRole = role == 'assistant' ? 'model' : role;

    return {
      'role': geminiRole,
      'parts': [
        {'text': msg['content'] ?? ''},
      ],
    };
  }

  Map<String, dynamic> _transformToolDef(Map<String, dynamic> tool) {
    final fn = tool['function'] as Map<String, dynamic>;
    return {
      'name': fn['name'],
      if (fn['description'] != null) 'description': fn['description'],
      if (fn['parameters'] != null) 'parameters': fn['parameters'],
    };
  }

  // ── Response transform ───────────────────────────────────────

  @override
  Map<String, dynamic> transformResponse(Map<String, dynamic> wireJson) {
    final candidates =
        (wireJson['candidates'] as List?)?.cast<Map<String, dynamic>>() ?? [];

    final choices = <Map<String, dynamic>>[];

    for (var i = 0; i < candidates.length; i++) {
      final candidate = candidates[i];
      final content =
          candidate['content'] as Map<String, dynamic>? ?? {};
      final parts =
          (content['parts'] as List?)?.cast<Map<String, dynamic>>() ?? [];

      final textParts =
          parts.where((p) => p.containsKey('text')).map((p) => p['text'] as String).toList();

      final functionCallParts =
          parts.where((p) => p.containsKey('functionCall')).toList();

      final message = <String, dynamic>{
        'role': 'assistant',
        'content': textParts.join(),
      };

      if (functionCallParts.isNotEmpty) {
        message['tool_calls'] = functionCallParts.map((p) {
          final fc = p['functionCall'] as Map<String, dynamic>;
          return {
            'id': 'call_${fc['name']}_$i',
            'type': 'function',
            'function': {
              'name': fc['name'],
              'arguments': jsonEncode(fc['args'] ?? {}),
            },
          };
        }).toList();
      }

      final finishReason = _mapFinishReason(
          candidate['finishReason'] as String?);

      choices.add({
        'index': i,
        'message': message,
        'finish_reason': finishReason,
      });
    }

    return {
      'id': '',
      'object': 'chat.completion',
      'created': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'model': wireJson['modelVersion'] ?? '',
      'choices': choices,
      if (wireJson['usageMetadata'] != null)
        'usage': {
          'prompt_tokens': wireJson['usageMetadata']['promptTokenCount'] ?? 0,
          'completion_tokens':
              wireJson['usageMetadata']['candidatesTokenCount'] ?? 0,
          'total_tokens':
              wireJson['usageMetadata']['totalTokenCount'] ?? 0,
        },
    };
  }

  String _mapFinishReason(String? reason) {
    switch (reason) {
      case 'STOP':
        return 'stop';
      case 'MAX_TOKENS':
        return 'length';
      case 'SAFETY':
        return 'content_filter';
      case 'RECITATION':
        return 'content_filter';
      default:
        return reason?.toLowerCase() ?? 'stop';
    }
  }

  // ── SSE parsing ──────────────────────────────────────────────

  @override
  Map<String, dynamic>? parseStreamLine(String line) {
    if (!line.startsWith('data: ')) return null;
    final data = line.substring(6);
    if (data == '[DONE]') throw const StreamDoneSignal();

    final wireJson = jsonDecode(data) as Map<String, dynamic>;

    // Gemini streams the same response shape as non-streaming
    // but incrementally — transform each chunk.
    final candidates =
        (wireJson['candidates'] as List?)?.cast<Map<String, dynamic>>() ?? [];

    if (candidates.isEmpty) return null;

    final candidate = candidates.first;
    final content =
        candidate['content'] as Map<String, dynamic>? ?? {};
    final parts =
        (content['parts'] as List?)?.cast<Map<String, dynamic>>() ?? [];

    final textParts = parts
        .where((p) => p.containsKey('text'))
        .map((p) => p['text'] as String)
        .toList();

    final functionCallParts =
        parts.where((p) => p.containsKey('functionCall')).toList();

    final delta = <String, dynamic>{};
    if (textParts.isNotEmpty) {
      delta['content'] = textParts.join();
    }
    if (functionCallParts.isNotEmpty) {
      delta['tool_calls'] = functionCallParts.asMap().entries.map((e) {
        final fc = e.value['functionCall'] as Map<String, dynamic>;
        return {
          'index': e.key,
          'id': 'call_${fc['name']}_${e.key}',
          'type': 'function',
          'function': {
            'name': fc['name'],
            'arguments': jsonEncode(fc['args'] ?? {}),
          },
        };
      }).toList();
    }

    final finishReason = candidate['finishReason'] as String?;

    return {
      'id': '',
      'object': 'chat.completion.chunk',
      'created': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'model': wireJson['modelVersion'] ?? '',
      'choices': [
        {
          'index': 0,
          'delta': delta,
          if (finishReason != null)
            'finish_reason': _mapFinishReason(finishReason),
        }
      ],
    };
  }

  // ── Models list ──────────────────────────────────────────────

  @override
  List<String> parseModelsResponse(Map<String, dynamic> wireJson) {
    final models = wireJson['models'] as List?;
    if (models == null) return [];
    return models
        .map((m) => (m['name'] as String?)?.replaceFirst('models/', '') ?? '')
        .where((n) => n.isNotEmpty)
        .toList();
  }
}
