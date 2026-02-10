# AI 交互实施计划 (v1.0)

本计划概述了实施 `PRDs_zh.md` 中描述的 AI 交互系统的步骤。

## 第一阶段：核心框架 (`xuan-common`)

### 1.1 定义通信接口

* **创建 `lib/domain/ai/ai_context.dart`**:
  * 定义 `AiEntity` 和 `AiContext` 模型。
* **创建 `lib/domain/ai/ai_action.dart`**:
  * 定义 `abstract class AiAction` (Link A)。
* **创建 `lib/domain/ai/agent_tool.dart`**:
  * 定义 `abstract class AgentTool` (Link B)。
  * *注意*: 命名从 `AiTool` 更改为 `AgentTool`，以明确区分“模块能力提供者”的角色。

### 1.2 定义服务接口

* **创建 `lib/services/ai_service.dart`**:
  * `registerAction(AiAction action)`
  * `registerTool(AgentTool tool)`
  * `openChat({BuildContext context, AiContext? initialContext})`
  * `showConfigSheet({BuildContext context})`
  * `get activeConfig` (Stream)

### 1.3 审计系统基础

* **创建 `lib/services/ai_audit_service.dart`**:
  * `logInteraction(...)` 接口。
  * 基础 `AiAuditLog` 数据模型。

## 第二阶段：AI 服务实现 (`xuan-ai`)

### 2.1 实现服务

* **创建 `lib/services/ai_service_impl.dart`**:
  * 实现 `AiService`。
  * 维护已注册 `AiAction` 和 `AgentTool` 的列表。
  * 集成 `AiAuditService`。

### 2.2 实现 Agent 逻辑

* **增强 `AiChatView` / `AgentRunner`**:
  * 从可用 `AgentTool` 描述构建“系统提示词 (System Prompt)”的逻辑。
  * 解析 LLM 函数调用并分发给正确 `AgentTool` 的逻辑。
  * 将执行结果（或错误）显示回用户的逻辑。

### 2.3 实现审计存储

* **数据库 (Drift)**:
  * 创建 `AiAuditLogs` 表。
  * 实现插入日志的 DAO 方法。

## 第三阶段：模块集成 (`xuan-qimendunjia` 等)

### 3.1 实现 Link A (Actions)

* **创建 `lib/ai/actions/analyze_qimen_action.dart`**:
  * 实现 `AiAction`。
  * UI: 在“奇门结果页”添加一个按钮。

### 3.2 实现 Link B (Tools)

* **创建 `lib/ai/tools/recalc_qimen_tool.dart`**:
  * 实现 `AgentTool`。
  * 逻辑: 调用内部奇门计算引擎。
* **创建 `lib/ai/tools/search_history_tool.dart`**:
  * 实现 `AgentTool`。
  * 逻辑: 查询奇门数据库。

### 3.3 注册

* **更新模块设置**:
  * 在模块初始化代码中，调用 `AiService.registerAction(...)` 和 `AiService.registerTool(...)`。

## 第四阶段：GUI 控制集成

### 4.1 定义窗口管理器

* **创建 `lib/services/window_manager_service.dart`** (common 或 app 中的接口)。
* **实现 `WindowManager`** (在主 App 中)。

### 4.2 注册 GUI 工具

* **在 `app/main.dart` (或 setup)**:
  * 注册 `OpenWindowTool`, `MinimizeWindowTool`, `CloseWindowTool`。
  * 这些工具委托给 `WindowManager`。

## 第五阶段：验证与测试

* **单元测试**:
  * 测试 `AiContext` 序列化。
  * 测试 `AiAction` 发现的匹配逻辑。
  * 测试 `AgentTool` 执行流程。
* **集成测试**:
  * 端到端验证“一键总结”场景。
  * 端到端验证“跨模块调用”场景。
  * 端到端验证“GUI 控制”场景。
