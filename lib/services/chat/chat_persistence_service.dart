import 'dart:async';
import 'package:uuid/uuid.dart';

import '../../database/ai_database.dart';

/// Chat persistence service for managing chat sessions and messages
class ChatPersistenceService {
  final AiDatabase _db;
  final Uuid _uuid = const Uuid();

  ChatPersistenceService(this._db);

  /// Create a new chat session
  Future<String> createSession({
    required String personaUuid,
    String? divinationUuid,
    String? title,
    String? contextJson,
  }) async {
    final uuid = _uuid.v4();
    await _db.aiChatSessionsDao.createSession(
      uuid: uuid,
      personaUuid: personaUuid,
      divinationUuid: divinationUuid,
      title: title,
      contextJson: contextJson,
    );
    return uuid;
  }

  /// Get a session by UUID
  Future<AiChatSession?> getSession(String uuid) {
    return _db.aiChatSessionsDao.getByUuid(uuid);
  }

  /// Get active sessions
  Future<List<AiChatSession>> getActiveSessions() {
    return _db.aiChatSessionsDao.getAllActive();
  }

  /// Get sessions for a divination
  Future<List<AiChatSession>> getSessionsForDivination(String divinationUuid) {
    return _db.aiChatSessionsDao.getByDivination(divinationUuid);
  }

  /// Add a message to a session
  Future<String> addMessage({
    required String sessionUuid,
    required String role,
    required String content,
    bool isStreaming = false,
    String? toolCallId,
    String? toolCallsJson,
    String? apiCallUuid,
  }) async {
    final uuid = _uuid.v4();
    final sequence = await _db.aiChatMessagesDao.getNextSequence(sessionUuid);

    await _db.aiChatMessagesDao.insertMessage(
      uuid: uuid,
      sessionUuid: sessionUuid,
      role: role,
      content: content,
      sequence: sequence,
      isStreaming: isStreaming,
      toolCallId: toolCallId,
      toolCallsJson: toolCallsJson,
      apiCallUuid: apiCallUuid,
    );

    // Update session stats
    await _db.aiChatSessionsDao.incrementMessageCount(sessionUuid);

    return uuid;
  }

  /// Get messages for a session
  Future<List<AiChatMessage>> getMessages(String sessionUuid) {
    return _db.aiChatMessagesDao.getBySession(sessionUuid);
  }

  /// Get the last N messages for context window
  Future<List<AiChatMessage>> getLastMessages(String sessionUuid, int count) {
    return _db.aiChatMessagesDao.getLastN(sessionUuid, count);
  }

  /// Update message content (for streaming)
  Future<void> updateMessageContent(String messageUuid, String content) {
    return _db.aiChatMessagesDao.updateContent(messageUuid, content);
  }

  /// Append to streaming message
  Future<void> appendToMessage(String messageUuid, String content) {
    return _db.aiChatMessagesDao.appendContent(messageUuid, content);
  }

  /// Complete streaming message
  Future<void> completeStreamingMessage(String messageUuid, {String? usageJson}) {
    return _db.aiChatMessagesDao.completeStreaming(messageUuid, usageJson: usageJson);
  }

  /// Update session title
  Future<void> updateSessionTitle(String sessionUuid, String title) {
    return _db.aiChatSessionsDao.updateTitle(sessionUuid, title);
  }

  /// Archive a session
  Future<void> archiveSession(String sessionUuid) {
    return _db.aiChatSessionsDao.archive(sessionUuid);
  }

  /// Delete a session and its messages
  Future<void> deleteSession(String sessionUuid) async {
    await _db.aiChatMessagesDao.deleteBySession(sessionUuid);
    await _db.aiChatSessionsDao.softDelete(sessionUuid);
  }

  /// Watch messages for real-time updates
  Stream<List<AiChatMessage>> watchMessages(String sessionUuid) {
    return _db.aiChatMessagesDao.watchBySession(sessionUuid);
  }

  /// Watch active sessions
  Stream<List<AiChatSession>> watchActiveSessions() {
    return _db.aiChatSessionsDao.watchActive();
  }
}
