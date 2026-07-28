import 'ai_entity.dart';

/// AI Context Container: Encapsulates all background information for a single interaction.
///
/// When a sub-module (e.g., `xuan-qimendunjia`) needs to invoke AI services,
/// it encapsulates the business data into an [AiContext] and passes it to [AiService].
/// It acts as the "bridge" between the domain-specific logic and the general-purpose AI agent.
class AiContext {
  /// The unique identifier of the module initiating the call (e.g., 'xuan-qimendunjia').
  ///
  /// This field is **mandatory** for auditing, debugging, and potential routing purposes.
  /// It allows the system to trace which part of the application is requesting AI assistance.
  /// Example values:
  /// - `xuan-qimendunjia`: Qimen Dunjia divination module.
  /// - `xuan-liuren`: Da Liuren divination module.
  /// - `xuan-ai`: The AI core module itself (e.g., for meta-analysis).
  final String moduleName;

  /// User intention description, e.g., "Please analyze the financial luck of this Qimen layout".
  ///
  /// This string directly guides the AI's initial focus. It should be concise but specific.
  /// If the intention is empty, the AI might default to a general analysis based on the provided entities.
  final String intention;

  /// Associated list of entities. A context can contain multiple types of entities.
  ///
  /// These entities represent the "facts" or "data" of the current situation.
  /// For example, a Qimen Ju structure, a specific divination question, or user profile data.
  /// The AI uses these entities to ground its response in the actual application state.
  final List<AiEntity> entities;

  /// Optional: Override system prompt (use with caution).
  ///
  /// Usually, the AI service manages the system prompt based on the selected Persona.
  /// However, some modules may need to enforce specific instructions that override or append to
  /// the persona's prompt for a *specific* interaction.
  ///
  /// **Note**: Overusing this can lead to inconsistent AI behavior. Prefer using `AiPersona` configuration where possible.
  final String? systemPromptOverride;

  const AiContext({
    required this.moduleName,
    required this.intention,
    this.entities = const [],
    this.systemPromptOverride,
  });

  /// Create [AiContext] from JSON.
  factory AiContext.fromJson(Map<String, dynamic> json) {
    return AiContext(
      moduleName: json['moduleName'] as String,
      intention: json['intention'] as String,
      entities: (json['entities'] as List<dynamic>?)
              ?.map((e) => AiEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      systemPromptOverride: json['systemPromptOverride'] as String?,
    );
  }

  /// Convert [AiContext] to JSON.
  Map<String, dynamic> toJson() {
    return {
      'moduleName': moduleName,
      'intention': intention,
      'entities': entities.map((e) => e.toJson()).toList(),
      if (systemPromptOverride != null)
        'systemPromptOverride': systemPromptOverride,
    };
  }

  /// Get all entities of a specific type from the context.
  List<AiEntity> entitiesOfType(String type) {
    return entities.where((e) => e.type == type).toList();
  }

  /// Check if the context contains entities of a specific type.
  bool hasEntityOfType(String type) {
    return entities.any((e) => e.type == type);
  }

  @override
  String toString() =>
      'AiContext(module: "$moduleName", intention: "$intention", entities: ${entities.length})';
}
