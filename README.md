# AI Core Module

AI 核心模块，为玄学占测应用提供 AI 大语言模型能力集成。

## 功能特性

- **LLM Provider**: OpenAI 兼容的 LLM 接入层，支持流式响应
- **Prompt 管理**: Prompt 模板的版本化管理与技法绑定
- **AI Persona**: 拟人化 AI 配置，支持不同风格的占测解读
- **对话系统**: 完整的对话持久化与会话管理
- **工具系统**: Function Calling 支持，允许 AI 调用占测工具
- **溯源系统**: 完整的 API 调用记录与可信回溯
- **Agent 编排**: 多 Agent 协作，支持跨技法调用

## 架构

```text
ai_core/
├── lib/
│   ├── ai_core.dart              # 导出文件
│   ├── database/                  # Drift 数据库
│   │   ├── ai_database.dart      # 数据库定义
│   │   ├── tables/               # 表定义
│   │   └── daos/                 # DAO 层
│   ├── models/                    # 数据模型
│   ├── services/                  # 业务服务
│   │   ├── llm/                  # LLM 服务
│   │   ├── prompt/               # Prompt 管理
│   │   ├── chat/                 # 对话服务
│   │   ├── tool/                 # 工具系统
│   │   ├── provenance/           # 溯源服务
│   │   └── agent/                # Agent 编排
│   ├── viewmodels/               # ViewModel 层
│   └── widgets/                  # UI 组件
└── assets/
    └── prompts/                  # 默认 Prompt 模板
```

## 核心调用方案 (Session Management)

本模块提供了完整的会话管理能力，包括会话的创建、恢复、持久化以及 UI 的展示。

### 1. 依赖注入

首先确保 `AiService` 和 `AiDatabase` 已正确初始化并注入到你的应用中（通常使用 `Provider` 或 `GetIt`）。

```dart
final aiDatabase = AiDatabase();
final aiService = AiServiceImpl(
  llmService: LlmServiceImpl(db: aiDatabase),
  db: aiDatabase,
);
```

### 2. 创建新会话 (createSession)

创建一个新的聊天会话，并自动跳转到聊天界面。

```dart
// 1. 获取/解析目标 Persona
// 这里的 personaUuid 可以来自用户选择，或者使用默认人设
final personaUuid = '...'; 
final persona = await aiService.resolvePersona(personaUuid);

if (persona != null) {
  // 2. 创建会话并打开 UI
  final sessionUuid = await aiService.createSession(
    context: context,
    persona: persona,
    initialContext: AiContext(
      moduleName: 'xuan-qimen',
      intention: '请帮我分析这个奇门局',
      entities: [/* ... */],
    ),
  );
  
  print('Session created: $sessionUuid');
}
```

### 3. 恢复历史会话 (resumeChat)

从数据库恢复已有的会话，加载历史消息并跳转到聊天界面。

```dart
// 传入已有的 Session UUID
await aiService.resumeChat(
  context: context,
  sessionUuid: 'existing-session-uuid',
);
```

### 4. 列出会话 (listSessions)

获取会话列表，用于展示历史记录。

```dart
final sessions = await aiService.listSessions(
  // 可选：过滤特定人设
  personaUuid: '...', 
  // 可选：过滤状态 (active, archived)
  status: 'active',
);

for (final summary in sessions) {
  print('${summary.title} - ${summary.updatedAt}');
}
```

### 5. 自定义嵌入聊天视图 (AiChatView)

如果需要将聊天界面嵌入到自己的 UI 中（而不是使用 `AiService` 提供的全屏跳转），可以直接使用 `AiChatView`。

**注意**：`AiChatView` 是纯展示组件，不直接访问数据库。它需要上层提供 `ResolvedPersona` 和 `Session UUID`，并在会话结束时负责保存历史。

```dart
class MyEmbeddedChat extends StatefulWidget {
  final ResolvedPersona persona;
  final String sessionUuid;
  final List<ChatMessage>? history; // 如果是恢复会话，传入历史消息

  // ...
}

class _MyEmbeddedChatState extends State<MyEmbeddedChat> {
  // ...

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AiChatView(
        // 必填：人设配置（Provider/Model/Prompt 信息来源）
        persona: widget.persona,
        
        // 必填：Session ID（用于关联）
        sessionUuid: widget.sessionUuid,
        
        // 可选：历史消息（用于恢复上下文）
        history: widget.history,
        
        // 可选：欢迎语
        welcomeMessage: '您好，我是${widget.persona.name}，请问有什么可以帮您？',
        
        // 必填：会话结束/页面销毁时的回调
        // 必须在此处调用 SessionManager 保存历史记录
        onSessionEnd: (history) {
          GetIt.I<SessionManager>().saveHistory(
            sessionUuid: widget.sessionUuid,
            history: history,
          );
        },
      ),
    );
  }
}
```

## 数据库表结构

### LLM 配置层

- `t_llm_providers` - LLM 提供商配置
- `t_llm_models` - LLM 模型版本

### Prompt 管理层

- `t_prompt_templates` - Prompt 模板（可编辑）
- `t_prompt_versions` - Prompt 版本历史（不可变）
- `t_prompt_skill_bindings` - Prompt 技法绑定

### AI 人设层

- `t_ai_personas` - 拟人化 AI 配置

### 对话管理层

- `t_ai_chat_sessions` - 对话会话
- `t_ai_chat_messages` - 对话消息
- `t_ai_api_calls` - API 调用记录

### 溯源层

- `t_ai_provenance` - 完整溯源记录（不可变）

### AI 占测结果层

- `t_ai_divinations` - AI 占测结果

### Agent 调用层

- `t_agent_invocations` - Agent 调用记录

### 审计层

- `t_ai_usage_audits` - 使用审计
