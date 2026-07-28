import 'package:equatable/equatable.dart';

/// 表示 AI 人设的轻量级摘要，独立于数据库实现。
///
/// 重命名为 [AiPersonaSummary] 以避免与 Drift 生成的 [AiPersona] 冲突。
class AiPersonaSummary extends Equatable {
  final String uuid;
  final String name;
  final String? description;
  final String? instruction;

  const AiPersonaSummary({
    required this.uuid,
    required this.name,
    this.description,
    this.instruction,
  });

  @override
  List<Object?> get props => [uuid, name, description, instruction];
}
