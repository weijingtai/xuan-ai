import 'package:ai_core/ai_core.dart';
import 'package:common/database/app_database.dart' as common_db;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceLocator {
  final AiDatabase db;
  final common_db.AppDatabase appDb;
  final LlmService llmService;
  final PromptService promptService;
  final ChatPersistenceService persistenceService;
  final ChatService chatService;
  final ToolRegistry toolRegistry;

  ServiceLocator._({
    required this.db,
    required this.appDb,
    required this.llmService,
    required this.promptService,
    required this.persistenceService,
    required this.chatService,
    required this.toolRegistry,
  });

  static Future<ServiceLocator> initialize() async {
    final db = AiDatabase();
    final appDb = common_db.AppDatabase();

    final llmService = LlmService(db);
    final promptService = PromptService(db);
    final persistenceService = ChatPersistenceService(db);
    final toolRegistry = ToolRegistry();

    // Register example tool
    _registerExampleTools(toolRegistry);

    final chatService = ChatService(
      db: db,
      llmService: llmService,
      promptService: promptService,
      persistenceService: persistenceService,
      toolRegistry: toolRegistry,
    );

    return ServiceLocator._(
      db: db,
      appDb: appDb,
      llmService: llmService,
      promptService: promptService,
      persistenceService: persistenceService,
      chatService: chatService,
      toolRegistry: toolRegistry,
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
    final provider = await db.llmProvidersDao.getDefault();
    if (provider != null) {
      await db.llmProvidersDao.updateApiKey(provider.uuid, apiKey);
    }

    // Save to SharedPreferences for persistence across restarts
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_key', apiKey);
    await prefs.setString('base_url', baseUrl);
  }

  /// Load saved settings
  static Future<Map<String, String>> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'api_key': prefs.getString('api_key') ?? '',
      'base_url': prefs.getString('base_url') ?? 'https://api.openai.com/v1',
    };
  }
}
