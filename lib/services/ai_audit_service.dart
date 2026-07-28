import '../ai/ai_audit_log.dart';

/// AI 审计服务接口：记录和查询所有 AI 交互日志。
///
/// 此接口在 `xuan-common` 中定义，由 `xuan-ai` 实现。
///
/// ## 职责
/// - 记录所有 AI 交互事件（聊天、Action 调用、Tool 调用/结果）。
/// - 提供查询接口，支持按模块、时间范围过滤。
/// - 确保敏感数据在存储前经过脱敏处理。
abstract class AiAuditService {
  /// 记录一条审计日志。
  Future<void> logInteraction(AiAuditLog log);

  /// 查询审计日志。
  ///
  /// [sourceModule]: 可选，按来源模块过滤。
  /// [after]: 可选，只返回此时间之后的日志。
  /// [type]: 可选，按日志类型过滤。
  /// [limit]: 返回的最大条数，默认 100。
  Future<List<AiAuditLog>> queryLogs({
    String? sourceModule,
    DateTime? after,
    AiAuditLogType? type,
    int limit = 100,
  });

  /// 清理指定日期之前的审计日志。
  ///
  /// 用于控制本地存储的大小。
  Future<int> cleanupBefore(DateTime cutoff);
}
