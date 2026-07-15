// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool_call.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToolCallResult _$ToolCallResultFromJson(Map<String, dynamic> json) =>
    ToolCallResult(
      toolCallId: json['toolCallId'] as String,
      toolName: json['toolName'] as String,
      arguments: json['arguments'] as Map<String, dynamic>,
      result: json['result'],
      error: json['error'] as String?,
      isSuccess: json['isSuccess'] as bool,
    );

Map<String, dynamic> _$ToolCallResultToJson(ToolCallResult instance) =>
    <String, dynamic>{
      'toolCallId': instance.toolCallId,
      'toolName': instance.toolName,
      'arguments': instance.arguments,
      'result': instance.result,
      'error': instance.error,
      'isSuccess': instance.isSuccess,
    };

PendingToolCall _$PendingToolCallFromJson(Map<String, dynamic> json) =>
    PendingToolCall(
      id: json['id'] as String,
      name: json['name'] as String,
      arguments: json['arguments'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PendingToolCallToJson(PendingToolCall instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'arguments': instance.arguments,
      'createdAt': instance.createdAt.toIso8601String(),
    };
