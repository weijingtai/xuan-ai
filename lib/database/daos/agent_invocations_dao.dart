import 'package:drift/drift.dart';
import '../ai_database.dart';
import '../tables/tables.dart';

part 'agent_invocations_dao.g.dart';

@DriftAccessor(tables: [AgentInvocations, AiPersonas, AiChatSessions])
class AgentInvocationsDao extends DatabaseAccessor<AiDatabase>
    with _$AgentInvocationsDaoMixin {
  AgentInvocationsDao(super.db);

  /// Get invocations for a session
  Future<List<AgentInvocation>> getBySession(String sessionUuid) {
    return (select(agentInvocations)
          ..where((t) => t.sessionUuid.equals(sessionUuid))
          ..orderBy([(t) => OrderingTerm.asc(t.invokedAt)]))
        .get();
  }

  /// Get invocation by UUID
  Future<AgentInvocation?> getByUuid(String uuid) {
    return (select(agentInvocations)..where((t) => t.uuid.equals(uuid)))
        .getSingleOrNull();
  }

  /// Get child invocations
  Future<List<AgentInvocation>> getChildren(String parentUuid) {
    return (select(agentInvocations)
          ..where((t) => t.parentInvocationUuid.equals(parentUuid))
          ..orderBy([(t) => OrderingTerm.asc(t.invokedAt)]))
        .get();
  }

  /// Get invocation chain (from root to leaf)
  Future<List<AgentInvocation>> getChain(String uuid) async {
    final List<AgentInvocation> chain = [];
    AgentInvocation? current = await getByUuid(uuid);

    while (current != null) {
      chain.insert(0, current);
      if (current.parentInvocationUuid == null) break;
      current = await getByUuid(current.parentInvocationUuid!);
    }

    return chain;
  }

  /// Create a new invocation
  Future<String> createInvocation({
    required String uuid,
    required String callerPersonaUuid,
    required String calleePersonaUuid,
    required String purpose,
    String? sessionUuid,
    String? sharedContextJson,
    String? parentInvocationUuid,
    int depth = 0,
  }) async {
    await into(agentInvocations).insert(
      AgentInvocationsCompanion.insert(
        uuid: uuid,
        callerPersonaUuid: callerPersonaUuid,
        calleePersonaUuid: calleePersonaUuid,
        sessionUuid: Value(sessionUuid),
        invokedAt: DateTime.now(),
        purpose: purpose,
        sharedContextJson: Value(sharedContextJson),
        parentInvocationUuid: Value(parentInvocationUuid),
        depth: Value(depth),
      ),
    );
    return uuid;
  }

  /// Update invocation status to running
  Future<void> markRunning(String uuid) {
    return (update(agentInvocations)..where((t) => t.uuid.equals(uuid)))
        .write(const AgentInvocationsCompanion(status: Value('running')));
  }

  /// Complete an invocation
  Future<void> complete(String uuid, String resultJson) {
    return (update(agentInvocations)..where((t) => t.uuid.equals(uuid))).write(
      AgentInvocationsCompanion(
        completedAt: Value(DateTime.now()),
        resultJson: Value(resultJson),
        status: const Value('completed'),
      ),
    );
  }

  /// Mark as failed
  Future<void> markFailed(String uuid, String errorMessage) {
    return (update(agentInvocations)..where((t) => t.uuid.equals(uuid))).write(
      AgentInvocationsCompanion(
        completedAt: Value(DateTime.now()),
        status: const Value('failed'),
        errorMessage: Value(errorMessage),
      ),
    );
  }

  /// Mark as timeout
  Future<void> markTimeout(String uuid) {
    return (update(agentInvocations)..where((t) => t.uuid.equals(uuid))).write(
      AgentInvocationsCompanion(
        completedAt: Value(DateTime.now()),
        status: const Value('timeout'),
        errorMessage: const Value('Invocation timed out'),
      ),
    );
  }

  /// Get pending invocations
  Future<List<AgentInvocation>> getPending() {
    return (select(agentInvocations)
          ..where((t) => t.status.equals('pending'))
          ..orderBy([(t) => OrderingTerm.asc(t.invokedAt)]))
        .get();
  }
}
