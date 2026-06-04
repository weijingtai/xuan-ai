import '../ai/ai_action.dart';
import '../ai/agent_tool.dart';

/// Central registry for AI components (Actions and Tools).
///
/// Sub-modules should call [register] during their initialization to
/// expose their capabilities to the AI service.
///
/// Example:
/// ```dart
/// class MyModule {
///   static void init() {
///     AiRegistry.register(
///       actions: [MyAction()],
///       tools: [MyTool()],
///     );
///   }
/// }
/// ```
class AiRegistry {
  static final List<AiAction> _actions = [];
  static final List<AgentTool> _tools = [];

  /// Get all registered actions.
  static List<AiAction> get actions => List.unmodifiable(_actions);

  /// Get all registered tools.
  static List<AgentTool> get tools => List.unmodifiable(_tools);

  /// Register new AI components.
  static void register({
    List<AiAction>? actions,
    List<AgentTool>? tools,
  }) {
    if (actions != null) {
      for (final action in actions) {
        if (!_actions.any((a) => a.id == action.id)) {
          _actions.add(action);
        }
      }
    }
    if (tools != null) {
      for (final tool in tools) {
        if (!_tools.any((t) => t.name == tool.name)) {
          _tools.add(tool);
        }
      }
    }
  }

  /// Clear all registrations (mainly for testing).
  static void clear() {
    _actions.clear();
    _tools.clear();
  }
}
