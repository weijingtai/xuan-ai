// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToolDefinition _$ToolDefinitionFromJson(Map<String, dynamic> json) =>
    ToolDefinition(
      type: json['type'] as String? ?? 'function',
      function: FunctionDefinition.fromJson(
        json['function'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ToolDefinitionToJson(ToolDefinition instance) =>
    <String, dynamic>{
      'type': instance.type,
      'function': instance.function.toJson(),
    };

FunctionDefinition _$FunctionDefinitionFromJson(Map<String, dynamic> json) =>
    FunctionDefinition(
      name: json['name'] as String,
      description: json['description'] as String?,
      parameters: json['parameters'] as Map<String, dynamic>?,
      strict: json['strict'] as bool?,
    );

Map<String, dynamic> _$FunctionDefinitionToJson(FunctionDefinition instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'parameters': instance.parameters,
      'strict': instance.strict,
    };

ParameterDefinition _$ParameterDefinitionFromJson(Map<String, dynamic> json) =>
    ParameterDefinition(
      type: json['type'] as String,
      description: json['description'] as String?,
      enumValues: (json['enum'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      items: json['items'] as Map<String, dynamic>?,
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          k,
          ParameterDefinition.fromJson(e as Map<String, dynamic>),
        ),
      ),
      required: (json['required'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ParameterDefinitionToJson(
  ParameterDefinition instance,
) => <String, dynamic>{
  'type': instance.type,
  'description': instance.description,
  'enum': instance.enumValues,
  'items': instance.items,
  'properties': instance.properties?.map((k, e) => MapEntry(k, e.toJson())),
  'required': instance.required,
};
