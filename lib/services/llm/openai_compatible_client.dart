import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../models/llm_request_model.dart';
import '../../models/llm_response_model.dart';
import 'llm_client.dart';

/// OpenAI-compatible LLM client implementation
class OpenAICompatibleClient implements LlmClient {
  final LlmClientConfig config;
  final Dio _dio;
  final Logger _logger = Logger();

  OpenAICompatibleClient({required this.config})
      : _dio = Dio(BaseOptions(
          baseUrl: config.baseUrl,
          connectTimeout: config.timeout,
          receiveTimeout: config.timeout,
          headers: {
            'Content-Type': 'application/json',
            if (config.apiKey != null)
              'Authorization': 'Bearer ${config.apiKey}',
            ...?config.headers,
          },
        ));

  @override
  Future<LlmResponseModel> chatCompletion(LlmRequestModel request) async {
    try {
      final requestBody = request.toJson();
      // Ensure stream is false for non-streaming requests
      requestBody['stream'] = false;

      final response = await _dio.post(
        '/chat/completions',
        data: requestBody,
      );

      if (response.statusCode == 200) {
        return LlmResponseModel.fromJson(response.data);
      } else {
        throw LlmException(
          'API request failed with status ${response.statusCode}',
          statusCode: response.statusCode,
          body: response.data?.toString(),
        );
      }
    } on DioException catch (e) {
      _logger.e('LLM API error', error: e);
      throw LlmException(
        e.message ?? 'Unknown error',
        statusCode: e.response?.statusCode,
        body: e.response?.data?.toString(),
        cause: e,
      );
    }
  }

  @override
  Stream<StreamChunkModel> streamChatCompletion(LlmRequestModel request) async* {
    try {
      final requestBody = request.toJson();
      requestBody['stream'] = true;

      final response = await _dio.post<ResponseBody>(
        '/chat/completions',
        data: requestBody,
        options: Options(
          responseType: ResponseType.stream,
        ),
      );

      if (response.statusCode != 200) {
        throw LlmException(
          'API request failed with status ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }

      final stream = response.data!.stream;
      String buffer = '';

      await for (final chunk in stream) {
        buffer += utf8.decode(chunk);

        // Process SSE lines
        while (buffer.contains('\n')) {
          final lineEnd = buffer.indexOf('\n');
          final line = buffer.substring(0, lineEnd).trim();
          buffer = buffer.substring(lineEnd + 1);

          if (line.isEmpty) continue;
          if (line.startsWith('data: ')) {
            final data = line.substring(6);
            if (data == '[DONE]') {
              return;
            }

            try {
              final json = jsonDecode(data);
              yield StreamChunkModel.fromJson(json);
            } catch (e) {
              _logger.w('Failed to parse SSE chunk: $data', error: e);
            }
          }
        }
      }
    } on DioException catch (e) {
      _logger.e('LLM streaming error', error: e);
      throw LlmException(
        e.message ?? 'Streaming error',
        statusCode: e.response?.statusCode,
        cause: e,
      );
    }
  }

  @override
  Future<bool> testConnection() async {
    try {
      await listModels();
      return true;
    } catch (e) {
      _logger.e('Connection test failed', error: e);
      return false;
    }
  }

  @override
  Future<List<String>> listModels() async {
    try {
      final response = await _dio.get('/models');
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((m) => m['id'] as String).toList();
      }
      return [];
    } on DioException catch (e) {
      _logger.e('Failed to list models', error: e);
      return [];
    }
  }

  @override
  void dispose() {
    _dio.close();
  }
}

/// LLM exception
class LlmException implements Exception {
  final String message;
  final int? statusCode;
  final String? body;
  final Object? cause;

  LlmException(this.message, {this.statusCode, this.body, this.cause});

  @override
  String toString() {
    final sb = StringBuffer('LlmException: $message');
    if (statusCode != null) sb.write(' (status: $statusCode)');
    if (body != null) sb.write('\nBody: $body');
    return sb.toString();
  }
}
