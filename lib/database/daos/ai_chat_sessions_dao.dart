import 'package:drift/drift.dart';
import '../ai_database.dart';
import '../tables/tables.dart';

part 'ai_chat_sessions_dao.g.dart';

@DriftAccessor(tables: [AiChatSessions, AiPersonas])
class AiChatSessionsDao extends DatabaseAccessor<AiDatabase>
    with _$AiChatSessionsDaoMixin {
  AiChatSessionsDao(super.db);

  /// Get all active sessions
  Future<List<AiChatSession>> getAllActive() {
    return (select(aiChatSessions)
          ..where((t) => t.status.equals('active'))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.lastMessageAt)]))
        .get();
  }

  /// Get sessions by divination UUID
  Future<List<AiChatSession>> getByDivination(String divinationUuid) {
    return (select(aiChatSessions)
          ..where((t) => t.divinationUuid.equals(divinationUuid))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Get session by UUID
  Future<AiChatSession?> getByUuid(String uuid) {
    return (select(aiChatSessions)
          ..where((t) => t.uuid.equals(uuid))
          ..where((t) => t.deletedAt.isNull()))
        .getSingleOrNull();
  }

  /// Create a new session
  Future<String> createSession({
    required String uuid,
    required String personaUuid,
    String? divinationUuid,
    String? title,
    String? contextJson,
  }) async {
    await into(aiChatSessions).insert(
      AiChatSessionsCompanion.insert(
        uuid: uuid,
        personaUuid: personaUuid,
        divinationUuid: Value(divinationUuid),
        title: Value(title),
        contextJson: Value(contextJson),
        createdAt: DateTime.now(),
      ),
    );
    return uuid;
  }

  /// Update session title
  Future<void> updateTitle(String uuid, String title) {
    return (update(aiChatSessions)..where((t) => t.uuid.equals(uuid))).write(
      AiChatSessionsCompanion(
        title: Value(title),
        lastUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Update message count and last message time
  Future<void> updateMessageStats(String uuid, int messageCount) {
    return (update(aiChatSessions)..where((t) => t.uuid.equals(uuid))).write(
      AiChatSessionsCompanion(
        messageCount: Value(messageCount),
        lastMessageAt: Value(DateTime.now()),
        lastUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Increment message count
  Future<void> incrementMessageCount(String uuid) async {
    final session = await getByUuid(uuid);
    if (session != null) {
      await updateMessageStats(uuid, session.messageCount + 1);
    }
  }

  /// Archive a session
  Future<void> archive(String uuid) {
    return (update(aiChatSessions)..where((t) => t.uuid.equals(uuid))).write(
      AiChatSessionsCompanion(
        status: const Value('archived'),
        lastUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Soft delete a session
  Future<void> softDelete(String uuid) {
    return (update(aiChatSessions)..where((t) => t.uuid.equals(uuid))).write(
      AiChatSessionsCompanion(
        status: const Value('deleted'),
        deletedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Watch active sessions (for reactive UI)
  Stream<List<AiChatSession>> watchActive() {
    return (select(aiChatSessions)
          ..where((t) => t.status.equals('active'))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.lastMessageAt)]))
        .watch();
  }
}
