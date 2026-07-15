// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_invocations_dao.dart';

// ignore_for_file: type=lint
mixin _$AgentInvocationsDaoMixin on DatabaseAccessor<AiDatabase> {
  $LlmProvidersTable get llmProviders => attachedDatabase.llmProviders;
  $LlmModelsTable get llmModels => attachedDatabase.llmModels;
  $PromptTemplatesTable get promptTemplates => attachedDatabase.promptTemplates;
  $AiPersonasTable get aiPersonas => attachedDatabase.aiPersonas;
  $AiChatSessionsTable get aiChatSessions => attachedDatabase.aiChatSessions;
  $AgentInvocationsTable get agentInvocations =>
      attachedDatabase.agentInvocations;
  AgentInvocationsDaoManager get managers => AgentInvocationsDaoManager(this);
}

class AgentInvocationsDaoManager {
  final _$AgentInvocationsDaoMixin _db;
  AgentInvocationsDaoManager(this._db);
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
  $$AgentInvocationsTableTableManager get agentInvocations =>
      $$AgentInvocationsTableTableManager(
        _db.attachedDatabase,
        _db.agentInvocations,
      );
}
