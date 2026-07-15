// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompt_skill_bindings_dao.dart';

// ignore_for_file: type=lint
mixin _$PromptSkillBindingsDaoMixin on DatabaseAccessor<AiDatabase> {
  $PromptTemplatesTable get promptTemplates => attachedDatabase.promptTemplates;
  $PromptSkillBindingsTable get promptSkillBindings =>
      attachedDatabase.promptSkillBindings;
  PromptSkillBindingsDaoManager get managers =>
      PromptSkillBindingsDaoManager(this);
}

class PromptSkillBindingsDaoManager {
  final _$PromptSkillBindingsDaoMixin _db;
  PromptSkillBindingsDaoManager(this._db);
  $$PromptTemplatesTableTableManager get promptTemplates =>
      $$PromptTemplatesTableTableManager(
        _db.attachedDatabase,
        _db.promptTemplates,
      );
  $$PromptSkillBindingsTableTableManager get promptSkillBindings =>
      $$PromptSkillBindingsTableTableManager(
        _db.attachedDatabase,
        _db.promptSkillBindings,
      );
}
