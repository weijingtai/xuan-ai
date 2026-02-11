import 'package:common/domain/ai/agent_tool.dart';
import 'package:common/domain/gui/window_manager.dart';

/// 窗口控制工具
///
/// 允许 AI 控制应用程序窗口的状态（大小、位置、最小化等）。
class WindowControlTool implements AgentTool {
  final WindowManager _windowManager;

  WindowControlTool(this._windowManager);

  @override
  String get name => 'window_control';

  @override
  String get description => '控制应用程序窗口的状态，包括调整大小、最小化、最大化、关闭、居中等操作。';

  @override
  Map<String, dynamic> get parametersSchema => {
    'type': 'object',
    'properties': {
      'action': {
        'type': 'string',
        'enum': [
          'minimize',
          'maximize',
          'restore',
          'close',
          'center',
          'resize',
          'set_title',
        ],
        'description': '要执行的操作类型',
      },
      'width': {'type': 'number', 'description': '窗口宽度（仅 resize 操作需要）'},
      'height': {'type': 'number', 'description': '窗口高度（仅 resize 操作需要）'},
      'title': {'type': 'string', 'description': '窗口标题（仅 set_title 操作需要）'},
    },
    'required': ['action'],
  };

  @override
  Future<Map<String, dynamic>> execute(Map<String, dynamic> args) async {
    final action = args['action'] as String;

    try {
      switch (action) {
        case 'minimize':
          await _windowManager.minimize();
          return {'result': 'Window minimized'};
        case 'maximize':
          await _windowManager.maximize();
          return {'result': 'Window maximized'};
        case 'restore':
          await _windowManager.restore();
          return {'result': 'Window restored'};
        case 'close':
          await _windowManager.close();
          return {'result': 'Window closed'};
        case 'center':
          await _windowManager.center();
          return {'result': 'Window centered'};
        case 'resize':
          final width = args['width'] as num?;
          final height = args['height'] as num?;
          if (width != null && height != null) {
            await _windowManager.setSize(width.toDouble(), height.toDouble());
            return {'result': 'Window resized to ${width}x${height}'};
          } else {
            return {'error': 'Width and height are required for resize action'};
          }
        case 'set_title':
          final title = args['title'] as String?;
          if (title != null) {
            await _windowManager.setTitle(title);
            return {'result': 'Window title set to "$title"'};
          } else {
            return {'error': 'Title is required for set_title action'};
          }
        default:
          return {'error': 'Unknown action: $action'};
      }
    } catch (e) {
      return {'error': 'Failed to execute window action: $e'};
    }
  }

  @override
  Map<String, dynamic> toFunctionDeclaration() {
    return {
      'type': 'function',
      'function': {
        'name': name,
        'description': description,
        'parameters': parametersSchema,
      },
    };
  }
}
