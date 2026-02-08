import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

/// A provider that integrates with DeepSeek API.
class DeepSeekProvider extends ChangeNotifier implements LlmProvider {
  DeepSeekProvider({
    required this.apiKey,
    this.model = 'deepseek-chat',
    this.baseUrl = 'https://api.deepseek.com',
    this.temperature = 0.7,
    this.systemInstruction,
    List<ChatMessage>? history,
  }) : _history = history?.toList() ?? [];

  final String apiKey;
  final String model;
  final String baseUrl;
  final double temperature;
  final String? systemInstruction;

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
    // DeepSeek API doesn't support attachments (images/files) directly in standard chat yet,
    // or at least standard text models don't. We'll ignore attachments for now or handle text only.

    final messages = [
      if (systemInstruction != null && systemInstruction!.isNotEmpty)
        {'role': 'system', 'content': systemInstruction},
      {'role': 'user', 'content': prompt},
    ];

    yield* _streamRequest(messages);
  }

  @override
  Stream<String> sendMessageStream(
    String prompt, {
    Iterable<Attachment>? attachments,
  }) async* {
    // Add user message to history
    final userMessage = ChatMessage.user(prompt, attachments ?? []);
    _history.add(userMessage);
    notifyListeners();

    // Prepare messages for API
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

    // Create a placeholder for assistant response
    final responseMessage = ChatMessage.llm();
    _history.add(responseMessage);
    notifyListeners();

    // Stream response
    final stream = _streamRequest(messages);

    await for (final chunk in stream) {
      responseMessage.append(chunk);
      notifyListeners();
      yield chunk;
    }
  }

  Stream<String> _streamRequest(List<Map<String, dynamic>> messages) async* {
    try {
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
        data: {
          'model': model,
          'messages': messages,
          'stream': true,
          'temperature': temperature,
        },
      );

      final stream = response.data!.stream
          .cast<List<int>>()
          .transform(const Utf8Decoder())
          .transform(const LineSplitter());

      await for (final line in stream) {
        if (line.startsWith('data: ')) {
          final data = line.substring(6).trim();
          if (data == '[DONE]') break;

          try {
            final json = jsonDecode(data);
            final content =
                json['choices']?[0]?['delta']?['content'] as String?;
            if (content != null) {
              yield content;
            }
          } catch (e) {
            // Ignore parse errors for partial chunks
          }
        }
      }
    } catch (e) {
      // Handle error gracefully or rethrow
      yield 'Error: $e';
    }
  }
}
