# AI Core Module

AI 核心模块，为玄学占测应用提供完整的 AI 大语言模型能力集成，包括流式对话、动态人设、Function Calling、多 Agent 协作与完整溯源审计。

## 🎯 功能特性

- **完整 AI 服务** (`AiService`): 提供开箱即用的会话管理、对话流程、人设加载等高级 API
- **LLM Provider 管理**: OpenAI 兼容的 LLM 接入层，支持流式响应、多模型切换
- **动态 Persona 系统**: 拟人化 AI 配置，支持在线编辑和即时应用，无需重启
- **智能会话管理** (`SessionManager`): 完整的对话持久化、历史恢复、上下文注入
- **Function Calling**: 完整的工具系统，允许 AI 自主调用占测工具
- **多 Agent 编排** (`AgentRunner`): 支持 Agent 递归调用与深度限制，实现跨技法协作
- **完整溯源审计**: 不可变的 SHA-256 审计链，可信的 API 调用与 Agent 调用记录
- **实时 UI 更新**: 基于 Provider 的流式数据推送，完美集成 Flutter 响应式 UI

## 📐 系统架构

```
┌─────────────────────────────────────┐
│         Flutter UI Widgets          │
│ (AiChatView, SettingsDialog, etc)   │
└────────────┬────────────────────────┘
             │
┌────────────▼────────────────────────┐
│      AiService (Main API)           │
│  • createSession()                  │
│  • resumeChat()                     │
│  • listSessions()                   │
│  • editPersona()                    │
└────────────┬────────────────────────┘
             │
    ┌────────┼────────┬──────────┐
    │        │        │          │
┌───▼──┐ ┌──▼───┐ ┌──▼─────┐ ┌─▼─────────────┐
│Chat  │ │LLM   │ │Session │ │ProviderFactory│
│Service│ │Service│ │Manager │ │& Tool Registry│
└───┬──┘ └──┬───┘ └──┬─────┘ └─┬─────────────┘
    │       │        │         │
    └───────┼────────┼─────────┘
            │        │
    ┌───────▼────────▼────────┐
    │    Drift ORM Database   │
    │  (14 Tables, 14 DAOs)   │
    │                         │
    │ • Personas & Models     │
    │ • Sessions & Messages   │
    │ • LLM Providers Config  │
    │ • Immutable Provenance  │
    │ • Usage Audits          │
    └─────────────────────────┘
```

### 关键服务说明

| 服务 | 职责 |
|-----|------|
| **AiService** | 高级 API，对外暴露的主要接口 |
| **ChatService** | 对话流程编排，消息处理与 Function Calling |
| **LlmService** | LLM 提供商管理，流式响应处理 |
| **SessionManager** | 会话持久化，历史消息加载与恢复 |
| **ToolRegistry** | 工具注册与 Function Calling 执行 |
| **AgentRunner** | 多 Agent 协作，递归调用管理 |
| **ProvenanceService** | 不可变审计链，SHA-256 完整性验证 |
| **ProviderFactory** | 动态配置工厂，支持运行时切换 |

## 🚀 快速开始

### 1. 初始化 AI 系统

使用 `ai_bootstrap` 工具一键初始化，确保数据库、LLM Provider、默认 Persona 等全部就绪：

```dart
import 'package:ai_core/utils/ai_bootstrap.dart';
import 'package:ai_core/database/ai_database.dart';
import 'package:ai_core/services/ai_service_impl.dart';
import 'package:get_it/get_it.dart';

// 应用启动时
final aiDatabase = AiDatabase();
await ensureDeepSeekProvider(aiDatabase, apiKey: 'sk-xxx');

final aiService = AiServiceImpl(
  db: aiDatabase,
  // ... 其他必要的服务
);

// 注入到 GetIt 或 Provider
GetIt.I.registerSingleton<AiService>(aiService);
```

### 2. 创建新会话（一行代码跳转到聊天界面）

```dart
// 最简单的方式：使用默认人设创建会话
await aiService.createSession(
  context: context,
  initialContext: AiContext(
    moduleName: 'xuan-qimen',
    intention: '请帮我分析这个奇门局',
  ),
);
```

或者手动选择人设：

```dart
// 显示人设选择器
final selectedPersona = await showModalBottomSheet<ResolvedPersona>(
  context: context,
  builder: (ctx) => PersonaSelectionSheet(
    onSelected: (persona) => Navigator.pop(ctx, persona),
  ),
);

if (selectedPersona != null) {
  await aiService.createSession(
    context: context,
    persona: selectedPersona,
    initialContext: AiContext(
      moduleName: 'xuan-qimen',
      intention: '请帮我分析这个奇门局',
      entities: [/* 动态实体 */],
    ),
  );
}
```

### 3. 恢复历史会话

```dart
// 传入已有的 Session UUID 即可恢复，历史消息自动加载
await aiService.resumeChat(
  context: context,
  sessionUuid: 'existing-session-uuid',
);
```

### 4. 列出所有会话

```dart
final sessions = await aiService.listSessions(
  personaUuid: 'optional-filter',
  status: 'active', // 或 'archived'
);

// 使用 ListView.builder 展示历史会话列表
for (final summary in sessions) {
  print('${summary.title} - ${summary.messageCount} 条消息');
}
```

### 5. 自定义聊天 UI（高级用法）

如需将聊天界面嵌入自己的 UI 中（而不是全屏跳转），直接使用 `AiChatView`。它提供完整的流式对话、实时消息更新、Person 动态切换等功能：

```dart
@override
Widget build(BuildContext context) {
  return AiChatView(
    persona: resolvedPersona,          // 动态 Persona 配置
    sessionUuid: sessionUuid,           // 会话 ID
    history: previousMessages,          // 历史消息（可选）
    welcomeMessage: '欢迎使用 AI',       // 欢迎语
    onPersonaChanged: (newPersona) {
      // 人设动态切换时触发
      print('Persona changed to: ${newPersona.name}');
    },
    onSessionEnd: (finalHistory) {
      // 对话结束或页面销毁时保存历史
      sessionManager.saveHistory(
        sessionUuid: sessionUuid,
        messages: finalHistory,
      );
    },
  );
}
```

## 🏗️ 核心概念

### Persona（人设）
一个完整的 AI 人设包含：
- **基本信息**: 名称、描述、风格特征
- **LLM 提供商**: 如 DeepSeek API
- **模型版本**: 如 deepseek-chat
- **System Prompt**: 个性化的系统提示词
- **Tool Bindings**: 可用的工具列表

Persona 是 **不可变的**，创建后不能修改。修改后会生成新的版本，旧版本保留用于审计追溯。

### Session（会话）
- 一个独立的对话会话
- 包含完整的消息历史（用户消息 + AI 响应）
- 绑定到一个特定的 Persona
- 支持上下文注入（`AiContext`）：包含模块名、用户意图、动态实体等

### Provider Factory 与动态切换
`ProviderFactory` 提供了一套工厂方法，允许在运行时动态地：
- 切换 LLM 提供商（如从 DeepSeek 切换到 OpenAI）
- 修改 Persona 配置
- 重新加载配置而无需重启应用

在 `AiChatView` 中点击"设置"按钮可打开 `AiChatSettingsDialog`，即时更改这些配置。

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
