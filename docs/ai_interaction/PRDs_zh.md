# AI 交互系统产品需求文档 (v1.0)

本文档正式确立了 Xuan 应用生态系统中 AI 集成的需求和规范。它响应了用户关于清晰分离“子模块访问 AI (Link A)”与“AI 访问子模块 (Link B)”的请求，并包含了审计功能的规范。

## 1. 执行摘要

本项目旨在将 AI 能力 (`xuan-ai`) 与领域特定模块（如 `xuan-qimendunjia`）集成，同时保持低耦合。该系统使用户能够执行 AI 辅助分析、摘要和复杂排盘，同时也允许 AI 安全地利用模块特定的数据和工具。

## 2. 核心概念与术语

### 2.1 通信通道

目前，通信在两个方向上流动，必须明确区分：

* **Link A (模块 -> AI)**: 子模块向 AI 请求服务。
  * **动作 (Action)**: `AiAction` (例如：“分析”、“总结”)。
  * **发起者**: 用户 / 子模块 UI。
  * **执行者**: AI 服务。
* **Link B (AI -> 模块)**: AI 向子模块请求能力。
  * **能力 (Capability)**: `AgentTool` (例如：“重新排盘”、“搜索历史”)。
  * **发起者**: AI Agent / LLM (基于上下文)。
  * **执行者**: 子模块逻辑。

### 2.2 共享模型 (`xuan-common`)

* `AiEntity`: 代表一个业务对象（如奇门局），包含结构化数据和自然语言描述。
* `AiContext`: `AiEntity` 对象和用户意图的容器。

## 3. 详细规格

### 3.1 Link A: 模块访问 AI (`AiAction`)

这允许子模块使用自定义按钮或命令扩展 AI 聊天界面。

* **接口**: `abstract class AiAction`
  * `id`: 唯一标识符 (例如: `qimen_summarize`)。
  * `label`: 显示文本。
  * `icon`: 显示图标。
  * `execute(context)`: 处理逻辑。
* **注册**: `AiService.registerAction(AiAction action)`
* **UI 集成**: 聊天窗口根据当前上下文动态渲染适用的动作。

### 3.2 Link B: AI 访问模块 (`AgentTool`)

这允许 AI “回调”应用以执行任务或查询数据。我们严格将其与 `AiAction` 区分开。

* **接口**: `abstract class AgentTool`
  * `name`: 供 LLM 使用的函数名 (例如: `search_qimen_history`)。
  * `description`: 供 LLM 阅读的描述。
  * `parametersSchema`: 参数的 JSON Schema。
  * `execute(args)`: 返回 Map 或 JSON 字符串。
* **注册**: `AiService.registerTool(AgentTool tool)`
  * *注意*: 注册表由 `AiService` (作为 Agent 运行器) 管理，但工具由模块提供。
* **发现**: AI Agent (如 `xuan-ai`) 在对话期间自动向 LLM 暴露已注册的工具。

### 3.3 GUI 控制 (`AgentTool` 实现)

为了允许 AI 操作 UI，应用层需注册特定的 `AgentTool`。

* **工具**:
  * `open_window(module_id, params)`
  * `minimize_window(window_id)`
  * `close_window(window_id)`
* **后端**: 由主 App 或 `xuan-common` 实现的 `WindowManager` 或 `Router` 处理实际的 UI 变更。

### 3.4 审计与安全 (`AiAudit`)

模块与 AI 之间的所有交互必须被记录，用于审计和调试。

* **范围**:
  * 用户提示词 (Prompts) & 上下文。
  * AI 响应。
  * **工具执行 (Link B)**: 安全的关键。我们必须记录 *调用了什么工具*，使用了 *什么参数*，以及 *何时* 调用的。
* **存储**: 本地 SQLite 表 `ai_audit_logs`。
* **Schema**:
  * `id`: UUID。
  * `timestamp`: DateTime。
  * `type`: 枚举 (`chat`, `action_call`, `tool_call`, `tool_result`)。
  * `source_module`: 字符串 (例如: `xuan-qimen`)。
  * `payload`: JSON (已清洗)。
* **隐私**: `payload` 中的敏感数据必要时应进行脱敏处理。

## 4. 架构图 (概念)

```mermaid
graph TD
    User([用户]) -->|点击按钮| ModuleUI[模块 UI (奇门)]
    ModuleUI -->|执行 AiAction| AiService[AiService (xuan-ai)]
    
    subgraph Link A
    AiService -->|打开聊天| ChatWindow[聊天窗口]
    end
    
    ChatWindow -->|用户消息| LLM[LLM / Agent]
    
    subgraph Link B
    LLM -->|函数调用| AgentRunner[Agent 运行器]
    AgentRunner -->|执行| AgentTool[AgentTool (由奇门提供)]
    AgentTool -->|查询/计算| ModuleLogic[模块逻辑]
    end
    
    AgentRunner -->|日志| AuditSystem[AiAudit 系统]
```

## 5. 非功能性需求

* **性能**: 工具执行应尽可能非阻塞。
* **安全**: `AgentTool` 必须严格验证其输入参数。
* **隐私**: 历史数据查询必须尊重用户的本地隐私设置。
* **可扩展性**: 添加新模块不应要求修改 `xuan-ai` 代码。
