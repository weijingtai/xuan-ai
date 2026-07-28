/// AI 上下文实体：描述一个具体的业务对象（如一个奇门局）。
///
/// 业务模块负责将自身的 Domain Object 转换为 [AiEntity]，
/// 以统一的格式传递给 AI 服务。
class AiEntity {
  /// 唯一标识符，通常为 UUID。
  final String id;

  /// 类型标识，如 "qimen_pan", "bazi_chart", "liuren_lesson"。
  final String type;

  /// 人类可读名称，如 "阳遁五局"。
  final String name;

  /// 【关键】自然语言描述。这是直接喂给 LLM 的文本。
  ///
  /// 业务模块负责生成此字段，例如：
  /// "此时为阳遁五局，甲子戊在坎宫，值使休门落离宫..."
  final String description;

  /// 原始结构化数据（JSON），供 AI 工具（Function Call）使用。
  ///
  /// 当 AI 需要对数据进行精确操作时（如重新计算、数据提取），
  /// 会使用此字段而非 [description]。
  final Map<String, dynamic>? rawData;

  const AiEntity({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    this.rawData,
  });

  /// 从 JSON 创建 [AiEntity]。
  factory AiEntity.fromJson(Map<String, dynamic> json) {
    return AiEntity(
      id: json['id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      rawData: json['rawData'] as Map<String, dynamic>?,
    );
  }

  /// 将 [AiEntity] 转换为 JSON。
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'description': description,
      if (rawData != null) 'rawData': rawData,
    };
  }

  @override
  String toString() => 'AiEntity($type: $name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AiEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
