import 'dart:async';
import '../../models/tool_call.dart';
import 'tool_registry.dart';

/// Tool executor with middleware support
class ToolExecutor {
  final ToolRegistry _registry;
  final List<ToolMiddleware> _middleware = [];

  ToolExecutor(this._registry);

  /// Add middleware to the execution pipeline
  void use(ToolMiddleware middleware) {
    _middleware.add(middleware);
  }

  /// Execute a tool with middleware pipeline
  Future<ToolCallResult> execute(
    String name,
    Map<String, dynamic> arguments, {
    Map<String, dynamic>? context,
  }) async {
    // Build middleware chain
    ToolHandler handler = (args) => _registry.executeTool(name, args);

    for (final middleware in _middleware.reversed) {
      final next = handler;
      handler = (args) => middleware.handle(name, args, context, next);
    }

    return await handler(arguments) as ToolCallResult;
  }

  /// Execute with confirmation requirement
  Future<ToolCallResult> executeWithConfirmation(
    String name,
    Map<String, dynamic> arguments, {
    required Future<bool> Function(String toolName, Map<String, dynamic> args)
        confirmHandler,
    Map<String, dynamic>? context,
  }) async {
    // Check if tool requires confirmation
    final definition = _registry.getToolDefinition(name);
    if (definition == null) {
      return ToolCallResult.failure(
        toolCallId: DateTime.now().millisecondsSinceEpoch.toString(),
        toolName: name,
        arguments: arguments,
        error: 'Tool not found: $name',
      );
    }

    // Request confirmation
    final confirmed = await confirmHandler(name, arguments);
    if (!confirmed) {
      return ToolCallResult.failure(
        toolCallId: DateTime.now().millisecondsSinceEpoch.toString(),
        toolName: name,
        arguments: arguments,
        error: 'Tool execution cancelled by user',
      );
    }

    return await execute(name, arguments, context: context);
  }
}

/// Middleware for tool execution pipeline
abstract class ToolMiddleware {
  Future<ToolCallResult> handle(
    String toolName,
    Map<String, dynamic> arguments,
    Map<String, dynamic>? context,
    ToolHandler next,
  );
}

/// Type alias
typedef ToolHandler = Future<ToolCallResult> Function(
    Map<String, dynamic> arguments);

/// Logging middleware
class LoggingMiddleware implements ToolMiddleware {
  final void Function(String message)? onLog;

  LoggingMiddleware({this.onLog});

  @override
  Future<ToolCallResult> handle(
    String toolName,
    Map<String, dynamic> arguments,
    Map<String, dynamic>? context,
    ToolHandler next,
  ) async {
    final startTime = DateTime.now();
    onLog?.call('Executing tool: $toolName with args: $arguments');

    final result = await next(arguments);

    final duration = DateTime.now().difference(startTime);
    onLog?.call(
        'Tool $toolName completed in ${duration.inMilliseconds}ms: ${result.isSuccess ? "success" : "failure"}');

    return result;
  }
}

/// Validation middleware
class ValidationMiddleware implements ToolMiddleware {
  final ToolRegistry registry;

  ValidationMiddleware(this.registry);

  @override
  Future<ToolCallResult> handle(
    String toolName,
    Map<String, dynamic> arguments,
    Map<String, dynamic>? context,
    ToolHandler next,
  ) async {
    final definition = registry.getToolDefinition(toolName);
    if (definition == null) {
      return ToolCallResult.failure(
        toolCallId: DateTime.now().millisecondsSinceEpoch.toString(),
        toolName: toolName,
        arguments: arguments,
        error: 'Tool not found: $toolName',
      );
    }

    // Validate required parameters
    final params = definition.function.parameters;
    if (params != null) {
      final required = params['required'] as List<dynamic>? ?? [];
      for (final param in required) {
        if (!arguments.containsKey(param)) {
          return ToolCallResult.failure(
            toolCallId: DateTime.now().millisecondsSinceEpoch.toString(),
            toolName: toolName,
            arguments: arguments,
            error: 'Missing required parameter: $param',
          );
        }
      }
    }

    return await next(arguments);
  }
}

/// Rate limiting middleware
class RateLimitMiddleware implements ToolMiddleware {
  final int maxCallsPerMinute;
  final Map<String, List<DateTime>> _callHistory = {};

  RateLimitMiddleware({this.maxCallsPerMinute = 60});

  @override
  Future<ToolCallResult> handle(
    String toolName,
    Map<String, dynamic> arguments,
    Map<String, dynamic>? context,
    ToolHandler next,
  ) async {
    final now = DateTime.now();
    final oneMinuteAgo = now.subtract(const Duration(minutes: 1));

    // Clean old entries
    _callHistory[toolName] = (_callHistory[toolName] ?? [])
        .where((t) => t.isAfter(oneMinuteAgo))
        .toList();

    // Check rate limit
    if ((_callHistory[toolName]?.length ?? 0) >= maxCallsPerMinute) {
      return ToolCallResult.failure(
        toolCallId: DateTime.now().millisecondsSinceEpoch.toString(),
        toolName: toolName,
        arguments: arguments,
        error: 'Rate limit exceeded for tool: $toolName',
      );
    }

    // Record call
    _callHistory[toolName] = [...(_callHistory[toolName] ?? []), now];

    return await next(arguments);
  }
}
