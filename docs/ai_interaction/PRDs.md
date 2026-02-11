# AI Interaction System PRD (v1.0)

This document formalizes the requirements and specifications for the AI integration system within the Xuan application ecosystem. It addresses the user's request for a clear separation between sub-modules accessing AI (Link A) and AI accessing sub-modules (Link B), as well as auditing capabilities.

## 1. Executive Summary

This project aims to integrate AI capabilities (`xuan-ai`) with domain-specific modules (like `xuan-qimendunjia`) while maintaining low coupling. The system enables users to perform AI-assisted analysis, summaries, and complex divinations, while also allowing the AI to leverage module-specific data and tools securely.

## 2. Core Concepts & Terminology

### 2.1 Communication Channels

Currently, communication flows in two directions, which must be clearly distinguished:

* **Link A (Module -> AI)**: Sub-modules request services from the AI.
  * **Action**: `AiAction` (e.g., "Analyze", "Summarize").
  * **Initiator**: User / Sub-module UI.
  * **Executor**: AI Service.
* **Link B (AI -> Module)**: AI requests capabilities from sub-modules.
  * **Capability**: `AgentTool` (e.g., "Recalculate", "Search History").
  * **Initiator**: AI Agent / LLM based on context.
  * **Executor**: Sub-module Logic.

### 2.2 Shared Models (`xuan-common`)

* `AiEntity`: Represents a domain object (e.g., a Qimen chart) with structured data and natural language description.
* `AiContext`: A container for `AiEntity` objects and user intentions.
  * `moduleName` (String, Required): The identifier of the calling module (e.g., `xuan-qimendunjia`). Used for auditing and routing.
  * `intention` (String): User's goal or question.
  * `entities` (List<AiEntity>): Structured data relevant to the context.
  * `systemPromptOverride` (String?): Optional override for system instructions.

## 3. Detailed Specifications

### 3.1 Link A: Module Accessing AI (`AiAction`)

This allows sub-modules to extend the AI Chat interface with custom buttons or commands.

* **Interface**: `abstract class AiAction`
  * `id`: Unique identifier (e.g., `qimen_summarize`).
  * `label`: Display text.
  * `icon`: Display icon.
  * `execute(context)`: Handler logic.
* **Registry**: `AiService.registerAction(AiAction action)`
* **UI Integration**: The Chat Window dynamically renders applicable actions based on the current context.

### 3.2 Link A+: Advanced Interactions (`Persona` & `ChatView`)

Beyond simple actions, sub-modules can request more complex AI interactions:

* **Persona Selection**: `AiService.showPersonaSelector(context, requiredSkills)`
  * Allows users to select a specific AI Persona (e.g., "Grandmaster of Qimen") suitable for the current task.
  * Supports filtering personalities by required skills (e.g., only show personas that know Qimen Dunjia).
  * **Add Persona**: Users can create new personas directly from this interface.
* **Embedded Chat**: `AiService.buildChatView(context, initialContext)`
  * Allows embedding the AI Chat interface directly into a module's UI (e.g., a side panel or drawer) instead of a full-screen modal.

### 3.2 Link B: AI Accessing Modules (`AgentTool`)

This allows the AI to "reach back" into the application to perform tasks or query data. We strictly separate this from `AiAction`.

* **Interface**: `abstract class AgentTool`
  * `name`: Function name for LLM (e.g., `search_qimen_history`).
  * `description`: Description for LLM.
  * `parametersSchema`: JSON Schema for arguments.
  * `execute(args)`: Returns a Map or JSON string.
* **Registry**: `AiService.registerTool(AgentTool tool)`
  * *Note*: The registry is managed by `AiService` (as the Agent runner), but the tools are provided by modules.
* **Discovery**: The AI Agent (e.g., `xuan-ai`) automatically exposes registered tools to the LLM during conversation.

### 3.3 GUI Control (`AgentTool` Implementation)

To allow AI to manipulate the UI, the App layer registers specific `AgentTool`s.

* **Tools**:
  * `open_window(module_id, params)`
  * `minimize_window(window_id)`
  * `close_window(window_id)`
* **Backend**: A `WindowManager` or `Router` implemented in the main App or `xuan-common` handles the actual UI changes.

### 3.4 Auditing & Security (`AiAudit`)

All interactions between modules and AI must be logged for auditing and debugging.

* **Scope**:
  * User Prompts & Context.
  * AI Responses.
  * **Tool Executions (Link B)**: Key for security. We must log *what* tool was called, with *what* arguments, and *when*.
* **Storage**: A local SQLite table `ai_audit_logs`.
* **Schema**:
  * `id`: UUID.
  * `timestamp`: DateTime.
  * `type`: Enum (`chat`, `action_call`, `tool_call`, `tool_result`).
  * `source_module`: String (e.g., `xuan-qimen`).
  * `payload`: JSON (sanitized).
* **Privacy**: Sensitive data in `payload` should be masked if necessary.

## 4. Architecture Diagram (Conceptual)

```mermaid
graph TD
    User([User]) -->|Click Button| ModuleUI[Module UI (Qimen)]
    ModuleUI -->|Execute AiAction| AiService[AiService (xuan-ai)]
    
    subgraph Link A
    AiService -->|Open Chat| ChatWindow[Chat Window]
    end
    
    ChatWindow -->|User Msg| LLM[LLM / Agent]
    
    subgraph Link B
    LLM -->|Function Call| AgentRunner[Agent Runner]
    AgentRunner -->|Execute| AgentTool[AgentTool (Provided by Qimen)]
    AgentTool -->|Query/Calc| ModuleLogic[Module Logic]
    end
    
    AgentRunner -->|Log| AuditSystem[AiAudit System]
```

## 5. Non-Functional Requirements

* **Performance**: Tool execution must be non-blocking where possible.
* **Security**: `AgentTool`s should validate their input arguments rigorously.
* **Privacy**: History data queries must respect user's local privacy settings.
* **Extensibility**: Adding a new module should not require changing `xuan-ai` code.
