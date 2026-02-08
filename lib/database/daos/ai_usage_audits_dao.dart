import 'package:drift/drift.dart';
import '../ai_database.dart';
import '../tables/tables.dart';

part 'ai_usage_audits_dao.g.dart';

@DriftAccessor(tables: [AiUsageAudits])
class AiUsageAuditsDao extends DatabaseAccessor<AiDatabase>
    with _$AiUsageAuditsDaoMixin {
  AiUsageAuditsDao(super.db);

  /// Get audits by type
  Future<List<AiUsageAudit>> getByType(String auditType, {int limit = 100}) {
    return (select(aiUsageAudits)
          ..where((t) => t.auditType.equals(auditType))
          ..orderBy([(t) => OrderingTerm.desc(t.auditedAt)])
          ..limit(limit))
        .get();
  }

  /// Get audits for a time range
  Future<List<AiUsageAudit>> getByTimeRange(
    DateTime start,
    DateTime end, {
    String? auditType,
  }) {
    return (select(aiUsageAudits)
          ..where((t) => t.auditedAt.isBiggerOrEqualValue(start))
          ..where((t) => t.auditedAt.isSmallerOrEqualValue(end))
          ..orderBy([(t) => OrderingTerm.desc(t.auditedAt)]))
        .get();
  }

  /// Get audits for an entity
  Future<List<AiUsageAudit>> getByEntity(String entityUuid, String entityType) {
    return (select(aiUsageAudits)
          ..where((t) => t.entityUuid.equals(entityUuid))
          ..where((t) => t.entityType.equals(entityType))
          ..orderBy([(t) => OrderingTerm.desc(t.auditedAt)]))
        .get();
  }

  /// Create an audit record
  Future<int> createAudit({
    required String auditType,
    required String action,
    String? entityUuid,
    String? entityType,
    String? userIdentifier,
    String? detailsJson,
    int? tokensUsed,
    double? estimatedCost,
    String? ipAddress,
    String? deviceInfo,
  }) {
    return into(aiUsageAudits).insert(
      AiUsageAuditsCompanion.insert(
        auditedAt: DateTime.now(),
        auditType: auditType,
        entityUuid: Value(entityUuid),
        entityType: Value(entityType),
        userIdentifier: Value(userIdentifier),
        action: action,
        detailsJson: Value(detailsJson),
        tokensUsed: Value(tokensUsed),
        estimatedCost: Value(estimatedCost),
        ipAddress: Value(ipAddress),
        deviceInfo: Value(deviceInfo),
      ),
    );
  }

  /// Log an API call audit
  Future<int> logApiCall({
    required String apiCallUuid,
    required String action,
    int? tokensUsed,
    double? estimatedCost,
    String? userIdentifier,
    String? detailsJson,
  }) {
    return createAudit(
      auditType: 'api_call',
      action: action,
      entityUuid: apiCallUuid,
      entityType: 'AiApiCall',
      tokensUsed: tokensUsed,
      estimatedCost: estimatedCost,
      userIdentifier: userIdentifier,
      detailsJson: detailsJson,
    );
  }

  /// Log a security audit
  Future<int> logSecurity({
    required String action,
    String? entityUuid,
    String? entityType,
    required String detailsJson,
    String? ipAddress,
    String? deviceInfo,
  }) {
    return createAudit(
      auditType: 'security',
      action: action,
      entityUuid: entityUuid,
      entityType: entityType,
      detailsJson: detailsJson,
      ipAddress: ipAddress,
      deviceInfo: deviceInfo,
    );
  }

  /// Get total token usage for a period
  Future<int> getTotalTokens(DateTime start, DateTime end) async {
    final audits = await (select(aiUsageAudits)
          ..where((t) => t.auditedAt.isBiggerOrEqualValue(start))
          ..where((t) => t.auditedAt.isSmallerOrEqualValue(end))
          ..where((t) => t.tokensUsed.isNotNull()))
        .get();

    return audits.fold(0, (sum, audit) => sum + (audit.tokensUsed ?? 0));
  }

  /// Get estimated cost for a period
  Future<double> getEstimatedCost(DateTime start, DateTime end) async {
    final audits = await (select(aiUsageAudits)
          ..where((t) => t.auditedAt.isBiggerOrEqualValue(start))
          ..where((t) => t.auditedAt.isSmallerOrEqualValue(end))
          ..where((t) => t.estimatedCost.isNotNull()))
        .get();

    return audits.fold(0.0, (sum, audit) => sum + (audit.estimatedCost ?? 0.0));
  }
}
