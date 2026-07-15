// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_divinations_dao.dart';

// ignore_for_file: type=lint
mixin _$AiDivinationsDaoMixin on DatabaseAccessor<AiDatabase> {
  $LlmProvidersTable get llmProviders => attachedDatabase.llmProviders;
  $LlmModelsTable get llmModels => attachedDatabase.llmModels;
  $PromptTemplatesTable get promptTemplates => attachedDatabase.promptTemplates;
  $AiPersonasTable get aiPersonas => attachedDatabase.aiPersonas;
  $AiChatSessionsTable get aiChatSessions => attachedDatabase.aiChatSessions;
  $AiProvenancesTable get aiProvenances => attachedDatabase.aiProvenances;
  $AiDivinationsTable get aiDivinations => attachedDatabase.aiDivinations;
  AiDivinationsDaoManager get managers => AiDivinationsDaoManager(this);
}

class AiDivinationsDaoManager {
  final _$AiDivinationsDaoMixin _db;
  AiDivinationsDaoManager(this._db);
  $$LlmProvidersTableTableManager get llmProviders =>
      $$LlmProvidersTableTableManager(_db.attachedDatabase, _db.llmProviders);
  $$LlmModelsTableTableManager get llmModels =>
      $$LlmModelsTableTableManager(_db.attachedDatabase, _db.llmModels);
  $$PromptTemplatesTableTableManager get promptTemplates =>
      $$PromptTemplatesTableTableManager(
        _db.attachedDatabase,
        _db.promptTemplates,
      );
  $$AiPersonasTableTableManager get aiPersonas =>
      $$AiPersonasTableTableManager(_db.attachedDatabase, _db.aiPersonas);
  $$AiChatSessionsTableTableManager get aiChatSessions =>
      $$AiChatSessionsTableTableManager(
        _db.attachedDatabase,
        _db.aiChatSessions,
      );
  $$AiProvenancesTableTableManager get aiProvenances =>
      $$AiProvenancesTableTableManager(_db.attachedDatabase, _db.aiProvenances);
  $$AiDivinationsTableTableManager get aiDivinations =>
      $$AiDivinationsTableTableManager(_db.attachedDatabase, _db.aiDivinations);
}
