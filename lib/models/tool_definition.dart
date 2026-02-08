import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tool_definition.g.dart';

/// Tool definition for function calling
@JsonSerializable()
class ToolDefinition extends Equatable {
  final String type;
  final FunctionDefinition function;

  const ToolDefinition({
    this.type = 'function',
    required this.function,
  });

  factory ToolDefinition.fromJson(Map<String, dynamic> json) =>
      _$ToolDefinitionFromJson(json);

  Map<String, dynamic> toJson() => _$ToolDefinitionToJson(this);

  @override
  List<Object?> get props => [type, function];
}

/// Function definition
@JsonSerializable()
class FunctionDefinition extends Equatable {
  final String name;
  final String? description;
  final Map<String, dynamic>? parameters;
  final bool? strict;

  const FunctionDefinition({
    required this.name,
    this.description,
    this.parameters,
    this.strict,
  });

  factory FunctionDefinition.fromJson(Map<String, dynamic> json) =>
      _$FunctionDefinitionFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionDefinitionToJson(this);

  /// Create a simple function definition
  factory FunctionDefinition.simple({
    required String name,
    String? description,
    Map<String, ParameterDefinition>? properties,
    List<String>? required,
  }) {
    return FunctionDefinition(
      name: name,
      description: description,
      parameters: properties != null
          ? {
              'type': 'object',
              'properties': properties.map(
                (key, value) => MapEntry(key, value.toJson()),
              ),
              if (required != null) 'required': required,
            }
          : null,
    );
  }

  @override
  List<Object?> get props => [name, description, parameters, strict];
}

/// Parameter definition for function parameters
@JsonSerializable()
class ParameterDefinition extends Equatable {
  final String type;
  final String? description;
  @JsonKey(name: 'enum')
  final List<String>? enumValues;
  final Map<String, dynamic>? items;
  final Map<String, ParameterDefinition>? properties;
  final List<String>? required;

  const ParameterDefinition({
    required this.type,
    this.description,
    this.enumValues,
    this.items,
    this.properties,
    this.required,
  });

  factory ParameterDefinition.fromJson(Map<String, dynamic> json) =>
      _$ParameterDefinitionFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterDefinitionToJson(this);

  /// String parameter
  factory ParameterDefinition.string({String? description, List<String>? enumValues}) =>
      ParameterDefinition(
        type: 'string',
        description: description,
        enumValues: enumValues,
      );

  /// Number parameter
  factory ParameterDefinition.number({String? description}) =>
      ParameterDefinition(type: 'number', description: description);

  /// Integer parameter
  factory ParameterDefinition.integer({String? description}) =>
      ParameterDefinition(type: 'integer', description: description);

  /// Boolean parameter
  factory ParameterDefinition.boolean({String? description}) =>
      ParameterDefinition(type: 'boolean', description: description);

  /// Array parameter
  factory ParameterDefinition.array({
    String? description,
    required Map<String, dynamic> items,
  }) =>
      ParameterDefinition(
        type: 'array',
        description: description,
        items: items,
      );

  /// Object parameter
  factory ParameterDefinition.object({
    String? description,
    required Map<String, ParameterDefinition> properties,
    List<String>? required,
  }) =>
      ParameterDefinition(
        type: 'object',
        description: description,
        properties: properties,
        required: required,
      );

  @override
  List<Object?> get props =>
      [type, description, enumValues, items, properties, required];
}
