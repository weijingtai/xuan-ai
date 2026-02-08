import 'dart:async';
import 'dart:convert';
import 'package:uuid/uuid.dart';

import '../../database/ai_database.dart';
import '../../models/models.dart';
import 'llm_client.dart';
import 'openai_compatible_client.dart';

/// LLM Service - manages LLM providers and executes requests
class LlmService {
  final AiDatabase _db;
  final Map<String, LlmClient> _clients = {};
  final Uuid _uuid = const Uuid();

  LlmService(this._db);

  /// Get or create a client for a provider
  Future<LlmClient> _getClient(String providerUuid) async {
    if (_clients.containsKey(providerUuid)) {
      return _clients[providerUuid]!;
    }

    final provider = await _db.llmProvidersDao.getByUuid(providerUuid);
    if (provider == null) {
      throw Exception('Provider not found: $providerUuid');
    }

    final client = OpenAICompatibleClient(
      config: LlmClientConfig(
        baseUrl: provider.baseUrl,
        apiKey: provider.encryptedApiKey, // TODO: Decrypt
      ),
    );

    _clients[providerUuid] = client;
    return client;
  }

  /// Execute a chat completion request
  Future<LlmResponseModel> chatCompletion({
    required String modelUuid,
    required List<ChatMessageModel> messages,
    double? temperature,
    double? topP,
    int? maxTokens,
    List<ToolDefinition>? tools,
    String? sessionUuid,
  }) async {
    final model = await _db.llmModelsDao.getByUuid(modelUuid);
    if (model == null) {
      throw Exception('Model not found: $modelUuid');
    }

    final client = await _getClient(model.providerUuid);
    final apiCallUuid = _uuid.v4();

    // Create API call record
    final request = LlmRequestModel(
      model: model.modelId,
      messages: messages,
      temperature: temperature,
      topP: topP,
      maxTokens: maxTokens ?? model.maxOutputTokens,
      stream: false,
      tools: tools,
    );

    await _db.aiApiCallsDao.createCall(
      uuid: apiCallUuid,
      modelUuid: modelUuid,
      requestJson: jsonEncode(request.toJson()),
      sessionUuid: sessionUuid,
    );

    final startTime = DateTime.now();

    try {
      final response = await client.chatCompletion(request);
      final latency = DateTime.now().difference(startTime).inMilliseconds;

      // Update API call with response
      await _db.aiApiCallsDao.updateWithResponse(
        uuid: apiCallUuid,
        responseJson: jsonEncode(response.toJson()),
        status: 'success',
        inputTokens: response.usage?.promptTokens,
        outputTokens: response.usage?.completionTokens,
        totalTokens: response.usage?.totalTokens,
        latencyMs: latency,
      );

      // Log audit
      await _db.aiUsageAuditsDao.logApiCall(
        apiCallUuid: apiCallUuid,
        action: 'chat_completion',
        tokensUsed: response.usage?.totalTokens,
      );

      return response;
    } catch (e) {
      await _db.aiApiCallsDao.markError(apiCallUuid, e.toString());
      rethrow;
    }
  }

  /// Execute a streaming chat completion request
  Stream<StreamChunkModel> streamChatCompletion({
    required String modelUuid,
    required List<ChatMessageModel> messages,
    double? temperature,
    double? topP,
    int? maxTokens,
    List<ToolDefinition>? tools,
    String? sessionUuid,
  }) async* {
    final model = await _db.llmModelsDao.getByUuid(modelUuid);
    if (model == null) {
      throw Exception('Model not found: $modelUuid');
    }

    final client = await _getClient(model.providerUuid);
    final apiCallUuid = _uuid.v4();

    final request = LlmRequestModel(
      model: model.modelId,
      messages: messages,
      temperature: temperature,
      topP: topP,
      maxTokens: maxTokens ?? model.maxOutputTokens,
      stream: true,
      tools: tools,
    );

    await _db.aiApiCallsDao.createCall(
      uuid: apiCallUuid,
      modelUuid: modelUuid,
      requestJson: jsonEncode(request.toJson()),
      sessionUuid: sessionUuid,
      isStreaming: true,
    );

    final startTime = DateTime.now();
    final contentBuffer = StringBuffer();
    int? inputTokens;
    int? outputTokens;

    try {
      await for (final chunk in client.streamChatCompletion(request)) {
        if (chunk.deltaContent != null) {
          contentBuffer.write(chunk.deltaContent);
        }
        yield chunk;

        if (chunk.isComplete) {
          break;
        }
      }

      final latency = DateTime.now().difference(startTime).inMilliseconds;

      await _db.aiApiCallsDao.updateWithResponse(
        uuid: apiCallUuid,
        responseJson: jsonEncode({'content': contentBuffer.toString()}),
        status: 'success',
        inputTokens: inputTokens,
        outputTokens: outputTokens,
        latencyMs: latency,
      );
    } catch (e) {
      await _db.aiApiCallsDao.markError(apiCallUuid, e.toString());
      rethrow;
    }
  }

  /// Get the default model
  Future<LlmModel?> getDefaultModel() async {
    return await _db.llmModelsDao.getDefault();
  }

  /// Test provider connection
  Future<bool> testConnection(String providerUuid) async {
    final client = await _getClient(providerUuid);
    return await client.testConnection();
  }

  /// Dispose all clients
  void dispose() {
    for (final client in _clients.values) {
      client.dispose();
    }
    _clients.clear();
  }
}
