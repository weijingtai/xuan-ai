import 'dart:async';
import '../../models/tool_definition.dart';
import '../../models/tool_call.dart';
import 'divination_skill_interface.dart';

/// Tool registry for managing and executing AI tools
class ToolRegistry {
  final Map<String, ToolHandler> _handlers = {};
  final Map<String, ToolDefinition> _definitions = {};
  final Map<int, DivinationSkillInterface> _skillInterfaces = {};

  /// Register a tool handler
  void registerTool({
    required String name,
    required ToolDefinition definition,
    required ToolHandler handler,
  }) {
    _handlers[name] = handler;
    _definitions[name] = definition;
  }

  /// Register a divination skill interface
  void registerSkill(int skillId, DivinationSkillInterface interface) {
    _skillInterfaces[skillId] = interface;

    // Auto-register tools from the skill
    for (final tool in interface.getTools()) {
      registerTool(
        name: tool.function.name,
        definition: tool,
        handler: (args) => interface.executeTool(tool.function.name, args),
      );
    }
  }

  /// Unregister a tool
  void unregisterTool(String name) {
    _handlers.remove(name);
    _definitions.remove(name);
  }

  /// Get all tool definitions for LLM
  Future<List<ToolDefinition>?> getToolDefinitions() async {
    if (_definitions.isEmpty) return null;
    return _definitions.values.toList();
  }

  /// Get a specific tool definition
  ToolDefinition? getToolDefinition(String name) {
    return _definitions[name];
  }

  /// Check if a tool is registered
  bool hasTool(String name) {
    return _handlers.containsKey(name);
  }

  /// Execute a tool
  Future<ToolCallResult> executeTool(
    String name,
    Map<String, dynamic> arguments,
  ) async {
    final toolCallId = DateTime.now().millisecondsSinceEpoch.toString();
    final stopwatch = Stopwatch()..start();

    try {
      final handler = _handlers[name];
      if (handler == null) {
        return ToolCallResult.failure(
          toolCallId: toolCallId,
          toolName: name,
          arguments: arguments,
          error: 'Tool not found: $name',
        );
      }

      final result = await handler(arguments);
      stopwatch.stop();

      return ToolCallResult.success(
        toolCallId: toolCallId,
        toolName: name,
        arguments: arguments,
        result: result,
        executionTime: stopwatch.elapsed,
      );
    } catch (e) {
      stopwatch.stop();
      return ToolCallResult.failure(
        toolCallId: toolCallId,
        toolName: name,
        arguments: arguments,
        error: e.toString(),
        executionTime: stopwatch.elapsed,
      );
    }
  }

  /// Execute multiple tools in parallel
  Future<List<ToolCallResult>> executeToolsParallel(
    List<PendingToolCall> toolCalls,
  ) async {
    return await Future.wait(
      toolCalls.map((call) => executeTool(call.name, call.arguments)),
    );
  }

  /// Get all registered tool names
  List<String> getRegisteredToolNames() {
    return _handlers.keys.toList();
  }

  /// Get skill interface by ID
  DivinationSkillInterface? getSkillInterface(int skillId) {
    return _skillInterfaces[skillId];
  }

  /// Clear all registrations
  void clear() {
    _handlers.clear();
    _definitions.clear();
    _skillInterfaces.clear();
  }
}

/// Type alias for tool handler function
typedef ToolHandler = Future<dynamic> Function(Map<String, dynamic> arguments);
