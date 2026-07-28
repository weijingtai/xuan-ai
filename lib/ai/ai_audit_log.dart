/// 审计日志类型
enum AiAuditLogType {
  /// 用户/AI 聊天消息
  chat,

  /// 用户执行 AiAction (Link A)
  actionCall,

  /// AI Agent 调用 AgentTool (Link B)
  toolCall,

  /// AgentTool 返回结果
  toolResult,
}

/// AI 审计日志数据模型。
///
/// 记录所有 AI 交互事件，用于安全审计和调试。
class AiAuditLog {
  /// 唯一标识符 (UUID)。
  final String id;

  /// 事件发生时间。
  final DateTime timestamp;

  /// 日志类型。
  final AiAuditLogType type;

  /// 来源模块标识，如 `xuan-qimen`、`xuan-ai`。
  final String sourceModule;

  /// 事件负载数据（JSON）。
  ///
  /// 内容取决于 [type]：
  /// - [AiAuditLogType.chat]: `{"role": "user", "content": "..."}`
  /// - [AiAuditLogType.toolCall]: `{"tool_name": "...", "arguments": {...}}`
  /// - [AiAuditLogType.toolResult]: `{"tool_name": "...", "result": {...}}`
  final Map<String, dynamic> payload;

  const AiAuditLog({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.sourceModule,
    required this.payload,
  });

  /// 从 JSON 创建 [AiAuditLog]。
  factory AiAuditLog.fromJson(Map<String, dynamic> json) {
    return AiAuditLog(
      id: json['id'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
      type: AiAuditLogType.values.byName(json['type'] as String),
      sourceModule: json['sourceModule'] as String,
      payload: json['payload'] as Map<String, dynamic>,
    );
  }

  /// 将 [AiAuditLog] 转换为 JSON。
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'type': type.name,
      'sourceModule': sourceModule,
      'payload': payload,
    };
  }

  @override
  String toString() =>
      'AiAuditLog(${type.name}, source: $sourceModule, time: $timestamp)';
}
