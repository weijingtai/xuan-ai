// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_usage_audits_dao.dart';

// ignore_for_file: type=lint
mixin _$AiUsageAuditsDaoMixin on DatabaseAccessor<AiDatabase> {
  $AiUsageAuditsTable get aiUsageAudits => attachedDatabase.aiUsageAudits;
  AiUsageAuditsDaoManager get managers => AiUsageAuditsDaoManager(this);
}

class AiUsageAuditsDaoManager {
  final _$AiUsageAuditsDaoMixin _db;
  AiUsageAuditsDaoManager(this._db);
  $$AiUsageAuditsTableTableManager get aiUsageAudits =>
      $$AiUsageAuditsTableTableManager(_db.attachedDatabase, _db.aiUsageAudits);
}
