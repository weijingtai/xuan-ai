import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:logging/logging.dart';

/// Callback type for handling tool calls from the LLM.
///
/// Returns a JSON-encodable result map for the tool execution.
typedef ToolCallHandler = Future<Map<String, dynamic>> Function(
  String toolName,
  Map<String, dynamic> arguments,
);

/// A provider that integrates with DeepSeek API.
///
/// Supports OpenAI-compatible tool calling (function calling) via SSE streams.
class DeepSeekProvider extends ChangeNotifier implements LlmProvider {
  static final _log = Logger('DeepSeekProvider');

  DeepSeekProvider({
    required this.apiKey,
    this.model = 'deepseek-chat',
    this.baseUrl = 'https://api.deepseek.com',
    this.temperature = 0.7,
    this.systemInstruction,
    this.tools,
    this.onToolCall,
    List<ChatMessage>? history,
  }) : _history = history?.toList() ?? [];

  final String apiKey;
  final String model;
  final String baseUrl;
  final double temperature;
  final String? systemInstruction;

  /// Tool definitions in OpenAI function-calling format.
  final List<Map<String, dynamic>>? tools;

  /// Callback invoked when the LLM requests a tool call.
  final ToolCallHandler? onToolCall;

  List<ChatMessage> _history;
  final _dio = Dio();

  @override
  Iterable<ChatMessage> get history => List.unmodifiable(_history);

  @override
  set history(Iterable<ChatMessage> history) {
    _history = history.toList();
    notifyListeners();
  }

  @override
  Stream<String> generateStream(
    String prompt, {
    Iterable<Attachment>? attachments,
  }) async* {
    _log.info('[generateStream] prompt length=${prompt.length}');
    final messages = [
      if (systemInstruction != null && systemInstruction!.isNotEmpty)
        {'role': 'system', 'content': systemInstruction},
      {'role': 'user', 'content': prompt},
    ];

    yield* _streamWithToolLoop(messages);
  }

  @override
  Stream<String> sendMessageStream(
    String prompt, {
    Iterable<Attachment>? attachments,
  }) async* {
    _log.info('[sendMessageStream] prompt length=${prompt.length}, history=${_history.length} messages');
    final userMessage = ChatMessage.user(prompt, attachments ?? []);
    _history.add(userMessage);
    notifyListeners();

    final messages = [
      if (systemInstruction != null && systemInstruction!.isNotEmpty)
        {'role': 'system', 'content': systemInstruction},
      ..._history.map((msg) {
        return {
          'role': msg.origin.isUser ? 'user' : 'assistant',
          'content': msg.text ?? '',
        };
      }),
    ];

    final responseMessage = ChatMessage.llm();
    _history.add(responseMessage);
    notifyListeners();

    final stream = _streamWithToolLoop(messages);

    await for (final chunk in stream) {
      responseMessage.append(chunk);
      notifyListeners();
      yield chunk;
    }
  }

  /// Streams a request with automatic tool-call loop.
  ///
  /// If the LLM responds with `finish_reason == 'tool_calls'`, this method:
  /// 1. Pauses content streaming
  /// 2. Executes each tool via [onToolCall]
  /// 3. Appends tool results to messages
  /// 4. Initiates a new streaming request (continuation)
  Stream<String> _streamWithToolLoop(
    List<Map<String, dynamic>> messages,
  ) async* {
    // Make a mutable copy for the tool-call loop
    final loopMessages = List<Map<String, dynamic>>.from(messages);
    int iteration = 0;

    while (true) {
      iteration++;
      _log.fine('[_streamWithToolLoop] iteration=$iteration, messages=${loopMessages.length}');
      String? finishReason;
      final toolCallAccumulator = <int, _ToolCallAccum>{};
      final contentBuffer = StringBuffer();

      await for (final event in _streamRequest(loopMessages)) {
        if (event.isContent) {
          yield event.content!;
          contentBuffer.write(event.content!);
        } else if (event.isToolCallDelta) {
          _accumulateToolCall(toolCallAccumulator, event.toolCallDelta!);
        }
        if (event.finishReason != null) {
          finishReason = event.finishReason;
        }
      }

      _log.fine('[_streamWithToolLoop] iteration=$iteration finished, '
          'finishReason=$finishReason, '
          'toolCalls=${toolCallAccumulator.length}, '
          'contentLength=${contentBuffer.length}');

      // If no tool calls, we're done
      if (finishReason != 'tool_calls' || toolCallAccumulator.isEmpty) {
        _log.info('[_streamWithToolLoop] completed after $iteration iterations (no tool calls)');
        break;
      }

      // Handle tool calls
      if (onToolCall == null) {
        _log.warning('[_streamWithToolLoop] tool_calls requested but no handler registered');
        yield '\n[Tool call requested but no handler registered]';
        break;
      }

      _log.info('[_streamWithToolLoop] processing ${toolCallAccumulator.length} tool call(s)');

      // Add assistant message with tool_calls to loop messages
      final toolCallsJson = toolCallAccumulator.values
          .map((tc) => {
                'id': tc.id,
                'type': 'function',
                'function': {
                  'name': tc.name,
                  'arguments': tc.arguments,
                },
              })
          .toList();

      loopMessages.add({
        'role': 'assistant',
        if (contentBuffer.isNotEmpty) 'content': contentBuffer.toString(),
        'tool_calls': toolCallsJson,
      });

      // Execute each tool and append results
      for (final tc in toolCallAccumulator.values) {
        try {
          final args = jsonDecode(tc.arguments) as Map<String, dynamic>;
          _log.info('[_streamWithToolLoop] executing tool "${tc.name}" (id=${tc.id}), args keys=${args.keys.toList()}');
          final stopwatch = Stopwatch()..start();
          final result = await onToolCall!(tc.name, args);
          stopwatch.stop();
          _log.info('[_streamWithToolLoop] tool "${tc.name}" completed in ${stopwatch.elapsedMilliseconds}ms, result keys=${result.keys.toList()}');
          loopMessages.add({
            'role': 'tool',
            'tool_call_id': tc.id,
            'content': jsonEncode(result),
          });
        } catch (e) {
          _log.severe('[_streamWithToolLoop] tool "${tc.name}" failed: $e');
          loopMessages.add({
            'role': 'tool',
            'tool_call_id': tc.id,
            'content': jsonEncode({'error': e.toString()}),
          });
        }
      }

      // Loop continues — next iteration will send the updated messages
      _log.fine('[_streamWithToolLoop] continuing to next iteration with ${loopMessages.length} messages');
    }
  }

  /// Low-level SSE stream that yields [_StreamEvent]s for both content
  /// and tool_call deltas.
  Stream<_StreamEvent> _streamRequest(
    List<Map<String, dynamic>> messages,
  ) async* {
    try {
      final data = <String, dynamic>{
        'model': model,
        'messages': messages,
        'stream': true,
        'temperature': temperature,
      };

      // Include tools when available
      if (tools != null && tools!.isNotEmpty) {
        data['tools'] = tools;
        _log.fine('[_streamRequest] sending with ${tools!.length} tool definition(s)');
      }

      _log.info('[_streamRequest] POST $baseUrl/chat/completions, model=$model, messages=${messages.length}');

      final response = await _dio.post<ResponseBody>(
        '$baseUrl/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
            'Accept': 'text/event-stream',
          },
          responseType: ResponseType.stream,
        ),
        data: data,
      );

      _log.fine('[_streamRequest] SSE stream connected, parsing events...');

      final stream = response.data!.stream
          .cast<List<int>>()
          .transform(const Utf8Decoder())
          .transform(const LineSplitter());

      int chunkCount = 0;
      await for (final line in stream) {
        if (line.startsWith('data: ')) {
          final dataStr = line.substring(6).trim();
          if (dataStr == '[DONE]') {
            _log.fine('[_streamRequest] received [DONE] after $chunkCount chunks');
            break;
          }

          try {
            final json = jsonDecode(dataStr);
            final choice = json['choices']?[0];
            if (choice == null) continue;

            chunkCount++;
            final delta = choice['delta'];
            final reason = choice['finish_reason'] as String?;

            // Yield content delta
            final content = delta?['content'] as String?;
            if (content != null) {
              yield _StreamEvent(content: content);
            }

            // Yield tool_call deltas
            final toolCalls = delta?['tool_calls'] as List<dynamic>?;
            if (toolCalls != null) {
              _log.finest('[_streamRequest] chunk #$chunkCount has ${toolCalls.length} tool_call delta(s)');
              for (final tc in toolCalls) {
                yield _StreamEvent(
                  toolCallDelta: _ToolCallDelta(
                    index: tc['index'] as int? ?? 0,
                    id: tc['id'] as String?,
                    name: tc['function']?['name'] as String?,
                    argumentsChunk:
                        tc['function']?['arguments'] as String? ?? '',
                  ),
                );
              }
            }

            // Yield finish reason
            if (reason != null) {
              _log.fine('[_streamRequest] finish_reason=$reason at chunk #$chunkCount');
              yield _StreamEvent(finishReason: reason);
            }
          } catch (e) {
            _log.warning('[_streamRequest] parse error on chunk: $e');
          }
        }
      }
    } catch (e) {
      _log.severe('[_streamRequest] request failed: $e');
      yield _StreamEvent(content: 'Error: $e');
    }
  }

  /// Accumulates incremental tool_call deltas into complete tool calls.
  void _accumulateToolCall(
    Map<int, _ToolCallAccum> accumulator,
    _ToolCallDelta delta,
  ) {
    final existing = accumulator[delta.index];
    if (existing == null) {
      accumulator[delta.index] = _ToolCallAccum(
        id: delta.id ?? '',
        name: delta.name ?? '',
        arguments: delta.argumentsChunk,
      );
    } else {
      if (delta.id != null) existing.id = delta.id!;
      if (delta.name != null) existing.name = delta.name!;
      existing.arguments += delta.argumentsChunk;
    }
  }
}

/// Internal event type for SSE stream parsing.
class _StreamEvent {
  final String? content;
  final _ToolCallDelta? toolCallDelta;
  final String? finishReason;

  _StreamEvent({this.content, this.toolCallDelta, this.finishReason});

  bool get isContent => content != null;
  bool get isToolCallDelta => toolCallDelta != null;
}

/// Incremental tool_call delta from SSE.
class _ToolCallDelta {
  final int index;
  final String? id;
  final String? name;
  final String argumentsChunk;

  _ToolCallDelta({
    required this.index,
    this.id,
    this.name,
    required this.argumentsChunk,
  });
}

/// Accumulator for assembling a complete tool call from deltas.
class _ToolCallAccum {
  String id;
  String name;
  String arguments;

  _ToolCallAccum({
    required this.id,
    required this.name,
    required this.arguments,
  });
}
