import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'tables/tables.dart';
import 'connection.dart' as impl;
import 'ai_schema.dart';

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
                  debugPrint(
                    '[AiDatabase] Web storage: ${result.chosenImplementation}',
                  );
                  if (result.missingFeatures.isNotEmpty) {
                    debugPrint(
                      '[AiDatabase] Missing features: ${result.missingFeatures}',
                    );
                  }
                },
              ),
            ),
      ) {
    // Register schema with central hub for Federated Repository pattern.
    registerAiSchema();
  }

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _seedDefaultData();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 3) {
          // Schema v3: remove providerType column from LlmProviders
          // Drop all and recreate for clean state
          final allTables = m.database.allTables.toList().reversed;
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
          }
          await m.createAll();
          await _seedDefaultData();
        }
      },
      beforeOpen: (details) async {
        debugPrint(
          '[AiDatabase] beforeOpen: wasCreated=${details.wasCreated}, '
          'hadUpgrade=${details.hadUpgrade}, '
          'versionBefore=${details.versionBefore}, '
          'versionNow=${details.versionNow}',
        );

        // Integrity check: detect corrupted database and rebuild if needed.
        // This can happen on Web when browser storage is not flushed properly.
        try {
          await impl.validateDatabaseSchema(this);
          // PRAGMA quick_check scans all tables/indices for corruption.
          // Unlike integrity_check it skips index cross-referencing, so it's
          // faster while still catching page-level corruption.
          final result =
              await customSelect('PRAGMA quick_check').get();
          final status = result.firstOrNull?.data['quick_check'] as String?;
          if (status != null && status != 'ok') {
            throw Exception('quick_check failed: $status');
          }
        } catch (e) {
          debugPrint('[AiDatabase] Database corruption detected: $e');
          debugPrint('[AiDatabase] Dropping all tables and re-creating...');
          final allTables = allSchemaEntities
              .whereType<TableInfo>()
              .toList()
              .reversed;
          for (final table in allTables) {
            await customStatement('DROP TABLE IF EXISTS "${table.actualTableName}"');
          }
          final m = createMigrator();
          await m.createAll();
          await _seedDefaultData();
          debugPrint('[AiDatabase] Database rebuilt successfully');
          return;
        }

        // Re-seed if default data is missing (e.g., previous seed failed)
        if (details.wasCreated || details.hadUpgrade) return;
        try {
          final defaultPersona =
              await (select(aiPersonas)
                    ..where((t) => t.isDefault.equals(true))
                    ..limit(1))
                  .getSingleOrNull();
          if (defaultPersona == null) {
            debugPrint('[AiDatabase] Default persona missing, re-seeding data');
            await _seedDefaultData();
          }
        } catch (e) {
          debugPrint('[AiDatabase] Error checking seed data: $e');
          debugPrint('[AiDatabase] Re-seeding as fallback...');
          await _seedDefaultData();
        }
      },
    );
  }

  /// Seed default data on first run
  Future<void> _seedDefaultData() async {
    const uuidGen = Uuid();

    // Seed DeepSeek Provider (Default)
    final deepSeekProviderUuid = uuidGen.v5(
      Namespace.url.value,
      'deepseek-provider',
    );
    await into(llmProviders).insert(
      LlmProvidersCompanion.insert(
        uuid: deepSeekProviderUuid,
        name: 'DeepSeek',
        baseUrl: 'https://api.deepseek.com',
        isDefault: const Value(true),
        createdAt: DateTime.now(),
      ),
      mode: InsertMode.insertOrIgnore,
    );

    // Seed NVIDIA Provider
    final nvidiaProviderUuid = uuidGen.v5(
      Namespace.url.value,
      'nvidia-provider',
    );
    await into(llmProviders).insert(
      LlmProvidersCompanion.insert(
        uuid: nvidiaProviderUuid,
        name: 'NVIDIA NIM',
        baseUrl: 'https://integrate.api.nvidia.com/v1',
        isDefault: const Value(false),
        createdAt: DateTime.now(),
      ),
      mode: InsertMode.insertOrIgnore,
    );

    // Seed DeepSeek Model (Default)
    final deepSeekModelUuid = uuidGen.v5(Namespace.url.value, 'deepseek-chat');
    await into(llmModels).insert(
      LlmModelsCompanion.insert(
        uuid: deepSeekModelUuid,
        providerUuid: deepSeekProviderUuid,
        modelId: 'deepseek-chat',
        displayName: 'DeepSeek V3',
        modelType: 'chat',
        isDefault: const Value(true),
        supportsFunctionCalling: const Value(true),
        createdAt: DateTime.now(),
      ),
      mode: InsertMode.insertOrIgnore,
    );

    // Seed NVIDIA Model
    final nvidiaModelUuid = uuidGen.v5(Namespace.url.value, 'nvidia-llama3');
    await into(llmModels).insert(
      LlmModelsCompanion.insert(
        uuid: nvidiaModelUuid,
        providerUuid: nvidiaProviderUuid,
        modelId: 'meta/llama3-70b-instruct',
        displayName: 'Llama 3 70B (NVIDIA)',
        modelType: 'chat',
        isDefault: const Value(false),
        supportsFunctionCalling: const Value(true),
        createdAt: DateTime.now(),
      ),
      mode: InsertMode.insertOrIgnore,
    );

    // Seed a default system prompt template
    final systemPromptUuid = uuidGen.v5(
      Namespace.url.value,
      'default-divination-system-prompt',
    );
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
      mode: InsertMode.insertOrIgnore,
    );

    // Seed a default AI persona
    final defaultPersonaUuid = uuidGen.v5(
      Namespace.url.value,
      'default-master',
    );
    await into(aiPersonas).insert(
      AiPersonasCompanion.insert(
        uuid: defaultPersonaUuid,
        name: '玄机子',
        description: const Value('一位和蔼可亲、学识渊博的占测大师，擅长将深奥的玄学知识用通俗易懂的方式讲解。'),
        modelUuid: deepSeekModelUuid,
        systemPromptUuid: Value(systemPromptUuid),
        isDefault: const Value(true),
        createdAt: DateTime.now(),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }
}
