// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llm_models_dao.dart';

// ignore_for_file: type=lint
mixin _$LlmModelsDaoMixin on DatabaseAccessor<AiDatabase> {
  $LlmProvidersTable get llmProviders => attachedDatabase.llmProviders;
  $LlmModelsTable get llmModels => attachedDatabase.llmModels;
  LlmModelsDaoManager get managers => LlmModelsDaoManager(this);
}

class LlmModelsDaoManager {
  final _$LlmModelsDaoMixin _db;
  LlmModelsDaoManager(this._db);
  $$LlmProvidersTableTableManager get llmProviders =>
      $$LlmProvidersTableTableManager(_db.attachedDatabase, _db.llmProviders);
  $$LlmModelsTableTableManager get llmModels =>
      $$LlmModelsTableTableManager(_db.attachedDatabase, _db.llmModels);
}
