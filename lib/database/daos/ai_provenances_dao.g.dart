// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_provenances_dao.dart';

// ignore_for_file: type=lint
mixin _$AiProvenancesDaoMixin on DatabaseAccessor<AiDatabase> {
  $AiProvenancesTable get aiProvenances => attachedDatabase.aiProvenances;
  AiProvenancesDaoManager get managers => AiProvenancesDaoManager(this);
}

class AiProvenancesDaoManager {
  final _$AiProvenancesDaoMixin _db;
  AiProvenancesDaoManager(this._db);
  $$AiProvenancesTableTableManager get aiProvenances =>
      $$AiProvenancesTableTableManager(_db.attachedDatabase, _db.aiProvenances);
}
