# AI 占测系统 - 实现计划

## 架构决策

### 1. 模块化设计
- **决策**: 创建独立的 `ai_core` Flutter 包
- **理由**: 关注点分离，可独立测试，易于维护

### 2. 数据库设计
- **决策**: 使用 Drift ORM，独立数据库
- **理由**: 与主应用数据库隔离，类型安全

### 3. LLM 集成
- **决策**: OpenAI 兼容 API
- **理由**: 广泛的提供商支持，标准化接口

### 4. 溯源设计
- **决策**: 不可变版本历史 + 哈希校验
- **理由**: 确保可信回溯，支持审计

## 目录结构

```
ai_core/
├── lib/
│   ├── ai_core.dart
│   ├── database/
│   │   ├── ai_database.dart
│   │   ├── tables/
│   │   └── daos/
│   ├── models/
│   ├── services/
│   │   ├── llm/
│   │   ├── prompt/
│   │   ├── chat/
│   │   ├── tool/
│   │   ├── provenance/
│   │   └── agent/
│   ├── viewmodels/
│   └── widgets/
├── assets/prompts/
└── docs/ai/
```

## 实现阶段

### Phase 1: 基础架构 ✅
- ai_core 包结构
- pubspec.yaml 配置

### Phase 2: 数据库层 ✅
- 14 个表定义
- DAO 实现

### Phase 3: 模型层 ✅
- ChatMessageModel
- LlmRequestModel / LlmResponseModel
- ToolDefinition / ToolCallResult

### Phase 4: LLM 服务层 ✅
- OpenAICompatibleClient
- 流式 SSE 解析
- LlmService

### Phase 5: Prompt 系统 ✅
- PromptService
- VariableSubstitutor

### Phase 6: 对话系统 ✅
- ChatPersistenceService
- ChatService

### Phase 7: 工具系统 ✅
- ToolRegistry
- DivinationSkillInterface

### Phase 8: 溯源系统 ✅
- ProvenanceService

### Phase 9: Agent 系统 ✅
- AgentOrchestrator

### Phase 10: UI 层 ✅
- AiChatViewModel
- AiChatWindow
- ChatMessageBubble
- ChatInputBar
- PersonaSelector

## 集成步骤

```yaml
# pubspec.yaml
ai_core:
  path: ./ai_core
```

```dart
// 初始化
final aiDatabase = AiDatabase();

// 使用
AiChatWindow(
  divinationUuid: 'xxx',
  initialContext: {...},
)
```
