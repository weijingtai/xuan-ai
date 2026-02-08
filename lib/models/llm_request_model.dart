import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'chat_message_model.dart';
import 'tool_definition.dart';

part 'llm_request_model.g.dart';

/// LLM Request model for OpenAI-compatible APIs
@JsonSerializable()
class LlmRequestModel extends Equatable {
  final String model;
  final List<ChatMessageModel> messages;
  final double? temperature;
  @JsonKey(name: 'top_p')
  final double? topP;
  @JsonKey(name: 'max_tokens')
  final int? maxTokens;
  final bool? stream;
  final List<ToolDefinition>? tools;
  @JsonKey(name: 'tool_choice')
  final dynamic toolChoice;
  @JsonKey(name: 'response_format')
  final Map<String, dynamic>? responseFormat;
  final String? user;

  const LlmRequestModel({
    required this.model,
    required this.messages,
    this.temperature,
    this.topP,
    this.maxTokens,
    this.stream,
    this.tools,
    this.toolChoice,
    this.responseFormat,
    this.user,
  });

  factory LlmRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LlmRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LlmRequestModelToJson(this);

  LlmRequestModel copyWith({
    String? model,
    List<ChatMessageModel>? messages,
    double? temperature,
    double? topP,
    int? maxTokens,
    bool? stream,
    List<ToolDefinition>? tools,
    dynamic toolChoice,
    Map<String, dynamic>? responseFormat,
    String? user,
  }) {
    return LlmRequestModel(
      model: model ?? this.model,
      messages: messages ?? this.messages,
      temperature: temperature ?? this.temperature,
      topP: topP ?? this.topP,
      maxTokens: maxTokens ?? this.maxTokens,
      stream: stream ?? this.stream,
      tools: tools ?? this.tools,
      toolChoice: toolChoice ?? this.toolChoice,
      responseFormat: responseFormat ?? this.responseFormat,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        model,
        messages,
        temperature,
        topP,
        maxTokens,
        stream,
        tools,
        toolChoice,
        responseFormat,
        user,
      ];
}
