/// AI 配置摘要，用于在子模块 UI 上展示当前 AI 配置。
///
/// 例如：在奇门结果页的右上角显示 "当前卦师：玄机子 | 模型：DeepSeek Chat"。
class AiConfigSummary {
  /// 当前选中的 AI 人格/卦师名称。
  final String personaName;

  /// 当前选中的 LLM 模型名称。
  final String modelName;

  const AiConfigSummary({
    required this.personaName,
    required this.modelName,
  });

  @override
  String toString() => 'AiConfigSummary($personaName, $modelName)';
}
