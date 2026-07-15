// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llm_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LlmResponseModel _$LlmResponseModelFromJson(Map<String, dynamic> json) =>
    LlmResponseModel(
      id: json['id'] as String,
      object: json['object'] as String,
      created: (json['created'] as num).toInt(),
      model: json['model'] as String,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => ChoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      usage: json['usage'] == null
          ? null
          : UsageModel.fromJson(json['usage'] as Map<String, dynamic>),
      systemFingerprint: json['system_fingerprint'] as String?,
    );

Map<String, dynamic> _$LlmResponseModelToJson(LlmResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices.map((e) => e.toJson()).toList(),
      'usage': instance.usage?.toJson(),
      'system_fingerprint': instance.systemFingerprint,
    };

ChoiceModel _$ChoiceModelFromJson(Map<String, dynamic> json) => ChoiceModel(
  index: (json['index'] as num).toInt(),
  message: json['message'] == null
      ? null
      : ChatMessageModel.fromJson(json['message'] as Map<String, dynamic>),
  delta: json['delta'] == null
      ? null
      : DeltaModel.fromJson(json['delta'] as Map<String, dynamic>),
  finishReason: json['finish_reason'] as String?,
  logprobs: json['logprobs'] == null
      ? null
      : LogprobsModel.fromJson(json['logprobs'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChoiceModelToJson(ChoiceModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'message': instance.message?.toJson(),
      'delta': instance.delta?.toJson(),
      'finish_reason': instance.finishReason,
      'logprobs': instance.logprobs?.toJson(),
    };

DeltaModel _$DeltaModelFromJson(Map<String, dynamic> json) => DeltaModel(
  role: json['role'] as String?,
  content: json['content'] as String?,
  toolCalls: (json['tool_calls'] as List<dynamic>?)
      ?.map((e) => ToolCallDelta.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DeltaModelToJson(DeltaModel instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
      'tool_calls': instance.toolCalls?.map((e) => e.toJson()).toList(),
    };

ToolCallDelta _$ToolCallDeltaFromJson(Map<String, dynamic> json) =>
    ToolCallDelta(
      index: (json['index'] as num).toInt(),
      id: json['id'] as String?,
      type: json['type'] as String?,
      function: json['function'] == null
          ? null
          : FunctionCallDelta.fromJson(
              json['function'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ToolCallDeltaToJson(ToolCallDelta instance) =>
    <String, dynamic>{
      'index': instance.index,
      'id': instance.id,
      'type': instance.type,
      'function': instance.function?.toJson(),
    };

FunctionCallDelta _$FunctionCallDeltaFromJson(Map<String, dynamic> json) =>
    FunctionCallDelta(
      name: json['name'] as String?,
      arguments: json['arguments'] as String?,
    );

Map<String, dynamic> _$FunctionCallDeltaToJson(FunctionCallDelta instance) =>
    <String, dynamic>{'name': instance.name, 'arguments': instance.arguments};

UsageModel _$UsageModelFromJson(Map<String, dynamic> json) => UsageModel(
  promptTokens: (json['prompt_tokens'] as num).toInt(),
  completionTokens: (json['completion_tokens'] as num).toInt(),
  totalTokens: (json['total_tokens'] as num).toInt(),
);

Map<String, dynamic> _$UsageModelToJson(UsageModel instance) =>
    <String, dynamic>{
      'prompt_tokens': instance.promptTokens,
      'completion_tokens': instance.completionTokens,
      'total_tokens': instance.totalTokens,
    };

LogprobsModel _$LogprobsModelFromJson(Map<String, dynamic> json) =>
    LogprobsModel(content: json['content'] as List<dynamic>?);

Map<String, dynamic> _$LogprobsModelToJson(LogprobsModel instance) =>
    <String, dynamic>{'content': instance.content};

StreamChunkModel _$StreamChunkModelFromJson(Map<String, dynamic> json) =>
    StreamChunkModel(
      id: json['id'] as String,
      object: json['object'] as String,
      created: (json['created'] as num).toInt(),
      model: json['model'] as String,
      systemFingerprint: json['system_fingerprint'] as String?,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => ChoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StreamChunkModelToJson(StreamChunkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'system_fingerprint': instance.systemFingerprint,
      'choices': instance.choices.map((e) => e.toJson()).toList(),
    };
