import 'package:drift/drift.dart';
import '../ai_database.dart';
import '../tables/tables.dart';

part 'ai_chat_messages_dao.g.dart';

@DriftAccessor(tables: [AiChatMessages, AiChatSessions])
class AiChatMessagesDao extends DatabaseAccessor<AiDatabase>
    with _$AiChatMessagesDaoMixin {
  AiChatMessagesDao(super.db);

  /// Get all messages for a session
  Future<List<AiChatMessage>> getBySession(String sessionUuid) {
    return (select(aiChatMessages)
          ..where((t) => t.sessionUuid.equals(sessionUuid))
          ..orderBy([(t) => OrderingTerm.asc(t.sequence)]))
        .get();
  }

  /// Get the last N messages for a session
  Future<List<AiChatMessage>> getLastN(String sessionUuid, int n) {
    return (select(aiChatMessages)
          ..where((t) => t.sessionUuid.equals(sessionUuid))
          ..orderBy([(t) => OrderingTerm.desc(t.sequence)])
          ..limit(n))
        .get();
  }

  /// Get message by UUID
  Future<AiChatMessage?> getByUuid(String uuid) {
    return (select(aiChatMessages)..where((t) => t.uuid.equals(uuid)))
        .getSingleOrNull();
  }

  /// Get the next sequence number for a session
  Future<int> getNextSequence(String sessionUuid) async {
    final lastMessage = await (select(aiChatMessages)
          ..where((t) => t.sessionUuid.equals(sessionUuid))
          ..orderBy([(t) => OrderingTerm.desc(t.sequence)])
          ..limit(1))
        .getSingleOrNull();
    return (lastMessage?.sequence ?? 0) + 1;
  }

  /// Insert a new message
  Future<String> insertMessage({
    required String uuid,
    required String sessionUuid,
    required String role,
    required String content,
    required int sequence,
    bool isStreaming = false,
    String? toolCallId,
    String? toolCallsJson,
    String? apiCallUuid,
  }) async {
    await into(aiChatMessages).insert(
      AiChatMessagesCompanion.insert(
        uuid: uuid,
        sessionUuid: sessionUuid,
        role: role,
        content: content,
        sequence: sequence,
        createdAt: DateTime.now(),
        isStreaming: Value(isStreaming),
        toolCallId: Value(toolCallId),
        toolCallsJson: Value(toolCallsJson),
        apiCallUuid: Value(apiCallUuid),
      ),
    );
    return uuid;
  }

  /// Update message content (for streaming messages)
  Future<void> updateContent(String uuid, String content) {
    return (update(aiChatMessages)..where((t) => t.uuid.equals(uuid)))
        .write(AiChatMessagesCompanion(content: Value(content)));
  }

  /// Append content to a streaming message
  Future<void> appendContent(String uuid, String additionalContent) async {
    final message = await getByUuid(uuid);
    if (message != null) {
      await updateContent(uuid, message.content + additionalContent);
    }
  }

  /// Complete a streaming message
  Future<void> completeStreaming(String uuid, {String? usageJson}) {
    return (update(aiChatMessages)..where((t) => t.uuid.equals(uuid))).write(
      AiChatMessagesCompanion(
        isStreaming: const Value(false),
        streamCompletedAt: Value(DateTime.now()),
        usageJson: Value(usageJson),
      ),
    );
  }

  /// Delete all messages for a session
  Future<void> deleteBySession(String sessionUuid) {
    return (delete(aiChatMessages)
          ..where((t) => t.sessionUuid.equals(sessionUuid)))
        .go();
  }

  /// Watch messages for a session (for reactive UI)
  Stream<List<AiChatMessage>> watchBySession(String sessionUuid) {
    return (select(aiChatMessages)
          ..where((t) => t.sessionUuid.equals(sessionUuid))
          ..orderBy([(t) => OrderingTerm.asc(t.sequence)]))
        .watch();
  }
}
