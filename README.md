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

```
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

## 使用方式

```dart
import 'package:ai_core/ai_core.dart';

// 初始化
final aiCore = AICore();
await aiCore.initialize();

// 创建对话会话
final session = await aiCore.createChatSession(
  personaUuid: 'default-persona',
  divinationUuid: 'divination-123',
);

// 发送消息并获取流式响应
final stream = aiCore.sendMessage(
  sessionId: session.uuid,
  content: '请分析这个八字的格局',
);

await for (final chunk in stream) {
  print(chunk.content);
}
```

## 数据库表

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
