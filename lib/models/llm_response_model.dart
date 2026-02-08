import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'chat_message_model.dart';

part 'llm_response_model.g.dart';

/// LLM Response model for OpenAI-compatible APIs
@JsonSerializable()
class LlmResponseModel extends Equatable {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<ChoiceModel> choices;
  final UsageModel? usage;
  @JsonKey(name: 'system_fingerprint')
  final String? systemFingerprint;

  const LlmResponseModel({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    this.usage,
    this.systemFingerprint,
  });

  factory LlmResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LlmResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LlmResponseModelToJson(this);

  /// Get the first choice's message content
  String? get content =>
      choices.isNotEmpty ? choices.first.message?.content : null;

  /// Get tool calls from the first choice
  List<ToolCallModel>? get toolCalls =>
      choices.isNotEmpty ? choices.first.message?.toolCalls : null;

  /// Check if response contains tool calls
  bool get hasToolCalls => toolCalls != null && toolCalls!.isNotEmpty;

  @override
  List<Object?> get props =>
      [id, object, created, model, choices, usage, systemFingerprint];
}

/// Choice model
@JsonSerializable()
class ChoiceModel extends Equatable {
  final int index;
  final ChatMessageModel? message;
  final DeltaModel? delta;
  @JsonKey(name: 'finish_reason')
  final String? finishReason;
  final LogprobsModel? logprobs;

  const ChoiceModel({
    required this.index,
    this.message,
    this.delta,
    this.finishReason,
    this.logprobs,
  });

  factory ChoiceModel.fromJson(Map<String, dynamic> json) =>
      _$ChoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceModelToJson(this);

  @override
  List<Object?> get props => [index, message, delta, finishReason, logprobs];
}

/// Delta model for streaming responses
@JsonSerializable()
class DeltaModel extends Equatable {
  final String? role;
  final String? content;
  @JsonKey(name: 'tool_calls')
  final List<ToolCallDelta>? toolCalls;

  const DeltaModel({
    this.role,
    this.content,
    this.toolCalls,
  });

  factory DeltaModel.fromJson(Map<String, dynamic> json) =>
      _$DeltaModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeltaModelToJson(this);

  @override
  List<Object?> get props => [role, content, toolCalls];
}

/// Tool call delta for streaming
@JsonSerializable()
class ToolCallDelta extends Equatable {
  final int index;
  final String? id;
  final String? type;
  final FunctionCallDelta? function;

  const ToolCallDelta({
    required this.index,
    this.id,
    this.type,
    this.function,
  });

  factory ToolCallDelta.fromJson(Map<String, dynamic> json) =>
      _$ToolCallDeltaFromJson(json);

  Map<String, dynamic> toJson() => _$ToolCallDeltaToJson(this);

  @override
  List<Object?> get props => [index, id, type, function];
}

/// Function call delta for streaming
@JsonSerializable()
class FunctionCallDelta extends Equatable {
  final String? name;
  final String? arguments;

  const FunctionCallDelta({
    this.name,
    this.arguments,
  });

  factory FunctionCallDelta.fromJson(Map<String, dynamic> json) =>
      _$FunctionCallDeltaFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionCallDeltaToJson(this);

  @override
  List<Object?> get props => [name, arguments];
}

/// Usage model
@JsonSerializable()
class UsageModel extends Equatable {
  @JsonKey(name: 'prompt_tokens')
  final int promptTokens;
  @JsonKey(name: 'completion_tokens')
  final int completionTokens;
  @JsonKey(name: 'total_tokens')
  final int totalTokens;

  const UsageModel({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory UsageModel.fromJson(Map<String, dynamic> json) =>
      _$UsageModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsageModelToJson(this);

  @override
  List<Object?> get props => [promptTokens, completionTokens, totalTokens];
}

/// Logprobs model
@JsonSerializable()
class LogprobsModel extends Equatable {
  final List<dynamic>? content;

  const LogprobsModel({this.content});

  factory LogprobsModel.fromJson(Map<String, dynamic> json) =>
      _$LogprobsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LogprobsModelToJson(this);

  @override
  List<Object?> get props => [content];
}

/// Streaming chunk model
@JsonSerializable()
class StreamChunkModel extends Equatable {
  final String id;
  final String object;
  final int created;
  final String model;
  @JsonKey(name: 'system_fingerprint')
  final String? systemFingerprint;
  final List<ChoiceModel> choices;

  const StreamChunkModel({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    this.systemFingerprint,
    required this.choices,
  });

  factory StreamChunkModel.fromJson(Map<String, dynamic> json) =>
      _$StreamChunkModelFromJson(json);

  Map<String, dynamic> toJson() => _$StreamChunkModelToJson(this);

  /// Get delta content
  String? get deltaContent =>
      choices.isNotEmpty ? choices.first.delta?.content : null;

  /// Check if this is the final chunk
  bool get isComplete =>
      choices.isNotEmpty && choices.first.finishReason != null;

  @override
  List<Object?> get props =>
      [id, object, created, model, systemFingerprint, choices];
}
