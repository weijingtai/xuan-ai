# 子模块 AI 集成指南 (Integration Guide)

本文档面向其他子模块（如八字、奇门、六壬等）的开发者，指导如何接入 `xuan-ai` 提供的 AI 能力。

## 场景 1：在模块内发起 AI 分析 (Link A)

这是最常见的场景：用户在你的模块界面点击“AI 分析”按钮，系统启动一个 AI 会话来解读当前排盘数据。

### 1. 准备上下文数据 (AiContext)

首先，你需要将你的业务数据（如排盘结果）封装为 `AiEntity`，并放入 `AiContext`。

```dart
// 示例：八字模块 (xuan-bazi)
import 'package:common/domain/ai/ai_context.dart';

AiContext buildBaziContext(BaziChart chart) {
  return AiContext(
    moduleName: 'xuan-bazi', // 必填：你的模块唯一标识
    intention: '请分析这个八字的格局和喜用神', // 用户的初始意图
    entities: [
      AiEntity(
         id: chart.id,
         type: 'bazi_chart',
         name: '${chart.ownerName}的八字',
         description: chart.toTextDescription(), // 供 LLM 阅读的文本描述
         data: chart.toJson(), // 供程序处理的结构化数据
      ),
    ],
  );
}
```

### 2. 通过 SessionManager 启动会话

使用 `AiService` 创建会话并跳转。建议使用 `resolvePersona` 来获取一个特定的人设（或者让用户选择）。

```dart
void onAnalyzeButtonPressed(BuildContext context, BaziChart chart) async {
  final aiService = context.read<AiService>();
  
  // 1. 准备上下文
  final aiContext = buildBaziContext(chart);
  
  // 2. 获取人设 (可以是默认的，也可以是该模块特定的专家人设)
  // 如果你需要让用户选，可以使用 aiService.showPersonaSelector()
  final defaultPersona = await aiService.resolvePersona('bazi-master-uuid'); 
  
  if (defaultPersona == null) {
      // 处理人设未找到的情况
      return;
  }

  // 3. 创建并启动会话
  // 这会自动跳转到聊天界面
  await aiService.createSession(
    context: context,
    persona: defaultPersona,
    initialContext: aiContext,
  );
}
```

## 场景 2：嵌入式聊天窗口

如果你不希望跳转到全屏聊天页面，而是想在你的模块侧边栏显示 AI 助手：

```dart
class BaziAnalysisPanel extends StatefulWidget {
    final BaziChart chart;
    // ...
}

class _BaziAnalysisPanelState extends State<BaziAnalysisPanel> {
    String? _sessionUuid;
    ResolvedPersona? _persona;
    
    @override
    void initState() {
        super.initState();
        _initSession();
    }
    
    Future<void> _initSession() async {
        final aiService = context.read<AiService>();
        
        // 1. 解析人设
        _persona = await aiService.resolvePersona('bazi-master-uuid');
        
        // 2. 创建会话 (注意：这里只创建数据，不跳转)
        // SessionManager 在 xuan-ai 内部，通常通过 AiService 暴露的 createSession 
        // 但 AiService.createSession 会跳转。
        // 如果要嵌入，我们需要分别调用：
        
        // 目前 AiService 暂未暴露纯数据创建接口 (TODO)，
        // 建议暂时通过 AiService.createSession 跳转，
        // 或者等待 SDK 升级支持纯数据会话创建。
        
        // 假设我们有了 sessionUuid:
        // _sessionUuid = await aiService.sessionManager.createSession(...)
    }

    @override
    Widget build(BuildContext context) {
        if (_sessionUuid == null || _persona == null) {
            return CircularProgressIndicator();
        }
        
        return AiChatView(
            persona: _persona!,
            sessionUuid: _sessionUuid!,
            onSessionEnd: (history) {
                // 记得保存历史！
                context.read<AiService>().saveHistory(_sessionUuid!, history);
            },
        );
    }
}
```

*(注：当前 version 的 `AiService` 主要是为跳转设计的，嵌入式支持正在完善中。)*

## 场景 3：为 AI 提供工具 (Link B)

如果你希望 AI 能够反过来调用你的模块功能（例如“重新排盘”、“查询万年历”），你需要注册 `AgentTool`。

### 1. 定义工具

```dart
import 'package:common/domain/ai/agent_tool.dart';

class ReplotBaziTool extends AgentTool {
  @override
  String get name => 'replot_bazi';

  @override
  String get description => '根据新的日期重新排八字';

  @override
  Map<String, dynamic> get parametersSchema => {
    'type': 'object',
    'properties': {
      'year': {'type': 'integer'},
      'month': {'type': 'integer'},
      'day': {'type': 'integer'},
      'hour': {'type': 'integer'},
    },
    'required': ['year', 'month', 'day', 'hour'],
  };

  @override
  Future<Map<String, dynamic>> execute(Map<String, dynamic> args) async {
    // 调用你的业务逻辑
    final newChart = BaziEngine.plot(
        args['year'], args['month'], args['day'], args['hour']
    );
    
    return {
        'status': 'success',
        'result': newChart.toTextDescription(),
    };
  }
}
```

### 2. 注册工具

在你的模块初始化代码中注册工具：

```dart
// 在 App 启动或模块加载时
final aiService = GetIt.I<AiService>();
aiService.registerTool(ReplotBaziTool());
```

一旦注册，任何使用 `xuan-ai` 的 Agent 在对话中都可以根据语义自动调用这个工具。

## 场景 4：注册自定义动作 (Actions)

如果你想在聊天输入框上方添加快捷指令按钮（例如“查看格局”、“计算强弱”）：

```dart
import 'package:common/domain/ai/ai_action.dart';

class CheckStructureAction extends AiAction {
  @override
  String get id => 'bazi_check_structure';

  @override
  String get label => '查看格局';

  @override
  Future<void> execute(BuildContext context, AiContext aiContext) async {
      // 这里可以发送一条特定消息给 AI，或者直接弹窗显示信息
      
      // 方式 1：让 AI 分析
      final aiService = context.read<AiService>();
      // 发送隐藏指令给 AI ... (需支持 sendMessage API)
  }
}

// 注册
aiService.registerAction(CheckStructureAction());
```

---

## 最佳实践 checklist

- [ ] **Context 包含完整信息**：确保 `AiEntity.description` 包含足够详尽的文本描述，因为 LLM 主要靠读这个。
- [ ] **不要硬编码人设**：尽量允许用户配置或选择 Persona，不同流派可能有不同的人设偏好。
- [ ] **流式处理**：AI 响应通常是流式的，UI 设计要适应在这个过程中逐步显示内容。
- [ ] **Error Handling**：AI 服务可能不可用（网络问题、Key 过期），调用 `createSession` 时要做好 try-catch。
