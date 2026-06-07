import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import 'package:persistence_drift/ai/ai_database.dart';
import '../../models/models.dart';
import 'llm_client.dart';
import 'openai_compatible_client.dart';
import 'protocol_adapter.dart';
import 'adapters/openai_adapter.dart';
import 'adapters/anthropic_adapter.dart';
import 'adapters/gemini_adapter.dart';

/// LLM Service - manages LLM providers and executes requests
class LlmService {
  final AiDatabase _db;
  final Map<String, LlmClient> _clients = {};
  final Uuid _uuid = const Uuid();
  final Logger _logger = Logger();

  LlmService(this._db);

  /// Get or create a client for a provider
  Future<LlmClient> _getClient(String providerUuid) async {
    if (_clients.containsKey(providerUuid)) {
      _logger.d('[LlmService] Reusing cached client for provider $providerUuid');
      return _clients[providerUuid]!;
    }

    _logger.d('[LlmService] Creating new client for provider $providerUuid');
    final provider = await _db.llmProvidersDao.getByUuid(providerUuid);
    if (provider == null) {
      _logger.e('[LlmService] Provider not found: $providerUuid');
      throw Exception('Provider not found: $providerUuid');
    }

    final adapter = _createAdapter(provider.configJson);
    _logger.d('[LlmService] Created adapter ${adapter.runtimeType} '
        'for provider "${provider.name}" (baseUrl: ${provider.baseUrl})');

    final client = OpenAICompatibleClient(
      config: LlmClientConfig(
        baseUrl: provider.baseUrl,
        apiKey: provider.encryptedApiKey, // TODO: Decrypt
      ),
      adapter: adapter,
    );

    _clients[providerUuid] = client;
    return client;
  }

  /// Create a [ProtocolAdapter] based on the provider's `configJson`.
  ///
  /// Recognised adapter types:
  /// - `"openai"` (or absent) → [OpenAIAdapter]
  /// - `"anthropic"` → [AnthropicAdapter]
  /// - `"gemini"` → [GeminiAdapter]
  ProtocolAdapter _createAdapter(String? configJsonStr) {
    if (configJsonStr == null || configJsonStr.isEmpty) {
      return OpenAIAdapter();
    }

    final config = jsonDecode(configJsonStr) as Map<String, dynamic>;
    final adapterType = config['adapter'] as String?;

    switch (adapterType) {
      case 'anthropic':
        return AnthropicAdapter(
          anthropicVersion:
              config['anthropic_version'] as String? ?? '2023-06-01',
        );
      case 'gemini':
        return GeminiAdapter(
          useApiKeyAuth: config['use_api_key_auth'] as bool? ?? true,
        );
      case 'openai':
      default:
        return OpenAIAdapter();
    }
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

  /// Fetch the list of models available on the remote provider.
  Future<List<RemoteModelInfo>> fetchRemoteModels(
      String providerUuid) async {
    _logger.d('[LlmService] fetchRemoteModels: provider=$providerUuid');
    final client = await _getClient(providerUuid);
    try {
      final models = await client.listModelsDetailed();
      _logger.i('[LlmService] fetchRemoteModels: got ${models.length} models '
          'from provider $providerUuid');
      for (final m in models) {
        _logger.d('[LlmService]   remote model: id=${m.id}, '
            'ownedBy=${m.ownedBy}, created=${m.created}');
      }
      return models;
    } catch (e, st) {
      _logger.e('[LlmService] fetchRemoteModels failed for provider '
          '$providerUuid', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// Fetch detailed info for a single remote model.
  Future<RemoteModelInfo> fetchModelDetail(
      String providerUuid, String modelId) async {
    _logger.d('[LlmService] fetchModelDetail: provider=$providerUuid, '
        'modelId=$modelId');
    final client = await _getClient(providerUuid);
    try {
      final detail = await client.getModelDetail(modelId);
      _logger.i('[LlmService] fetchModelDetail: id=${detail.id}, '
          'ownedBy=${detail.ownedBy}, created=${detail.created}');
      return detail;
    } catch (e, st) {
      _logger.e('[LlmService] fetchModelDetail failed for '
          '$modelId on provider $providerUuid', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// Sync models from the remote provider into the local database.
  ///
  /// For multi-catalog providers (e.g. NVIDIA NIM) whose `/models` endpoint
  /// returns hundreds of non-LLM models, only IDs matching
  /// [_allowedModelPrefixes] are kept.  For single-vendor providers
  /// (e.g. DeepSeek, Moonshot) all models are synced as-is.
  ///
  /// Returns the number of newly inserted models.
  Future<int> syncModelsFromRemote(String providerUuid) async {
    _logger.i('[LlmService] syncModelsFromRemote: starting for '
        'provider $providerUuid');
    final remoteModels = await fetchRemoteModels(providerUuid);
    final localModels =
        await _db.llmModelsDao.getAllByProvider(providerUuid);
    final existingIds = localModels.map((m) => m.modelId).toSet();

    final provider = await _db.llmProvidersDao.getByUuid(providerUuid);
    final needsFilter = _isMultiCatalogProvider(provider?.baseUrl);

    final modelsToSync = needsFilter
        ? remoteModels.where((m) => _isChatModel(m.id)).toList()
        : remoteModels;
    _logger.d('[LlmService] syncModelsFromRemote: ${remoteModels.length} '
        'remote total, ${modelsToSync.length} after filter '
        '(filtered=$needsFilter), '
        '${localModels.length} local (existing ids: $existingIds)');

    var added = 0;
    for (final remote in modelsToSync) {
      if (existingIds.contains(remote.id)) {
        _logger.d('[LlmService] syncModelsFromRemote: skipping '
            '"${remote.id}" (already exists locally)');
        continue;
      }

      final modelUuid = _uuid.v4();
      _logger.d('[LlmService] syncModelsFromRemote: inserting new model '
          '"${remote.id}" as uuid=$modelUuid');
      await _db.llmModelsDao.upsert(
        LlmModelsCompanion(
          uuid: Value(modelUuid),
          providerUuid: Value(providerUuid),
          modelId: Value(remote.id),
          displayName: Value(remote.id),
          modelType: const Value('chat'),
          createdAt: Value(DateTime.now()),
          lastUpdatedAt: Value(DateTime.now()),
        ),
      );
      added++;
    }
    _logger.i('[LlmService] syncModelsFromRemote: completed for '
        'provider $providerUuid — added $added new model(s)');
    return added;
  }

  // ---------------------------------------------------------------------------
  // Model ID filtering (applied only to multi-catalog providers)
  // ---------------------------------------------------------------------------

  /// Base-URL patterns that host a multi-vendor model catalog and need
  /// client-side filtering (e.g. NVIDIA NIM, OpenRouter).
  static const _multiCatalogHosts = [
    'integrate.api.nvidia.com',
    'api.nvidia.com',
    'openrouter.ai',
  ];

  /// Returns `true` if the provider's [baseUrl] points to a multi-catalog
  /// host that requires model filtering.
  static bool _isMultiCatalogProvider(String? baseUrl) {
    if (baseUrl == null) return false;
    final lower = baseUrl.toLowerCase();
    return _multiCatalogHosts.any((h) => lower.contains(h));
  }

  /// Allowed model-id prefixes for multi-catalog providers.  Only models
  /// whose ID starts with one of these are synced from providers like
  /// NVIDIA NIM.  Single-vendor providers bypass this filter entirely.
  static const _allowedModelPrefixes = [
    // DeepSeek
    'deepseek/',
    'deepseek-ai/',
    'deepseek-chat',
    'deepseek-reasoner',
    // Meta Llama
    'meta/llama',
    'meta/codellama',
    // NVIDIA LLMs
    'nvidia/llama',
    'nvidia/nemotron',
    // Qwen (Alibaba)
    'qwen/',
    'qwen2',
    'qwq',
    // MiniMax (NVIDIA org: minimaxai)
    'minimaxai/',
    'minimax/',
    'minimax-',
    'abab',
    // GLM (Zhipu AI — NVIDIA orgs: z-ai, thudm)
    'z-ai/',
    'glm',
    'zhipu/',
    'thudm/',
    // Kimi (Moonshot AI — NVIDIA org: moonshotai)
    'moonshotai/',
    'kimi',
    'moonshot/',
    'moonshot-',
    // Mistral AI
    'mistralai/',
    // Google (Gemma)
    'google/gemma',
    'google/codegemma',
    // Microsoft (Phi)
    'microsoft/phi',
    // Baichuan
    'baichuan',
    // ByteDance
    'bytedance/',
    // Yi (01.AI)
    '01-ai/',
    'yi-',
    // InternLM (Shanghai AI Lab)
    'internlm',
    // Cohere
    'cohere/',
    // AI21 Labs (Jamba)
    'ai21labs/',
    // Upstage (Solar)
    'upstage/',
    // Snowflake (Arctic)
    'snowflake/',
    // BigCode (StarCoder)
    'bigcode/',
    // AbacusAI
    'abacusai/',
    // AI Singapore (SEA-LION)
    'aisingapore/',
    // Falcon (TII)
    'tiiuae/',
  ];

  /// Non-LLM keywords — model IDs containing any of these are rejected
  /// even if they match a prefix above.
  static const _nonChatKeywords = [
    'embed',
    'rerank',
    'guard',
    'reward',
    'vlm',
    'vision',
    'vl',
    'audio',
    'speech',
    'tts',
    'asr',
    'ocr',
    'diffusion',
    'img',
    'image',
  ];

  /// Returns `true` if [modelId] looks like a chat / instruct LLM that
  /// we want to keep.
  static bool _isChatModel(String modelId) {
    final lower = modelId.toLowerCase();

    // Must match at least one allowed prefix.
    final prefixMatch =
        _allowedModelPrefixes.any((p) => lower.startsWith(p));
    if (!prefixMatch) return false;

    // Reject known non-chat model types.
    if (_nonChatKeywords.any((k) => lower.contains(k))) return false;

    return true;
  }

  /// Dispose all clients
  void dispose() {
    for (final client in _clients.values) {
      client.dispose();
    }
    _clients.clear();
  }
}
