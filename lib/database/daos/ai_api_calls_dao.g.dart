// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_api_calls_dao.dart';

// ignore_for_file: type=lint
mixin _$AiApiCallsDaoMixin on DatabaseAccessor<AiDatabase> {
  $LlmProvidersTable get llmProviders => attachedDatabase.llmProviders;
  $LlmModelsTable get llmModels => attachedDatabase.llmModels;
  $PromptTemplatesTable get promptTemplates => attachedDatabase.promptTemplates;
  $AiPersonasTable get aiPersonas => attachedDatabase.aiPersonas;
  $AiChatSessionsTable get aiChatSessions => attachedDatabase.aiChatSessions;
  $AiApiCallsTable get aiApiCalls => attachedDatabase.aiApiCalls;
  AiApiCallsDaoManager get managers => AiApiCallsDaoManager(this);
}

class AiApiCallsDaoManager {
  final _$AiApiCallsDaoMixin _db;
  AiApiCallsDaoManager(this._db);
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
  $$AiApiCallsTableTableManager get aiApiCalls =>
      $$AiApiCallsTableTableManager(_db.attachedDatabase, _db.aiApiCalls);
}
