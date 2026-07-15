// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompt_templates_dao.dart';

// ignore_for_file: type=lint
mixin _$PromptTemplatesDaoMixin on DatabaseAccessor<AiDatabase> {
  $PromptTemplatesTable get promptTemplates => attachedDatabase.promptTemplates;
  PromptTemplatesDaoManager get managers => PromptTemplatesDaoManager(this);
}

class PromptTemplatesDaoManager {
  final _$PromptTemplatesDaoMixin _db;
  PromptTemplatesDaoManager(this._db);
  $$PromptTemplatesTableTableManager get promptTemplates =>
      $$PromptTemplatesTableTableManager(
        _db.attachedDatabase,
        _db.promptTemplates,
      );
}
