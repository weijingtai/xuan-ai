import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tool_call.g.dart';

/// Represents an executed tool call with result
@JsonSerializable()
class ToolCallResult extends Equatable {
  final String toolCallId;
  final String toolName;
  final Map<String, dynamic> arguments;
  final dynamic result;
  final String? error;
  final bool isSuccess;
  final Duration? executionTime;

  const ToolCallResult({
    required this.toolCallId,
    required this.toolName,
    required this.arguments,
    this.result,
    this.error,
    required this.isSuccess,
    this.executionTime,
  });

  factory ToolCallResult.success({
    required String toolCallId,
    required String toolName,
    required Map<String, dynamic> arguments,
    required dynamic result,
    Duration? executionTime,
  }) =>
      ToolCallResult(
        toolCallId: toolCallId,
        toolName: toolName,
        arguments: arguments,
        result: result,
        isSuccess: true,
        executionTime: executionTime,
      );

  factory ToolCallResult.failure({
    required String toolCallId,
    required String toolName,
    required Map<String, dynamic> arguments,
    required String error,
    Duration? executionTime,
  }) =>
      ToolCallResult(
        toolCallId: toolCallId,
        toolName: toolName,
        arguments: arguments,
        error: error,
        isSuccess: false,
        executionTime: executionTime,
      );

  factory ToolCallResult.fromJson(Map<String, dynamic> json) =>
      _$ToolCallResultFromJson(json);

  Map<String, dynamic> toJson() => _$ToolCallResultToJson(this);

  @override
  List<Object?> get props =>
      [toolCallId, toolName, arguments, result, error, isSuccess, executionTime];
}

/// Pending tool call waiting for execution
@JsonSerializable()
class PendingToolCall extends Equatable {
  final String id;
  final String name;
  final Map<String, dynamic> arguments;
  final DateTime createdAt;

  const PendingToolCall({
    required this.id,
    required this.name,
    required this.arguments,
    required this.createdAt,
  });

  factory PendingToolCall.fromJson(Map<String, dynamic> json) =>
      _$PendingToolCallFromJson(json);

  Map<String, dynamic> toJson() => _$PendingToolCallToJson(this);

  @override
  List<Object?> get props => [id, name, arguments, createdAt];
}
