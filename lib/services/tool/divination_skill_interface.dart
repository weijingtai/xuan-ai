import '../../models/tool_definition.dart';

/// Interface that divination skill modules must implement
/// to expose their functionality to the AI system.
abstract class DivinationSkillInterface {
  /// Get the skill ID (corresponds to Skills table)
  int get skillId;

  /// Get the skill name
  String get skillName;

  /// Get the skill description for AI context
  String get skillDescription;

  /// Get the list of tools this skill provides
  List<ToolDefinition> getTools();

  /// Execute a tool by name
  Future<dynamic> executeTool(String toolName, Map<String, dynamic> arguments);

  /// Get the current divination panel data (for AI context)
  Future<Map<String, dynamic>?> getPanelData(String panelUuid);

  /// Get element explanation (for teaching mode)
  Future<String?> getElementExplanation(String elementType, String elementValue);

  /// Check if this skill can handle a divination type
  bool canHandleDivinationType(String divinationTypeUuid);
}

/// Base implementation with common functionality
abstract class BaseDivinationSkillInterface implements DivinationSkillInterface {
  @override
  Future<dynamic> executeTool(
      String toolName, Map<String, dynamic> arguments) async {
    final handlers = getToolHandlers();
    final handler = handlers[toolName];
    if (handler == null) {
      throw Exception('Unknown tool: $toolName');
    }
    return await handler(arguments);
  }

  /// Override this to provide tool handlers
  Map<String, Future<dynamic> Function(Map<String, dynamic>)> getToolHandlers();

  /// Default implementation - override in subclass
  @override
  Future<Map<String, dynamic>?> getPanelData(String panelUuid) async {
    return null;
  }

  /// Default implementation - override in subclass
  @override
  Future<String?> getElementExplanation(
      String elementType, String elementValue) async {
    return null;
  }

  /// Default implementation - override in subclass
  @override
  bool canHandleDivinationType(String divinationTypeUuid) {
    return false;
  }
}

/// Example skill interface for Qimen Dunjia
/// This would be implemented in the qimendunjia module
class QimenDunjiaSkillInterfaceExample extends BaseDivinationSkillInterface {
  @override
  int get skillId => 1; // Qimen Dunjia skill ID

  @override
  String get skillName => '奇门遁甲';

  @override
  String get skillDescription => '''
奇门遁甲是中国古代的一种占卜术,以天时、地利、人和为核心,
通过分析天盘、地盘、人盘、神盘的关系来预测吉凶祸福。
主要用于择日、出行、求财、问事等。
''';

  @override
  List<ToolDefinition> getTools() {
    return [
      ToolDefinition(
        function: FunctionDefinition(
          name: 'qimen_get_panel',
          description: '获取奇门遁甲式盘的详细数据',
          parameters: {
            'type': 'object',
            'properties': {
              'panel_uuid': {
                'type': 'string',
                'description': '式盘的UUID',
              },
            },
            'required': ['panel_uuid'],
          },
        ),
      ),
      ToolDefinition(
        function: FunctionDefinition(
          name: 'qimen_analyze_hour_palace',
          description: '分析时辰落宫的象意',
          parameters: {
            'type': 'object',
            'properties': {
              'panel_uuid': {
                'type': 'string',
                'description': '式盘的UUID',
              },
            },
            'required': ['panel_uuid'],
          },
        ),
      ),
      ToolDefinition(
        function: FunctionDefinition(
          name: 'qimen_explain_element',
          description: '解释奇门遁甲中某个元素的含义',
          parameters: {
            'type': 'object',
            'properties': {
              'element_type': {
                'type': 'string',
                'description': '元素类型: star(九星), door(八门), god(八神), gan(天干), gong(九宫)',
                'enum': ['star', 'door', 'god', 'gan', 'gong'],
              },
              'element_value': {
                'type': 'string',
                'description': '元素值,如"天蓬"、"休门"等',
              },
            },
            'required': ['element_type', 'element_value'],
          },
        ),
      ),
    ];
  }

  @override
  Map<String, Future<dynamic> Function(Map<String, dynamic>)> getToolHandlers() {
    return {
      'qimen_get_panel': _getPanel,
      'qimen_analyze_hour_palace': _analyzeHourPalace,
      'qimen_explain_element': _explainElement,
    };
  }

  Future<Map<String, dynamic>> _getPanel(Map<String, dynamic> args) async {
    // This would be implemented to fetch actual panel data
    return {
      'message': 'Panel data retrieval not implemented in example',
    };
  }

  Future<Map<String, dynamic>> _analyzeHourPalace(
      Map<String, dynamic> args) async {
    return {
      'message': 'Hour palace analysis not implemented in example',
    };
  }

  Future<String> _explainElement(Map<String, dynamic> args) async {
    final elementType = args['element_type'] as String;
    final elementValue = args['element_value'] as String;
    return '解释 $elementType: $elementValue - 详细解释待实现';
  }

  @override
  Future<String?> getElementExplanation(
      String elementType, String elementValue) async {
    return await _explainElement({
      'element_type': elementType,
      'element_value': elementValue,
    });
  }
}
