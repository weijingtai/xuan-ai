import 'package:drift/drift.dart';
import '../ai_database.dart';
import '../tables/tables.dart';

part 'ai_api_calls_dao.g.dart';

@DriftAccessor(tables: [AiApiCalls, AiChatSessions, LlmModels])
class AiApiCallsDao extends DatabaseAccessor<AiDatabase>
    with _$AiApiCallsDaoMixin {
  AiApiCallsDao(super.db);

  /// Get API calls for a session
  Future<List<AiApiCall>> getBySession(String sessionUuid) {
    return (select(aiApiCalls)
          ..where((t) => t.sessionUuid.equals(sessionUuid))
          ..orderBy([(t) => OrderingTerm.desc(t.requestedAt)]))
        .get();
  }

  /// Get API call by UUID
  Future<AiApiCall?> getByUuid(String uuid) {
    return (select(aiApiCalls)..where((t) => t.uuid.equals(uuid)))
        .getSingleOrNull();
  }

  /// Get recent API calls
  Future<List<AiApiCall>> getRecent({int limit = 50}) {
    return (select(aiApiCalls)
          ..orderBy([(t) => OrderingTerm.desc(t.requestedAt)])
          ..limit(limit))
        .get();
  }

  /// Get failed API calls
  Future<List<AiApiCall>> getFailed({int limit = 50}) {
    return (select(aiApiCalls)
          ..where((t) => t.status.equals('error'))
          ..orderBy([(t) => OrderingTerm.desc(t.requestedAt)])
          ..limit(limit))
        .get();
  }

  /// Create a new API call record
  Future<String> createCall({
    required String uuid,
    required String modelUuid,
    required String requestJson,
    String? sessionUuid,
    bool isStreaming = false,
  }) async {
    await into(aiApiCalls).insert(
      AiApiCallsCompanion.insert(
        uuid: uuid,
        sessionUuid: Value(sessionUuid),
        modelUuid: modelUuid,
        requestedAt: DateTime.now(),
        requestJson: requestJson,
        isStreaming: Value(isStreaming),
      ),
    );
    return uuid;
  }

  /// Update with response
  Future<void> updateWithResponse({
    required String uuid,
    required String responseJson,
    required String status,
    int? inputTokens,
    int? outputTokens,
    int? totalTokens,
    int? latencyMs,
    String? errorMessage,
  }) {
    return (update(aiApiCalls)..where((t) => t.uuid.equals(uuid))).write(
      AiApiCallsCompanion(
        respondedAt: Value(DateTime.now()),
        responseJson: Value(responseJson),
        status: Value(status),
        inputTokens: Value(inputTokens),
        outputTokens: Value(outputTokens),
        totalTokens: Value(totalTokens),
        latencyMs: Value(latencyMs),
        errorMessage: Value(errorMessage),
      ),
    );
  }

  /// Mark as error
  Future<void> markError(String uuid, String errorMessage) {
    return (update(aiApiCalls)..where((t) => t.uuid.equals(uuid))).write(
      AiApiCallsCompanion(
        respondedAt: Value(DateTime.now()),
        status: const Value('error'),
        errorMessage: Value(errorMessage),
      ),
    );
  }

  /// Get total token usage for a period
  Future<int> getTotalTokens(DateTime start, DateTime end) async {
    final calls = await (select(aiApiCalls)
          ..where((t) => t.requestedAt.isBiggerOrEqualValue(start))
          ..where((t) => t.requestedAt.isSmallerOrEqualValue(end))
          ..where((t) => t.status.equals('success')))
        .get();

    return calls.fold(0, (sum, call) => sum + (call.totalTokens ?? 0));
  }
}
