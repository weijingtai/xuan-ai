# AI 交互系统 - 开发任务清单

> 基于 `Plans_zh.md` 拆解。每项任务应在完成后标记 `[x]`。

---

## 第一阶段：核心框架 (`xuan-common`)

### 1.1 通信数据模型

- [x] 创建 `lib/domain/ai/ai_entity.dart`
  - [x] 定义 `AiEntity` 类：`id`, `type`, `name`, `description`, `rawData`
  - [x] 添加 `toJson()` / `fromJson()` 序列化方法
- [x] 创建 `lib/domain/ai/ai_context.dart`
  - [x] 定义 `AiContext` 类：`intention`, `entities`, `systemPromptOverride`
  - [x] 添加 `toJson()` / `fromJson()` 序列化方法

### 1.2 Link A 接口 (`AiAction`)

- [x] 创建 `lib/domain/ai/ai_action.dart`
  - [x] 定义 `abstract class AiAction`
    - [x] `String get id`
    - [x] `String get label`
    - [x] `IconData? get icon`
    - [x] `bool isApplicable(AiContext context)`
    - [x] `Future<void> execute({BuildContext context, AiContext aiContext})`

### 1.3 Link B 接口 (`AgentTool`)

- [x] 创建 `lib/domain/ai/agent_tool.dart`
  - [x] 定义 `abstract class AgentTool`
    - [x] `String get name` — LLM 函数名
    - [x] `String get description` — LLM 函数描述
    - [x] `Map<String, dynamic> get parametersSchema` — JSON Schema
    - [x] `Future<Map<String, dynamic>> execute(Map<String, dynamic> args)`
  - [x] 添加 `toFunctionDeclaration()` 辅助方法（输出符合 OpenAI/DeepSeek 格式的 JSON）

### 1.4 服务接口

- [x] 创建 `lib/services/ai_service.dart`
  - [x] `Future<void> openChat({BuildContext context, AiContext? initialContext})`
  - [x] `Future<String> analyze({AiContext context})`
  - [x] `Future<String?> getSummary({String entityId})`
  - [x] `Stream<String?> watchSummary({String entityId})`
  - [x] `Future<bool> showConfigSheet({BuildContext context})`
  - [x] `Stream<AiConfigSummary> get activeConfig`
  - [x] `void registerAction(AiAction action)`
  - [x] `List<AiAction> getAvailableActions(AiContext context)`
  - [x] `void registerTool(AgentTool tool)`
  - [x] `List<AgentTool> getAvailableTools()`
- [x] 创建 `lib/domain/ai/ai_config_summary.dart`
  - [x] 定义 `AiConfigSummary`：`personaName`, `modelName`

### 1.5 审计接口

- [x] 创建 `lib/domain/ai/ai_audit_log.dart`
  - [x] 定义 `AiAuditLog` 数据模型
    - [x] `id` (UUID)
    - [x] `timestamp` (DateTime)
    - [x] `type` (枚举: `chat`, `actionCall`, `toolCall`, `toolResult`)
    - [x] `sourceModule` (String)
    - [x] `payload` (JSON Map)
- [x] 创建 `lib/services/ai_audit_service.dart`
  - [x] `Future<void> logInteraction(AiAuditLog log)`
  - [x] `Future<List<AiAuditLog>> queryLogs({String? sourceModule, DateTime? after})`

### 1.6 单元测试 (xuan-common)

- [ ] 测试 `AiEntity` 序列化/反序列化 (待集成测试环境)
- [ ] 测试 `AiContext` 序列化/反序列化 (待集成测试环境)
- [ ] 测试 `AgentTool.toFunctionDeclaration()` 输出格式 (待集成测试环境)

---

## 第二阶段：AI 服务实现 (`xuan-ai`)

### 2.1 服务实现

- [ ] 创建 `lib/services/ai_service_impl.dart`
  - [ ] 实现 `AiService` 接口
  - [ ] 维护 `_actions` (List<AiAction>) 注册表
  - [ ] 维护 `_tools` (List<AgentTool>) 注册表
  - [ ] 实现 `openChat` — 构建初始消息 & 导航
  - [ ] 实现 `analyze` — 后台调用 LLM
  - [ ] 实现 `getSummary` / `watchSummary` — 查询 `AiDivinationsDao`
  - [ ] 实现 `showConfigSheet` — 弹出 BottomSheet
  - [ ] 实现 `activeConfig` — BehaviorSubject 流

### 2.2 Agent Runner (Function Calling 执行器)

- [ ] 创建 `lib/services/agent_runner.dart`（或集成到 Provider 中）
  - [ ] 将已注册的 `AgentTool` 列表转化为 LLM `tools` 参数
  - [ ] 解析 LLM 响应中的 `tool_calls` JSON
  - [ ] 根据 `name` 在注册表中查找对应 `AgentTool`
  - [ ] 执行 `tool.execute(args)` 并获取结果
  - [ ] 将结果回传给 LLM (构造 `tool` role 消息)
  - [ ] 处理执行错误（超时、异常）并友好展示

### 2.3 Chat UI 增强

- [ ] 修改 `lib/widgets/ai_chat_view.dart`
  - [ ] 接受 `AiContext` 参数
  - [ ] 在聊天顶部渲染"上下文卡片"（展示 `AiEntity` 摘要）
  - [ ] 动态渲染 Action 按钮栏（来自 `getAvailableActions`）
  - [ ] 渲染 Tool 执行中的加载指示器
  - [ ] 渲染 Tool 返回结果（如"已搜索到 3 条历史记录"卡片）

### 2.4 审计存储实现

- [ ] 修改 `lib/database/ai_database.dart` (Drift)
  - [ ] 创建 `ai_audit_logs` 表
    - [ ] `id` TEXT PRIMARY KEY
    - [ ] `timestamp` INTEGER
    - [ ] `type` TEXT
    - [ ] `source_module` TEXT
    - [ ] `payload` TEXT (JSON)
  - [ ] 创建 `AiAuditLogsDao`
    - [ ] `insertLog(AiAuditLog log)`
    - [ ] `queryLogs({String? sourceModule, DateTime? after})`
- [ ] 创建 `lib/services/ai_audit_service_impl.dart`
  - [ ] 实现 `AiAuditService`
  - [ ] 在 `AgentRunner` 中的关键节点调用审计日志：
    - [ ] `toolCall` — 记录工具调用请求
    - [ ] `toolResult` — 记录工具执行结果
    - [ ] `chat` — 记录用户/AI 消息（可选）

### 2.5 依赖注入

- [ ] 修改 `example/lib/main.dart` 或 App 入口
  - [ ] 注册 `AiService` -> `AiServiceImpl`
  - [ ] 注册 `AiAuditService` -> `AiAuditServiceImpl`

### 2.6 单元测试 (xuan-ai)

- [ ] 测试 `AiServiceImpl` 的 Action/Tool 注册逻辑
- [ ] 测试 `AgentRunner` 的 Function Call 解析与分发
- [ ] 测试 `AiAuditLogsDao` 的插入与查询

---

## 第三阶段：模块集成 (`xuan-qimendunjia` 等)

### 3.1 Link A 集成 (AiAction)

- [ ] 在奇门模块创建 `lib/ai/actions/analyze_qimen_action.dart`
  - [ ] 实现 `AiAction`
  - [ ] `isApplicable`: 检查 context 中是否含有 `qimen_pan` 类型实体
  - [ ] `execute`: 构建 `AiContext` -> 调用 `AiService.openChat`
- [ ] 在奇门结果页添加"AI 分析"按钮
  - [ ] 绑定 `_onAskAiPressed` 方法
  - [ ] 构建 `AiEntity` (从 `QimenJu` 转换)
- [ ] 在模块初始化时注册 Action
  - [ ] `AiService.registerAction(AnalyzeQimenAction())`

### 3.2 Link B 集成 (AgentTool)

- [ ] 在奇门模块创建 `lib/ai/tools/search_history_tool.dart`
  - [ ] 实现 `AgentTool`
  - [ ] `name`: `search_qimen_history`
  - [ ] `parametersSchema`: `keywords`, `pattern_feature`, `start_date`
  - [ ] `execute`: 调用 `QimenRepository.search(...)`
- [ ] 在奇门模块创建 `lib/ai/tools/recalc_qimen_tool.dart`（可选）
  - [ ] 实现 `AgentTool`
  - [ ] `name`: `recalculate_qimen`
  - [ ] `execute`: 调用排盘引擎
- [ ] 在模块初始化时注册 Tool
  - [ ] `AiService.registerTool(SearchQimenHistoryTool())`
  - [ ] `AiService.registerTool(RecalcQimenTool())`

### 3.3 集成测试

- [ ] 验证"奇门结果页 -> 点击 AI 分析 -> Chat 窗口打开并带上下文"
- [ ] 验证"在 Chat 中询问历史记录 -> LLM 调用 search_qimen_history -> 返回结果"

---

## 第四阶段：GUI 控制集成

### 4.1 窗口管理器接口

- [ ] 创建 `lib/services/window_manager_service.dart` (xuan-common 或 app 层)
  - [ ] `void openWindow(String moduleId, Map<String, dynamic> params)`
  - [ ] `void minimizeWindow(String windowId)`
  - [ ] `void closeWindow(String windowId)`
  - [ ] `List<WindowInfo> getOpenWindows()`

### 4.2 GUI AgentTool 实现

- [ ] 创建 `OpenWindowTool extends AgentTool`
  - [ ] `name`: `open_window`
  - [ ] `execute`: 调用 `WindowManager.openWindow`
- [ ] 创建 `MinimizeWindowTool extends AgentTool`
  - [ ] `name`: `minimize_window`
  - [ ] `execute`: 调用 `WindowManager.minimizeWindow`
- [ ] 创建 `CloseWindowTool extends AgentTool`
  - [ ] `name`: `close_window`
  - [ ] `execute`: 调用 `WindowManager.closeWindow`

### 4.3 注册与验证

- [ ] 在 App 初始化时注册所有 GUI Tool
- [ ] 验证"对 AI 说'关闭当前窗口' -> LLM 调用 close_window -> 窗口关闭"

---

## 第五阶段：审计与安全验证

- [ ] 验证所有 `toolCall` 和 `toolResult` 都被正确记录
- [ ] 验证敏感数据脱敏逻辑
- [ ] 编写审计日志查询界面（可选，后续阶段）
- [ ] 编写审计数据导出功能（可选，后续阶段）

---

## 里程碑

| 里程碑 | 依赖 | 预计 |
|---|---|---|
| M1: `xuan-common` 接口定义完成 | 无 | Phase 1 |
| M2: `xuan-ai` 服务实现 & Agent Runner | M1 | Phase 2 |
| M3: 奇门模块首个集成 Demo | M2 | Phase 3 |
| M4: GUI 控制 | M2 | Phase 4 |
| M5: 审计系统上线 | M2 | Phase 5 |
