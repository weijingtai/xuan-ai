import 'package:equatable/equatable.dart';

/// 轻量级 Session 摘要，用于列表展示。
///
/// 不包含完整消息内容，只包含用于 UI 展示的元信息。
class SessionSummary extends Equatable {
  final String uuid;
  final String? title;
  final String personaUuid;
  final String personaName;
  final int messageCount;
  final DateTime createdAt;
  final DateTime? lastMessageAt;
  final String status; // active, paused, archived

  const SessionSummary({
    required this.uuid,
    this.title,
    required this.personaUuid,
    required this.personaName,
    required this.messageCount,
    required this.createdAt,
    this.lastMessageAt,
    this.status = 'active',
  });

  @override
  List<Object?> get props => [
        uuid,
        title,
        personaUuid,
        personaName,
        messageCount,
        createdAt,
        lastMessageAt,
        status,
      ];
}
