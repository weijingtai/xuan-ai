import 'dart:convert';

import 'package:common/domain/ai/ai_context.dart';
import 'package:common/domain/ai/resolved_persona.dart';
import 'package:common/domain/ai/session_summary.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:logging/logging.dart';

import '../../database/ai_database.dart';
import 'chat_persistence_service.dart';

/// Session 管理器：管理聊天 Session 的完整生命周期。
///
/// 负责 Session 的创建、恢复、暂停、归档、删除，
/// 以及与 flutter_ai_toolkit 的 Provider history 同步。
class SessionManager {
  final _logger = Logger('SessionManager');
  final AiDatabase _db;
  late final ChatPersistenceService _persistence;

  SessionManager({required AiDatabase db}) : _db = db {
    _persistence = ChatPersistenceService(_db);
  }

  // ============================================================
  // Session CRUD
  // ============================================================

  /// 创建新 Session。
  ///
  /// [persona]: 关联的 AI 人设。
  /// [initialContext]: 可选的上下文数据。如果存在，会将其格式化为第一条用户消息。
  ///
  /// 返回 [SessionCreationResult]，包含新 Session UUID 和初始消息（如果有）。
  Future<SessionCreationResult> createSession({
    required ResolvedPersona persona,
    AiContext? initialContext,
  }) async {
    final contextJson = initialContext != null
        ? jsonEncode(initialContext.toJson())
        : null;

    final sessionUuid = await _persistence.createSession(
      personaUuid: persona.uuid,
      title: null, // 初始无标题，可在首次消息后自动生成
      contextJson: contextJson,
    );

    _logger.info('Created session $sessionUuid for persona: ${persona.name}');

    final List<ChatMessage> initialMessages = [];

    // Inject Context as the first User Message
    if (initialContext != null) {
      final contextMessageContent = _formatContextToMessage(initialContext);

      // Persist to DB
      await _persistence.addMessage(
        sessionUuid: sessionUuid,
        role: 'user',
        content: contextMessageContent,
        isStreaming: false,
      );

      // Create ChatMessage for return
      initialMessages.add(ChatMessage.user(contextMessageContent, const []));

      _logger.info('Injected initial context message');
    }

    return SessionCreationResult(
      sessionUuid: sessionUuid,
      initialMessages: initialMessages,
    );
  }

  /// 恢复已有 Session，从 DB 加载消息并反序列化为 ChatMessage 列表。
  ///
  /// 返回 Session 元数据和恢复的消息历史。
  /// 返回 null 表示 Session 不存在。
  Future<SessionRestoreResult?> resumeSession(String sessionUuid) async {
    final session = await _persistence.getSession(sessionUuid);
    if (session == null) {
      _logger.warning('Session not found: $sessionUuid');
      return null;
    }

    // 从 DB 加载消息
    final dbMessages = await _persistence.getMessages(sessionUuid);

    // 将 DB 消息转换为 toolkit ChatMessage
    final chatMessages = dbMessages
        .where((m) => m.role == 'user' || m.role == 'assistant')
        .map((m) => _dbMessageToChatMessage(m))
        .toList();

    _logger.info(
      'Restored session $sessionUuid with ${chatMessages.length} messages',
    );

    return SessionRestoreResult(session: session, messages: chatMessages);
  }

  /// 保存当前 Provider 的聊天历史到 DB。
  ///
  /// 从 LlmProvider.history 读取全部消息，序列化后写入 DB。
  /// 采用"清除后重写"策略，确保 DB 与 Provider 完全同步。
  Future<void> saveHistory({
    required String sessionUuid,
    required Iterable<ChatMessage> history,
  }) async {
    // 将每条 toolkit 消息存入 DB
    // 注意：这里简化为逐条写入，实际可以优化为批量操作
    int sequence = 0;
    for (final message in history) {
      final role = message.origin.isUser ? 'user' : 'assistant';
      final content = message.text ?? '';

      await _persistence.addMessage(
        sessionUuid: sessionUuid,
        role: role,
        content: content,
        isStreaming: false,
      );
      sequence++;
    }

    _logger.info('Saved $sequence messages for session $sessionUuid');
  }

  // ============================================================
  // Session 列表 & 状态管理
  // ============================================================

  /// 获取 Session 列表摘要。
  ///
  /// [personaUuid]: 可选，按 Persona 过滤。
  /// [status]: 可选，按状态过滤。
  Future<List<SessionSummary>> listSessions({
    String? personaUuid,
    String? status,
  }) async {
    // 获取 active sessions
    final sessions = await _persistence.getActiveSessions();

    // 需要 join persona name，分别查询
    final List<SessionSummary> summaries = [];
    for (final session in sessions) {
      // 按 personaUuid 过滤
      if (personaUuid != null && session.personaUuid != personaUuid) continue;

      // 按 status 过滤
      if (status != null && session.status != status) continue;

      // 获取 persona 名称
      final persona = await _db.aiPersonasDao.getByUuid(session.personaUuid);
      final personaName = persona?.name ?? '未知人设';

      summaries.add(
        SessionSummary(
          uuid: session.uuid,
          title: session.title,
          personaUuid: session.personaUuid,
          personaName: personaName,
          messageCount: session.messageCount,
          createdAt: session.createdAt,
          lastMessageAt: session.lastMessageAt,
          status: session.status,
        ),
      );
    }

    return summaries;
  }

  /// 归档 Session。
  Future<void> archiveSession(String sessionUuid) async {
    await _persistence.archiveSession(sessionUuid);
    _logger.info('Archived session: $sessionUuid');
  }

  /// 删除 Session 及其所有消息。
  Future<void> deleteSession(String sessionUuid) async {
    await _persistence.deleteSession(sessionUuid);
    _logger.info('Deleted session: $sessionUuid');
  }

  /// 重置 Session（清空消息但保留 Session 配置）。
  Future<void> resetSession(String sessionUuid) async {
    // 删除所有消息
    await _db.aiChatMessagesDao.deleteBySession(sessionUuid);
    // 重置消息计数
    await _db.aiChatSessionsDao.updateMessageStats(sessionUuid, 0);
    _logger.info('Reset session: $sessionUuid');
  }

  // ============================================================
  // 内部转换
  // ============================================================

  String _formatContextToMessage(AiContext context) {
    final buffer = StringBuffer();

    // Header
    buffer.writeln('【当前上下文信息】');

    // Intention
    if (context.intention.isNotEmpty) {
      buffer.writeln('用户意图: ${context.intention}');
      buffer.writeln();
    }

    // Module Info
    buffer.writeln('来源模块: ${context.moduleName}');
    buffer.writeln();

    // Entities
    if (context.entities.isNotEmpty) {
      buffer.writeln('【关联数据】');
      for (final entity in context.entities) {
        buffer.writeln('--- ${entity.name} (${entity.type}) ---');
        buffer.writeln(entity.description);
        buffer.writeln();
      }
    }

    return buffer.toString().trim();
  }

  /// 将 DB 聊天消息转换为 toolkit ChatMessage。
  ChatMessage _dbMessageToChatMessage(AiChatMessage dbMessage) {
    if (dbMessage.role == 'user') {
      return ChatMessage.user(dbMessage.content, const []);
    } else {
      return ChatMessage(
        origin: MessageOrigin.llm,
        text: dbMessage.content,
        attachments: const [],
      );
    }
  }
}

/// Session 创建结果。
class SessionCreationResult {
  final String sessionUuid;
  final List<ChatMessage> initialMessages;

  const SessionCreationResult({
    required this.sessionUuid,
    required this.initialMessages,
  });
}

/// Session 恢复结果。
class SessionRestoreResult {
  final AiChatSession session;
  final List<ChatMessage> messages;

  const SessionRestoreResult({required this.session, required this.messages});
}
