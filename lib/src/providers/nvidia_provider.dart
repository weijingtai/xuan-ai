import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

/// A provider that integrates with NVIDIA NIM API.
/// This also follows the OpenAI compatible chat completion format.
class NvidiaProvider extends ChangeNotifier implements LlmProvider {
  NvidiaProvider({
    required this.apiKey,
    this.model = 'meta/llama3-70b-instruct', // Default to a popular NIM model
    this.baseUrl = 'https://integrate.api.nvidia.com/v1',
    this.temperature = 0.5,
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

    final stream = _streamRequest(messages);

    await for (final chunk in stream) {
      if (chunk.isNotEmpty) {
        responseMessage.append(chunk);
        notifyListeners();
        yield chunk;
      }
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
          'max_tokens': 1024,
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
            // Ignore for now
          }
        }
      }
    } catch (e) {
      yield 'Error: $e';
    }
  }
}
