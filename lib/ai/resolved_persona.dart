import 'package:equatable/equatable.dart';

/// 已解析的 Persona 完整运行时配置。
///
/// 包含从数据库中组装好的 LLM Provider、模型、Prompt 等全部信息，
/// 消除 View 层对数据库的直接依赖。
class ResolvedPersona extends Equatable {
  final String uuid;
  final String name;
  final String? description;
  final String? avatarUrl;

  // ── LLM 配置（已从 DB 解析） ──
  final String providerName; // "deepseek", "nvidia", etc.
  final String apiKey;
  final String baseUrl;
  final String modelId;

  // ── 推理参数 ──
  final double temperature;
  final double topP;
  final int maxTokens;

  // ── Prompt ──
  final String? systemInstruction;

  const ResolvedPersona({
    required this.uuid,
    required this.name,
    this.description,
    this.avatarUrl,
    required this.providerName,
    required this.apiKey,
    required this.baseUrl,
    required this.modelId,
    this.temperature = 0.7,
    this.topP = 1.0,
    this.maxTokens = 2048,
    this.systemInstruction,
  });

  @override
  List<Object?> get props => [
        uuid,
        name,
        description,
        avatarUrl,
        providerName,
        apiKey,
        baseUrl,
        modelId,
        temperature,
        topP,
        maxTokens,
        systemInstruction,
      ];

  @override
  String toString() =>
      'ResolvedPersona($name, provider=$providerName, model=$modelId)';
}
