# AI 占测系统 - 任务列表

## 已完成 ✅

### 基础架构
- [x] 创建 ai_core 模块
- [x] 配置 pubspec.yaml / build.yaml
- [x] 创建目录结构

### 数据库层
- [x] 表定义 (14个表)
- [x] DAO 实现 (14个DAO)
- [x] 数据库主类
- [x] 初始数据 seed

### 模型层
- [x] ChatMessageModel
- [x] LlmRequestModel
- [x] LlmResponseModel
- [x] ToolDefinition
- [x] ToolCallResult

### 服务层
- [x] LlmClient / OpenAICompatibleClient
- [x] LlmService
- [x] PromptService
- [x] VariableSubstitutor
- [x] ChatPersistenceService
- [x] ChatService
- [x] ToolRegistry
- [x] ToolExecutor
- [x] DivinationSkillInterface
- [x] ProvenanceService
- [x] AgentOrchestrator

### UI 层
- [x] AiChatViewModel
- [x] AiChatWindow
- [x] ChatMessageBubble
- [x] ChatInputBar
- [x] PersonaSelector

### 集成
- [x] 更新主项目 pubspec.yaml
- [x] 添加为 git submodule

## 待完成 📋

### 代码生成
- [ ] `flutter pub get`
- [ ] `flutter pub run build_runner build`

### 技法模块集成
- [ ] qimendunjia 实现 DivinationSkillInterface
- [ ] qizhengsiyu 实现 DivinationSkillInterface
- [ ] taiyishenshu 实现 DivinationSkillInterface
- [ ] daliuren 实现 DivinationSkillInterface

### 主应用集成
- [ ] 添加 Provider 配置
- [ ] 添加 AI 对话入口
- [ ] 测试完整流程

### API 配置
- [ ] API 配置 UI
- [ ] API Key 加密存储
- [ ] 连接测试

### 测试
- [ ] 单元测试
- [ ] 集成测试
- [ ] E2E 测试
