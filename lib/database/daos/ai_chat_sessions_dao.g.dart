// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_chat_sessions_dao.dart';

// ignore_for_file: type=lint
mixin _$AiChatSessionsDaoMixin on DatabaseAccessor<AiDatabase> {
  $LlmProvidersTable get llmProviders => attachedDatabase.llmProviders;
  $LlmModelsTable get llmModels => attachedDatabase.llmModels;
  $PromptTemplatesTable get promptTemplates => attachedDatabase.promptTemplates;
  $AiPersonasTable get aiPersonas => attachedDatabase.aiPersonas;
  $AiChatSessionsTable get aiChatSessions => attachedDatabase.aiChatSessions;
  AiChatSessionsDaoManager get managers => AiChatSessionsDaoManager(this);
}

class AiChatSessionsDaoManager {
  final _$AiChatSessionsDaoMixin _db;
  AiChatSessionsDaoManager(this._db);
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
}
