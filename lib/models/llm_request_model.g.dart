// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llm_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LlmRequestModel _$LlmRequestModelFromJson(Map<String, dynamic> json) =>
    LlmRequestModel(
      model: json['model'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      temperature: (json['temperature'] as num?)?.toDouble(),
      topP: (json['top_p'] as num?)?.toDouble(),
      maxTokens: (json['max_tokens'] as num?)?.toInt(),
      stream: json['stream'] as bool?,
      tools: (json['tools'] as List<dynamic>?)
          ?.map((e) => ToolDefinition.fromJson(e as Map<String, dynamic>))
          .toList(),
      toolChoice: json['tool_choice'],
      responseFormat: json['response_format'] as Map<String, dynamic>?,
      user: json['user'] as String?,
    );

Map<String, dynamic> _$LlmRequestModelToJson(LlmRequestModel instance) =>
    <String, dynamic>{
      'model': instance.model,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'temperature': instance.temperature,
      'top_p': instance.topP,
      'max_tokens': instance.maxTokens,
      'stream': instance.stream,
      'tools': instance.tools?.map((e) => e.toJson()).toList(),
      'tool_choice': instance.toolChoice,
      'response_format': instance.responseFormat,
      'user': instance.user,
    };
