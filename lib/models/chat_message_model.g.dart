// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    ChatMessageModel(
      role: json['role'] as String,
      content: json['content'] as String,
      name: json['name'] as String?,
      toolCallId: json['toolCallId'] as String?,
      toolCalls: (json['toolCalls'] as List<dynamic>?)
          ?.map((e) => ToolCallModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatMessageModelToJson(ChatMessageModel instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
      'name': instance.name,
      'toolCallId': instance.toolCallId,
      'toolCalls': instance.toolCalls?.map((e) => e.toJson()).toList(),
    };

ToolCallModel _$ToolCallModelFromJson(Map<String, dynamic> json) =>
    ToolCallModel(
      id: json['id'] as String,
      type: json['type'] as String,
      function: FunctionCallModel.fromJson(
        json['function'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ToolCallModelToJson(ToolCallModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'function': instance.function.toJson(),
    };

FunctionCallModel _$FunctionCallModelFromJson(Map<String, dynamic> json) =>
    FunctionCallModel(
      name: json['name'] as String,
      arguments: json['arguments'] as String,
    );

Map<String, dynamic> _$FunctionCallModelToJson(FunctionCallModel instance) =>
    <String, dynamic>{'name': instance.name, 'arguments': instance.arguments};
