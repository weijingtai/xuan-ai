import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'tables/tables.dart';
import 'connection.dart' as impl;

// DAOs
import 'daos/llm_providers_dao.dart';
import 'daos/llm_models_dao.dart';
import 'daos/prompt_templates_dao.dart';
import 'daos/prompt_versions_dao.dart';
import 'daos/prompt_skill_bindings_dao.dart';
import 'daos/ai_personas_dao.dart';
import 'daos/ai_chat_sessions_dao.dart';
import 'daos/ai_chat_messages_dao.dart';
import 'daos/ai_api_calls_dao.dart';
import 'daos/ai_provenances_dao.dart';
import 'daos/ai_divinations_dao.dart';
import 'daos/agent_invocations_dao.dart';
import 'daos/ai_usage_audits_dao.dart';
import 'daos/ai_tools_dao.dart';

part 'ai_database.g.dart';

@DriftDatabase(
  tables: [
    // LLM Configuration
    LlmProviders,
    LlmModels,
    // Prompt Management
    PromptTemplates,
    PromptVersions,
    PromptSkillBindings,
    // AI Persona
    AiPersonas,
    // Chat Management
    AiChatSessions,
    AiChatMessages,
    AiApiCalls,
    // Provenance
    AiProvenances,
    // AI Divination Results
    AiDivinations,
    // Agent Invocations
    AgentInvocations,
    // Audit
    AiUsageAudits,
    // Tools
    AiTools,
  ],
  daos: [
    LlmProvidersDao,
    LlmModelsDao,
    PromptTemplatesDao,
    PromptVersionsDao,
    PromptSkillBindingsDao,
    AiPersonasDao,
    AiChatSessionsDao,
    AiChatMessagesDao,
    AiApiCallsDao,
    AiProvenancesDao,
    AiDivinationsDao,
    AgentInvocationsDao,
    AiUsageAuditsDao,
    AiToolsDao,
  ],
)
class AiDatabase extends _$AiDatabase {
  AiDatabase([QueryExecutor? e])
      : super(
          e ??
              driftDatabase(
                name: 'ai_database',
                native: const DriftNativeOptions(
                  databaseDirectory: getApplicationSupportDirectory,
                ),
                web: DriftWebOptions(
                  sqlite3Wasm: Uri.parse('sqlite3.wasm'),
                  driftWorker: Uri.parse('drift_worker.js'),
                  onResult: (result) {
                    if (result.missingFeatures.isNotEmpty) {
                      if (kDebugMode) {
                        debugPrint(
                          'Using ${result.chosenImplementation} due to unsupported '
                          'browser features: ${result.missingFeatures}',
                        );
                      }
                    }
                  },
                ),
              ),
        );

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _seedDefaultData();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Future migrations will be handled here
      },
      beforeOpen: (details) async {
        // Validate schema in debug mode
        await impl.validateDatabaseSchema(this);
      },
    );
  }

  /// Seed default data on first run
  Future<void> _seedDefaultData() async {
    // Seed a default OpenAI-compatible provider
    final defaultProviderUuid = 'default-openai-compatible';
    await into(llmProviders).insert(
      LlmProvidersCompanion.insert(
        uuid: defaultProviderUuid,
        name: 'OpenAI Compatible',
        providerType: 'openai_compatible',
        baseUrl: 'https://api.openai.com/v1',
        isDefault: const Value(true),
        createdAt: DateTime.now(),
      ),
    );

    // Seed a default model
    final defaultModelUuid = 'default-gpt-4';
    await into(llmModels).insert(
      LlmModelsCompanion.insert(
        uuid: defaultModelUuid,
        providerUuid: defaultProviderUuid,
        modelId: 'gpt-4',
        displayName: 'GPT-4',
        modelType: 'chat',
        isDefault: const Value(true),
        supportsFunctionCalling: const Value(true),
        createdAt: DateTime.now(),
      ),
    );

    // Seed a default system prompt template
    final systemPromptUuid = 'default-divination-system-prompt';
    await into(promptTemplates).insert(
      PromptTemplatesCompanion.insert(
        uuid: systemPromptUuid,
        name: '默认占测系统提示词',
        templateType: 'system',
        content: '''你是一位精通中华传统玄学的占测大师，拥有深厚的易学功底和丰富的实践经验。

你的专长包括：
- 奇门遁甲（Qimen Dunjia）
- 七政四余（Seven Luminaries Four Residues）
- 太乙神数（Taiyi Sacred Numbers）
- 大六壬（Da Liu Ren）
- 八字命理（BaZi/Four Pillars）

在解读占测结果时，请遵循以下原则：
1. 准确解读式盘中的各种符号和关系
2. 结合具体问题给出针对性的分析
3. 用通俗易懂的语言解释深奥的玄学概念
4. 既要尊重传统，也要结合现代生活
5. 给出建设性的建议而非绝对的论断

请记住：占测是一门需要综合考量的艺术，需要结合天时、地利、人和等多方因素。''',
        isBuiltin: const Value(true),
        createdAt: DateTime.now(),
      ),
    );

    // Seed a default AI persona
    await into(aiPersonas).insert(
      AiPersonasCompanion.insert(
        uuid: 'default-master',
        name: '玄机子',
        description: '一位和蔼可亲、学识渊博的占测大师，擅长将深奥的玄学知识用通俗易懂的方式讲解。',
        modelUuid: defaultModelUuid,
        systemPromptUuid: Value(systemPromptUuid),
        isDefault: const Value(true),
        createdAt: DateTime.now(),
      ),
    );
  }
}
