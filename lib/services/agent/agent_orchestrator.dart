import 'dart:async';
import 'dart:convert';
import 'package:uuid/uuid.dart';

import '../../database/ai_database.dart';
import '../chat/chat_service.dart';
import '../provenance/provenance_service.dart';

/// Agent orchestrator for managing multi-agent collaboration
class AgentOrchestrator {
  final AiDatabase _db;
  final ChatService _chatService;
  final ProvenanceService _provenanceService;
  final Uuid _uuid = const Uuid();

  /// Maximum call depth to prevent infinite loops
  final int maxDepth;

  /// Timeout for individual agent calls
  final Duration callTimeout;

  AgentOrchestrator({
    required AiDatabase db,
    required ChatService chatService,
    required ProvenanceService provenanceService,
    this.maxDepth = 5,
    this.callTimeout = const Duration(minutes: 2),
  })  : _db = db,
        _chatService = chatService,
        _provenanceService = provenanceService;

  /// Invoke another agent from within an agent's context
  Future<AgentCallResult> invokeAgent({
    required String callerPersonaUuid,
    required String calleePersonaUuid,
    required String purpose,
    required Map<String, dynamic> sharedContext,
    String? sessionUuid,
    String? parentInvocationUuid,
    int currentDepth = 0,
  }) async {
    // Check depth limit
    if (currentDepth >= maxDepth) {
      return AgentCallResult.failure(
        'Maximum agent call depth ($maxDepth) exceeded',
      );
    }

    // Get personas
    final caller = await _db.aiPersonasDao.getByUuid(callerPersonaUuid);
    final callee = await _db.aiPersonasDao.getByUuid(calleePersonaUuid);

    if (caller == null || callee == null) {
      return AgentCallResult.failure(
        'Persona not found: ${caller == null ? callerPersonaUuid : calleePersonaUuid}',
      );
    }

    // Create invocation record
    final invocationUuid = _uuid.v4();
    await _db.agentInvocationsDao.createInvocation(
      uuid: invocationUuid,
      callerPersonaUuid: callerPersonaUuid,
      calleePersonaUuid: calleePersonaUuid,
      purpose: purpose,
      sessionUuid: sessionUuid,
      sharedContextJson: jsonEncode(sharedContext),
      parentInvocationUuid: parentInvocationUuid,
      depth: currentDepth,
    );

    // Mark as running
    await _db.agentInvocationsDao.markRunning(invocationUuid);

    try {
      // Create a new session for the callee agent
      final calleeSessionUuid = await _chatService.startSession(
        personaUuid: calleePersonaUuid,
        context: {
          ...sharedContext,
          'invocationUuid': invocationUuid,
          'callerPersona': caller.name,
          'purpose': purpose,
        },
      );

      // Send the purpose as the initial message
      final response = await _chatService
          .sendMessage(
            sessionUuid: calleeSessionUuid,
            content: _buildAgentPrompt(purpose, sharedContext),
            stream: false,
          )
          .timeout(callTimeout);

      // Record provenance
      await _provenanceService.recordAgentCall(
        agentInvocationUuid: invocationUuid,
        callerPersonaName: caller.name,
        calleePersonaName: callee.name,
        context: sharedContext,
        input: {'purpose': purpose},
        output: {'response': response},
      );

      // Complete invocation
      final result = {'response': response};
      await _db.agentInvocationsDao.complete(invocationUuid, jsonEncode(result));

      return AgentCallResult.success(
        invocationUuid: invocationUuid,
        result: result,
      );
    } on TimeoutException {
      await _db.agentInvocationsDao.markTimeout(invocationUuid);
      return AgentCallResult.failure(
        'Agent call timed out after ${callTimeout.inSeconds} seconds',
        invocationUuid: invocationUuid,
      );
    } catch (e) {
      await _db.agentInvocationsDao.markFailed(invocationUuid, e.toString());
      return AgentCallResult.failure(
        e.toString(),
        invocationUuid: invocationUuid,
      );
    }
  }

  /// Build prompt for agent invocation
  String _buildAgentPrompt(String purpose, Map<String, dynamic> context) {
    final buffer = StringBuffer();
    buffer.writeln('你被另一位大师请求协助处理以下问题：');
    buffer.writeln();
    buffer.writeln('## 请求目的');
    buffer.writeln(purpose);
    buffer.writeln();

    if (context.isNotEmpty) {
      buffer.writeln('## 上下文信息');
      for (final entry in context.entries) {
        if (entry.key != 'invocationUuid' && entry.key != 'callerPersona') {
          buffer.writeln('- ${entry.key}: ${entry.value}');
        }
      }
      buffer.writeln();
    }

    buffer.writeln('请根据你的专业知识，提供详细的分析和建议。');

    return buffer.toString();
  }

  /// Get the invocation chain for tracking
  Future<List<AgentInvocation>> getInvocationChain(String invocationUuid) {
    return _db.agentInvocationsDao.getChain(invocationUuid);
  }

  /// Get child invocations
  Future<List<AgentInvocation>> getChildInvocations(String parentUuid) {
    return _db.agentInvocationsDao.getChildren(parentUuid);
  }

  /// Cancel a pending invocation
  Future<void> cancelInvocation(String invocationUuid) async {
    await _db.agentInvocationsDao.markFailed(
      invocationUuid,
      'Cancelled by user',
    );
  }

  /// Get pending invocations
  Future<List<AgentInvocation>> getPendingInvocations() {
    return _db.agentInvocationsDao.getPending();
  }
}

/// Result of an agent call
class AgentCallResult {
  final bool isSuccess;
  final String? invocationUuid;
  final Map<String, dynamic>? result;
  final String? error;

  AgentCallResult._({
    required this.isSuccess,
    this.invocationUuid,
    this.result,
    this.error,
  });

  factory AgentCallResult.success({
    required String invocationUuid,
    required Map<String, dynamic> result,
  }) {
    return AgentCallResult._(
      isSuccess: true,
      invocationUuid: invocationUuid,
      result: result,
    );
  }

  factory AgentCallResult.failure(
    String error, {
    String? invocationUuid,
  }) {
    return AgentCallResult._(
      isSuccess: false,
      invocationUuid: invocationUuid,
      error: error,
    );
  }
}
