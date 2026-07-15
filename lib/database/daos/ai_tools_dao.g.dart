// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_tools_dao.dart';

// ignore_for_file: type=lint
mixin _$AiToolsDaoMixin on DatabaseAccessor<AiDatabase> {
  $AiToolsTable get aiTools => attachedDatabase.aiTools;
  AiToolsDaoManager get managers => AiToolsDaoManager(this);
}

class AiToolsDaoManager {
  final _$AiToolsDaoMixin _db;
  AiToolsDaoManager(this._db);
  $$AiToolsTableTableManager get aiTools =>
      $$AiToolsTableTableManager(_db.attachedDatabase, _db.aiTools);
}
