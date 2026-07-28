import 'package:ai_core/ai/resolved_persona.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:logging/logging.dart';

import '../../src/providers/deepseek_provider.dart';
import '../../src/providers/nvidia_provider.dart';
import '../tool/tool_registry.dart';

/// 根据 [ResolvedPersona] 构造对应的 flutter_ai_toolkit Provider。
///
/// 根据 providerName 和 baseUrl 自动选择合适的 Provider 实现。
/// 可选传入 [history] 以恢复一个已有 Session 的聊天记录。
class ProviderFactory {
  static final _log = Logger('ProviderFactory');

  /// 从 ResolvedPersona 创建 LlmProvider。
  ///
  /// [persona]: 完整的 Persona 运行时配置。
  /// [history]: 可选的历史消息列表，用于恢复 Session。
  /// [toolRegistry]: 可选的 ToolRegistry，提供 tool definitions 和执行能力。
  /// [onToolResult]: 可选的回调，在 tool 执行完毕后触发（用于发射事件）。
  static LlmProvider createFromPersona(
    ResolvedPersona persona, {
    List<ChatMessage>? history,
    ToolRegistry? toolRegistry,
    void Function(String toolName, Map<String, dynamic> result)? onToolResult,
  }) {
    final name = persona.providerName.toLowerCase();
    final url = persona.baseUrl.toLowerCase();

    _log.info('[createFromPersona] provider=$name, model=${persona.modelId}, '
        'history=${history?.length ?? 0}, '
        'hasToolRegistry=${toolRegistry != null}');

    if (name.contains('nvidia') || url.contains('nvidia.com')) {
      _log.info('[createFromPersona] using NvidiaProvider');
      return NvidiaProvider(
        apiKey: persona.apiKey,
        baseUrl: persona.baseUrl,
        model: persona.modelId,
        temperature: persona.temperature,
        systemInstruction: persona.systemInstruction,
        history: history,
      );
    }

    // Build tool definitions and handler from ToolRegistry
    List<Map<String, dynamic>>? toolDefs;
    ToolCallHandler? toolHandler;

    if (toolRegistry != null) {
      // Synchronously get tool definitions (they're already in memory)
      final defs = toolRegistry.getToolDefinitionsSync();
      if (defs != null && defs.isNotEmpty) {
        toolDefs = defs.map((d) => d.toJson()).toList();
        _log.info('[createFromPersona] loaded ${toolDefs.length} tool definition(s): '
            '${defs.map((d) => d.function.name).toList()}');
        toolHandler = (toolName, arguments) async {
          _log.info('[toolHandler] executing tool "$toolName"');
          final result = await toolRegistry.executeTool(toolName, arguments);
          final resultData = result.isSuccess
              ? (result.result is Map<String, dynamic>
                  ? result.result as Map<String, dynamic>
                  : {'result': result.result})
              : {'error': result.error};
          _log.info('[toolHandler] tool "$toolName" '
              '${result.isSuccess ? "succeeded" : "failed"}, '
              'result keys=${resultData.keys.toList()}');
          // Notify listener after tool execution
          onToolResult?.call(toolName, resultData);
          return resultData;
        };
      } else {
        _log.fine('[createFromPersona] toolRegistry present but no definitions registered');
      }
    }

    // DeepSeek 或其他兼容 OpenAI 的 provider 都使用 DeepSeekProvider
    _log.info('[createFromPersona] using DeepSeekProvider, '
        'tools=${toolDefs?.length ?? 0}');
    return DeepSeekProvider(
      apiKey: persona.apiKey,
      baseUrl: persona.baseUrl,
      model: persona.modelId,
      temperature: persona.temperature,
      systemInstruction: persona.systemInstruction,
      history: history,
      tools: toolDefs,
      onToolCall: toolHandler,
    );
  }
}
