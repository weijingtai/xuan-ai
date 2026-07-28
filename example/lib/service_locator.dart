import 'package:ai_core/ai_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:persistence_drift/ai/persistence_drift_ai.dart';

import 'secure_ai_secret_store.dart';

const String _kDeepSeekProviderUuidForExample = '50b69123-5735-4309-b695-188880628238';

class ServiceLocator {
  final AiDatabase db;
  final LlmService llmService;
  final PromptService promptService;
  final ChatPersistenceService persistenceService;
  final ChatService chatService;
  final ToolRegistry toolRegistry;
  final AiStorageDependencies storage;
  final AiSecretStore secrets;

  ServiceLocator._({
    required this.db,
    required this.llmService,
    required this.promptService,
    required this.persistenceService,
    required this.chatService,
    required this.toolRegistry,
    required this.storage,
    required this.secrets,
  });

  static Future<ServiceLocator> initialize() async {
    final db = AiDatabase();

    final llmService = LlmService(db);
    final promptService = PromptService(db);
    final persistenceService = ChatPersistenceService(db);
    final toolRegistry = ToolRegistry();

    // Register example tool
    _registerExampleTools(toolRegistry);

    // Build secure secret store + drift-backed adapters
    final secrets = SecureAiSecretStore();
    final chatHistory = DriftAiChatHistoryRepository(db);
    final config = DriftAiConfigRepository(db);
    final prompts = DriftAiPromptStore(db);
    final storage = AiStorageDependencies(
      chatHistory: chatHistory,
      config: config,
      prompts: prompts,
      secrets: secrets,
    );

    // One-time migration: move any legacy plaintext key out of SharedPreferences.
    final prefs = await SharedPreferences.getInstance();
    final legacyKey = prefs.getString('api_key');
    if (legacyKey != null && legacyKey.isNotEmpty) {
      await secrets.setApiKey(_kDeepSeekProviderUuidForExample, legacyKey);
      await prefs.remove('api_key');
    }
    // Read key back from secure store (migrated or newly stored).
    final _ = await secrets.getApiKey(_kDeepSeekProviderUuidForExample);
    await ensureDeepSeekProvider(db, apiKey: null); // never write the key into drift

    final chatService = ChatService(
      db: db,
      llmService: llmService,
      promptService: promptService,
      persistenceService: persistenceService,
      toolRegistry: toolRegistry,
    );

    return ServiceLocator._(
      db: db,
      llmService: llmService,
      promptService: promptService,
      persistenceService: persistenceService,
      chatService: chatService,
      toolRegistry: toolRegistry,
      storage: storage,
      secrets: secrets,
    );
  }

  static void _registerExampleTools(ToolRegistry registry) {
    // Register the example Qimen Dunjia skill interface
    final qimenSkill = QimenDunjiaSkillInterfaceExample();
    registry.registerSkill(qimenSkill.skillId, qimenSkill);
  }

  /// Update LLM provider settings (API key and base URL)
  static Future<void> updateProviderSettings(
    AiDatabase db, {
    required String apiKey,
    required String baseUrl,
  }) async {
    final secrets = SecureAiSecretStore();
    final provider = await db.llmProvidersDao.getDefault();
    if (provider != null) {
      await secrets.setApiKey(provider.uuid, apiKey);
    }

    // Save base_url to SharedPreferences (non-secret)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('base_url', baseUrl);
  }

  /// Load saved settings
  static Future<Map<String, String>> loadSettings() async {
    final secrets = SecureAiSecretStore();
    final prefs = await SharedPreferences.getInstance();
    const defaultProviderUuid = _kDeepSeekProviderUuidForExample;
    return {
      'api_key': await secrets.getApiKey(defaultProviderUuid) ?? '',
      'base_url': prefs.getString('base_url') ?? 'https://api.openai.com/v1',
    };
  }
}
