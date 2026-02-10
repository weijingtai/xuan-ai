import 'dart:async';

import 'package:common/domain/ai/agent_tool.dart';
import 'package:common/domain/ai/ai_audit_log.dart';
import 'package:common/domain/ai/ai_action.dart';
import 'package:common/domain/ai/ai_config_summary.dart';
import 'package:common/domain/ai/ai_context.dart';
import 'package:common/services/ai_audit_service.dart';
import 'package:common/services/ai_service.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
// import 'package:provider/provider.dart'; // Unused

import '../widgets/ai_chat_view.dart';
import 'ai_audit_service_impl.dart';
import 'llm/llm_service.dart'; // Added
import 'agent/agent_runner.dart'; // Added

class AiServiceImpl implements AiService {
  final _logger = Logger('AiServiceImpl');

  // Maintain registries
  final List<AiAction> _actions = [];
  final List<AgentTool> _tools = [];

  // Active configuration stream (mock for now)
  final _configController = StreamController<AiConfigSummary>.broadcast();

  // Services
  final AiAuditService _auditService;
  final LlmService _llmService;

  AiServiceImpl({AiAuditService? auditService, required LlmService llmService})
    : _auditService = auditService ?? AiAuditServiceImpl(),
      _llmService = llmService;

  @override
  Stream<AiConfigSummary> get activeConfig => _configController.stream;

  @override
  void registerAction(AiAction action) {
    if (_actions.any((a) => a.id == action.id)) {
      _logger.warning('Overwriting existing action: ${action.id}');
      _actions.removeWhere((a) => a.id == action.id);
    }
    _actions.add(action);
    _logger.info('Registered Action: ${action.label} (${action.id})');
  }

  @override
  List<AiAction> getAvailableActions(AiContext context) {
    return _actions.where((a) => a.isApplicable(context)).toList();
  }

  @override
  void registerTool(AgentTool tool) {
    if (_tools.any((t) => t.name == tool.name)) {
      _logger.warning('Overwriting existing tool: ${tool.name}');
      _tools.removeWhere((t) => t.name == tool.name);
    }
    _tools.add(tool);
    _logger.info('Registered Tool: ${tool.name}');
  }

  @override
  List<AgentTool> getAvailableTools() {
    return List.unmodifiable(_tools);
  }

  @override
  Future<void> openChat({
    required BuildContext context,
    AiContext? initialContext,
  }) async {
    _logger.info('Opening AI Chat with context: ${initialContext?.intention}');

    // Log the interaction
    await _auditService.logInteraction(
      AiAuditLog(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // TODO: Use UUID
        timestamp: DateTime.now(),
        type: AiAuditLogType.chat,
        sourceModule: 'ai_service',
        payload: {
          'action': 'open_chat',
          'intention': initialContext?.intention,
        },
      ),
    );

    // Push the ChatView
    // Check if we are already in a chat view? usually pushing    // Push the ChatView
    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => AiChatView(initialContext: initialContext),
        ),
      );
    }
  }

  @override
  Future<String> analyze({required AiContext context}) async {
    _logger.info('Analyzing with context: ${context.intention}');

    try {
      // Get default model
      final defaultModel = await _llmService.getDefaultModel();
      if (defaultModel == null) {
        throw Exception('No default LLM model configured');
      }

      final runner = AgentRunner(
        llmService: _llmService,
        auditService: _auditService,
      );

      final result = await runner.run(
        context: context,
        tools: _tools,
        modelUuid: defaultModel.uuid,
      );

      return result;
    } catch (e) {
      _logger.severe('Analysis failed', e);
      return "Analysis failed: $e";
    }
  }

  @override
  Future<String?> getSummary({required String entityId}) async {
    // TODO: Implement persistence lookup
    return null;
  }

  @override
  Stream<String?> watchSummary({required String entityId}) {
    // TODO: Implement persistence stream
    return Stream.value(null);
  }

  @override
  Future<bool> showConfigSheet({required BuildContext context}) async {
    // TODO: Implement Config Sheet
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('AI Configuration Sheet not implemented')),
    );
    return false;
  }

  void dispose() {
    _configController.close();
  }
}
