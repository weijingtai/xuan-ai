import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_message_model.g.dart';

/// Message role enum
enum MessageRole {
  @JsonValue('system')
  system,
  @JsonValue('user')
  user,
  @JsonValue('assistant')
  assistant,
  @JsonValue('function')
  function,
  @JsonValue('tool')
  tool,
}

/// Chat message model for API requests/responses
@JsonSerializable()
class ChatMessageModel extends Equatable {
  final String role;
  final String content;
  final String? name;
  final String? toolCallId;
  final List<ToolCallModel>? toolCalls;

  const ChatMessageModel({
    required this.role,
    required this.content,
    this.name,
    this.toolCallId,
    this.toolCalls,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);

  factory ChatMessageModel.system(String content) => ChatMessageModel(
        role: 'system',
        content: content,
      );

  factory ChatMessageModel.user(String content) => ChatMessageModel(
        role: 'user',
        content: content,
      );

  factory ChatMessageModel.assistant(String content,
          {List<ToolCallModel>? toolCalls}) =>
      ChatMessageModel(
        role: 'assistant',
        content: content,
        toolCalls: toolCalls,
      );

  factory ChatMessageModel.tool(String content, String toolCallId) =>
      ChatMessageModel(
        role: 'tool',
        content: content,
        toolCallId: toolCallId,
      );

  @override
  List<Object?> get props => [role, content, name, toolCallId, toolCalls];
}

/// Tool call model
@JsonSerializable()
class ToolCallModel extends Equatable {
  final String id;
  final String type;
  final FunctionCallModel function;

  const ToolCallModel({
    required this.id,
    required this.type,
    required this.function,
  });

  factory ToolCallModel.fromJson(Map<String, dynamic> json) =>
      _$ToolCallModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToolCallModelToJson(this);

  @override
  List<Object?> get props => [id, type, function];
}

/// Function call model
@JsonSerializable()
class FunctionCallModel extends Equatable {
  final String name;
  final String arguments;

  const FunctionCallModel({
    required this.name,
    required this.arguments,
  });

  factory FunctionCallModel.fromJson(Map<String, dynamic> json) =>
      _$FunctionCallModelFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionCallModelToJson(this);

  @override
  List<Object?> get props => [name, arguments];
}
