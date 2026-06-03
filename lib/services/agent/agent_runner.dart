import 'dart:convert';
import 'package:ai_core/ai/agent_tool.dart';
import 'package:ai_core/ai/ai_context.dart';
import '../../models/models.dart';
import '../llm/llm_service.dart';
import 'package:logging/logging.dart';
import 'package:xuan_common/services/ai_audit_service.dart';
import 'package:ai_core/ai/ai_audit_log.dart';
import 'package:uuid/uuid.dart';

/// AgentRunner: Executes LLM requests with tool support (Function Calling loop).
class AgentRunner {
  final LlmService _llmService;
  final AiAuditService _auditService;
  final Logger _logger = Logger('AgentRunner');
  final Uuid _uuid = const Uuid();

  AgentRunner({
    required LlmService llmService,
    required AiAuditService auditService,
  }) : _llmService = llmService,
       _auditService = auditService;

  /// Run the agent loop:
  /// 1. Send user input + context + tools to LLM.
  /// 2. If LLM requests tool calls, execute them.
  /// 3. Feed results back to LLM.
  /// 4. Repeat until LLM returns final text response or max turns reached.
  Future<String> run({
    required AiContext context,
    required List<AgentTool> tools,
    required String modelUuid,
    String? sessionUuid,
    int maxTurns = 5,
  }) async {
    final messages = <ChatMessageModel>[
      // TODO: Construct system prompt based on context
      ChatMessageModel(role: 'system', content: _buildSystemPrompt(context)),
      ChatMessageModel(role: 'user', content: context.intention),
    ];

    // Convert AgentTools to ToolDefinitions
    final toolDefinitions = tools
        .map(
          (t) => ToolDefinition(
            type: 'function',
            function: FunctionDefinition(
              name: t.name,
              description: t.description,
              parameters: t.parametersSchema,
            ),
          ),
        )
        .toList();

    int turn = 0;
    while (turn < maxTurns) {
      turn++;
      _logger.info('AgentRunner turn $turn');

      // Call LLM
      final response = await _llmService.chatCompletion(
        modelUuid: modelUuid,
        messages: messages,
        tools: toolDefinitions.isNotEmpty ? toolDefinitions : null,
        sessionUuid: sessionUuid,
      );

      final responseMessage = response.choices.first.message;

      if (responseMessage == null) {
        _logger.warning('Result is empty');
        return "Empty response from AI";
      }

      // Add assistant response to history
      messages.add(
        ChatMessageModel(
          role: 'assistant',
          content: responseMessage.content,
          toolCalls: responseMessage.toolCalls,
        ),
      );
      // Execute tool calls
      for (final toolCall in responseMessage.toolCalls!) {
        final toolName = toolCall.function.name;
        final argsJson = toolCall.function.arguments;
        final callId = toolCall.id;

        _logger.info('Executing tool: $toolName');

        // Audit: Tool Call
        await _auditService.logInteraction(
          AiAuditLog(
            id: _uuid.v4(),
            timestamp: DateTime.now(),
            type: AiAuditLogType.toolCall,
            sourceModule: 'agent_runner',
            payload: {
              'tool_name': toolName,
              'arguments': argsJson,
              'call_id': callId,
            },
          ),
        );

        String resultJson;
        try {
          final tool = tools.firstWhere(
            (t) => t.name == toolName,
            orElse: () => throw Exception('Tool not found: $toolName'),
          );

          final args = jsonDecode(argsJson) as Map<String, dynamic>;
          final result = await tool.execute(args);
          resultJson = jsonEncode(result);
        } catch (e) {
          _logger.warning('Tool execution failed: $e');
          resultJson = jsonEncode({'error': e.toString()});
        }

        // Audit: Tool Result
        await _auditService.logInteraction(
          AiAuditLog(
            id: _uuid.v4(),
            timestamp: DateTime.now(),
            type: AiAuditLogType.toolResult,
            sourceModule: 'agent_runner',
            payload: {
              'tool_name': toolName,
              'result': resultJson,
              'call_id': callId,
            },
          ),
        );

        // Add tool result to history
        messages.add(
          ChatMessageModel(
            role: 'tool',
            content: resultJson,
            toolCallId: callId,
          ),
        );
      }
    }

    return messages.last.content;
  }

  String _buildSystemPrompt(AiContext context) {
    // TODO: A more sophisticated prompt builder
    final sb = StringBuffer();
    if (context.systemPromptOverride != null) {
      sb.writeln(context.systemPromptOverride);
    } else {
      sb.writeln('你是一个专业的易学助手。');
    }

    if (context.entities.isNotEmpty) {
      sb.writeln('\n当前上下文信息：');
      for (final entity in context.entities) {
        sb.writeln('- ${entity.type} (${entity.name}): ${entity.description}');
      }
    }
    return sb.toString();
  }
}
