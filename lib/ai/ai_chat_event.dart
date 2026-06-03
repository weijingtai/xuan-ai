/// AI Chat 事件基类。
///
/// 通过 [AiService.chatEvents] 广播，用于 Chat → 宿主页通信。
/// 使用 sealed class 确保类型安全的事件处理。
sealed class AiChatEvent {
  /// 关联的 Session UUID
  final String sessionUuid;

  /// 事件时间戳
  final DateTime timestamp;

  AiChatEvent({required this.sessionUuid, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}

/// Tool 执行结果事件。
///
/// 当 AI 通过 tool calling 执行了一个工具后触发。
/// 宿主页可以监听此事件来自动更新 UI（如拉起新排的盘）。
class ToolResultEvent extends AiChatEvent {
  /// 执行的工具名称
  final String toolName;

  /// 工具执行结果数据
  final Map<String, dynamic> resultData;

  ToolResultEvent({
    required super.sessionUuid,
    required this.toolName,
    required this.resultData,
  });
}
