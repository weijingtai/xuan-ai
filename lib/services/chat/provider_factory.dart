import 'package:common/domain/ai/resolved_persona.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

import '../../src/providers/deepseek_provider.dart';
import '../../src/providers/nvidia_provider.dart';

/// 根据 [ResolvedPersona] 构造对应的 flutter_ai_toolkit Provider。
///
/// 根据 providerName 和 baseUrl 自动选择合适的 Provider 实现。
/// 可选传入 [history] 以恢复一个已有 Session 的聊天记录。
class ProviderFactory {
  /// 从 ResolvedPersona 创建 LlmProvider。
  ///
  /// [persona]: 完整的 Persona 运行时配置。
  /// [history]: 可选的历史消息列表，用于恢复 Session。
  static LlmProvider createFromPersona(
    ResolvedPersona persona, {
    List<ChatMessage>? history,
  }) {
    final name = persona.providerName.toLowerCase();
    final url = persona.baseUrl.toLowerCase();

    if (name.contains('nvidia') || url.contains('nvidia.com')) {
      return NvidiaProvider(
        apiKey: persona.apiKey,
        baseUrl: persona.baseUrl,
        model: persona.modelId,
        temperature: persona.temperature,
        systemInstruction: persona.systemInstruction,
        history: history,
      );
    }

    // DeepSeek 或其他兼容 OpenAI 的 provider 都使用 DeepSeekProvider
    return DeepSeekProvider(
      apiKey: persona.apiKey,
      baseUrl: persona.baseUrl,
      model: persona.modelId,
      temperature: persona.temperature,
      systemInstruction: persona.systemInstruction,
      history: history,
    );
  }
}
