// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llm_providers_dao.dart';

// ignore_for_file: type=lint
mixin _$LlmProvidersDaoMixin on DatabaseAccessor<AiDatabase> {
  $LlmProvidersTable get llmProviders => attachedDatabase.llmProviders;
  LlmProvidersDaoManager get managers => LlmProvidersDaoManager(this);
}

class LlmProvidersDaoManager {
  final _$LlmProvidersDaoMixin _db;
  LlmProvidersDaoManager(this._db);
  $$LlmProvidersTableTableManager get llmProviders =>
      $$LlmProvidersTableTableManager(_db.attachedDatabase, _db.llmProviders);
}
