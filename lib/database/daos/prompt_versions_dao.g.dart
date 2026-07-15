// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompt_versions_dao.dart';

// ignore_for_file: type=lint
mixin _$PromptVersionsDaoMixin on DatabaseAccessor<AiDatabase> {
  $PromptTemplatesTable get promptTemplates => attachedDatabase.promptTemplates;
  $PromptVersionsTable get promptVersions => attachedDatabase.promptVersions;
  PromptVersionsDaoManager get managers => PromptVersionsDaoManager(this);
}

class PromptVersionsDaoManager {
  final _$PromptVersionsDaoMixin _db;
  PromptVersionsDaoManager(this._db);
  $$PromptTemplatesTableTableManager get promptTemplates =>
      $$PromptTemplatesTableTableManager(
        _db.attachedDatabase,
        _db.promptTemplates,
      );
  $$PromptVersionsTableTableManager get promptVersions =>
      $$PromptVersionsTableTableManager(
        _db.attachedDatabase,
        _db.promptVersions,
      );
}
