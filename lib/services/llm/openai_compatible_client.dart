import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../models/llm_request_model.dart';
import '../../models/llm_response_model.dart';
import '../../models/remote_model_info.dart';
import 'llm_client.dart';
import 'protocol_adapter.dart';
import 'adapters/openai_adapter.dart';

/// LLM client that delegates all protocol-specific logic to a
/// [ProtocolAdapter], keeping HTTP and SSE plumbing in one place.
///
/// When no adapter is provided the [OpenAIAdapter] is used, which
/// passes requests and responses through unchanged — preserving
/// full backwards compatibility.
class OpenAICompatibleClient implements LlmClient {
  final LlmClientConfig config;
  final ProtocolAdapter adapter;
  final Dio _dio;
  final Logger _logger = Logger();

  OpenAICompatibleClient({
    required this.config,
    ProtocolAdapter? adapter,
  })  : adapter = adapter ?? OpenAIAdapter(),
        _dio = Dio(BaseOptions(
          baseUrl: config.baseUrl,
          connectTimeout: config.timeout,
          receiveTimeout: config.timeout,
          headers: {
            'Content-Type': 'application/json',
            ...?config.headers,
          },
          queryParameters: (adapter ?? OpenAIAdapter()).buildQueryParams(config),
        )) {
    // Apply adapter-specific auth headers
    _dio.options.headers.addAll(this.adapter.buildHeaders(config));
  }

  @override
  Future<LlmResponseModel> chatCompletion(LlmRequestModel request) async {
    try {
      final canonicalJson = request.toJson();
      canonicalJson['stream'] = false;

      final wireRequest = adapter.transformRequest(canonicalJson);
      final endpoint =
          adapter.resolveEndpoint(adapter.chatEndpoint, canonicalJson);

      final response = await _dio.post(endpoint, data: wireRequest);

      if (response.statusCode == 200) {
        final wireResponse = response.data as Map<String, dynamic>;
        final canonicalResponse = adapter.transformResponse(wireResponse);
        return LlmResponseModel.fromJson(canonicalResponse);
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
  Stream<StreamChunkModel> streamChatCompletion(
      LlmRequestModel request) async* {
    try {
      final canonicalJson = request.toJson();
      canonicalJson['stream'] = true;

      final wireRequest = adapter.transformRequest(canonicalJson);
      final endpoint =
          adapter.resolveEndpoint(adapter.streamEndpoint, canonicalJson);

      final response = await _dio.post<ResponseBody>(
        endpoint,
        data: wireRequest,
        options: Options(responseType: ResponseType.stream),
      );

      if (response.statusCode != 200) {
        throw LlmException(
          'API request failed with status ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }

      final stream = response.data!.stream;
      var buffer = '';

      await for (final chunk in stream) {
        buffer += utf8.decode(chunk);

        while (buffer.contains('\n')) {
          final lineEnd = buffer.indexOf('\n');
          final line = buffer.substring(0, lineEnd).trim();
          buffer = buffer.substring(lineEnd + 1);

          if (line.isEmpty) continue;

          try {
            final parsed = adapter.parseStreamLine(line);
            if (parsed != null) {
              yield StreamChunkModel.fromJson(parsed);
            }
          } on StreamDoneSignal {
            return;
          } catch (e) {
            _logger.w('Failed to parse SSE chunk: $line', error: e);
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
    final endpoint = adapter.modelsEndpoint;
    if (endpoint == null) {
      throw LlmException('This provider does not support listing models');
    }

    try {
      final response = await _dio.get(endpoint);
      if (response.statusCode == 200) {
        return adapter
            .parseModelsResponse(response.data as Map<String, dynamic>);
      }
      return [];
    } on DioException catch (e) {
      _logger.e('Failed to list models', error: e);
      return [];
    }
  }

  @override
  Future<List<RemoteModelInfo>> listModelsDetailed() async {
    final endpoint = adapter.modelsEndpoint;
    if (endpoint == null) {
      _logger.w('[Client] listModelsDetailed: adapter has no modelsEndpoint');
      throw LlmException('This provider does not support listing models');
    }

    _logger.d('[Client] listModelsDetailed: GET ${config.baseUrl}$endpoint');
    try {
      final response = await _dio.get(endpoint);
      _logger.d('[Client] listModelsDetailed: status=${response.statusCode}');
      if (response.statusCode == 200) {
        final models = adapter.parseModelsDetailedResponse(
            response.data as Map<String, dynamic>);
        _logger.d('[Client] listModelsDetailed: parsed ${models.length} models');
        return models;
      }
      throw LlmException(
        'Failed to list models (status ${response.statusCode})',
        statusCode: response.statusCode,
        body: response.data?.toString(),
      );
    } on DioException catch (e) {
      _logger.e('[Client] listModelsDetailed: DioException '
          'status=${e.response?.statusCode}, message=${e.message}',
          error: e);
      throw LlmException(
        e.message ?? 'Failed to list models',
        statusCode: e.response?.statusCode,
        body: e.response?.data?.toString(),
        cause: e,
      );
    }
  }

  @override
  Future<RemoteModelInfo> getModelDetail(String modelId) async {
    final endpoint = adapter.modelDetailEndpoint(modelId);
    if (endpoint == null) {
      _logger.w('[Client] getModelDetail: adapter has no modelDetailEndpoint');
      throw LlmException(
          'This provider does not support model detail queries');
    }

    _logger.d('[Client] getModelDetail: GET ${config.baseUrl}$endpoint');
    try {
      final response = await _dio.get(endpoint);
      _logger.d('[Client] getModelDetail: status=${response.statusCode}');
      if (response.statusCode == 200) {
        final detail = adapter
            .parseModelDetailResponse(response.data as Map<String, dynamic>);
        _logger.d('[Client] getModelDetail: parsed model id=${detail.id}, '
            'ownedBy=${detail.ownedBy}');
        return detail;
      }
      throw LlmException(
        'Failed to get model detail (status ${response.statusCode})',
        statusCode: response.statusCode,
        body: response.data?.toString(),
      );
    } on DioException catch (e) {
      _logger.e('[Client] getModelDetail($modelId): DioException '
          'status=${e.response?.statusCode}, message=${e.message}',
          error: e);
      throw LlmException(
        e.message ?? 'Failed to get model detail',
        statusCode: e.response?.statusCode,
        body: e.response?.data?.toString(),
        cause: e,
      );
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
