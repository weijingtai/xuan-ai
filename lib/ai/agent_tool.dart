/// Link B 工具接口：子模块通过此接口向 AI 暴露能力。
///
/// [AgentTool] 代表一个可被 LLM 通过 Function Calling 调用的工具，
/// 例如"搜索历史奇门局"、"起一个大六壬课"等。
///
/// 子模块实现 [AgentTool] 并通过 [AiService.registerTool] 注册。
/// 当 LLM 决定调用某工具时，[AiService] 内部的 AgentRunner 会
/// 在注册表中查找并执行对应的 [AgentTool.execute]。
///
/// **命名说明**：之所以不叫 `AiTool`，是为了与 [AiAction] 区分。
/// - [AiAction]: 子模块 -> AI (Link A)，用户主动触发。
/// - [AgentTool]: AI -> 子模块 (Link B)，AI Agent 主动调用。
abstract class AgentTool {
  /// 工具名称，供 LLM 识别和调用。
  ///
  /// 遵循 snake_case 命名，如 `search_qimen_history`。
  String get name;

  /// 工具描述，供 LLM 理解工具的用途。
  ///
  /// 应使用清晰的自然语言，如 "搜索历史保存的奇门局。支持按格局特征搜索。"
  String get description;

  /// 参数的 JSON Schema，供 LLM 生成正确的调用参数。
  ///
  /// 遵循 JSON Schema 标准格式，例如：
  /// ```json
  /// {
  ///   "type": "object",
  ///   "properties": {
  ///     "keywords": {"type": "string", "description": "搜索关键词"}
  ///   },
  ///   "required": ["keywords"]
  /// }
  /// ```
  Map<String, dynamic> get parametersSchema;

  /// 执行工具逻辑。
  ///
  /// [args] 是 LLM 传来的参数（已根据 [parametersSchema] 验证）。
  /// 返回值会被序列化后传回 LLM 作为工具执行结果。
  Future<Map<String, dynamic>> execute(Map<String, dynamic> args);

  /// 将此工具转换为符合 OpenAI/DeepSeek Function Calling 格式的声明。
  ///
  /// 由 AgentRunner 在构造 LLM 请求时调用。
  Map<String, dynamic> toFunctionDeclaration() {
    return {
      'type': 'function',
      'function': {
        'name': name,
        'description': description,
        'parameters': parametersSchema,
      },
    };
  }
}
