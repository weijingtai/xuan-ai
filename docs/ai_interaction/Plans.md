# AI Interaction Implementation Plan (v1.0)

This plan outlines the steps to implement the AI Interaction System described in `PRDs.md`.

## Phase 1: Core Framework (`xuan-common`)

### 1.1 Define Communication Interfaces

* **Create `lib/domain/ai/ai_context.dart`**:
  * Defines `AiEntity` and `AiContext` models.
* **Create `lib/domain/ai/ai_action.dart`**:
  * Defines `abstract class AiAction` (Link A).
* **Create `lib/domain/ai/agent_tool.dart`**:
  * Defines `abstract class AgentTool` (Link B).
  * *Note*: Naming changed from `AiTool` to `AgentTool` to clearly distinguish the "Module Capability Provider" role.

### 1.2 Define Service Interface

* **Create `lib/services/ai_service.dart`**:
  * `registerAction(AiAction action)`
  * `registerTool(AgentTool tool)`
  * `openChat({BuildContext context, AiContext? initialContext})`
  * `showConfigSheet({BuildContext context})`
  * `get activeConfig` (Stream)

### 1.3 Audit System Foundation

* **Create `lib/services/ai_audit_service.dart`**:
  * `logInteraction(...)` interface.
  * Basic `AiAuditLog` data model.

## Phase 2: AI Service Implementation (`xuan-ai`)

### 2.1 Implement the Service

* **Create `lib/services/ai_service_impl.dart`**:
  * Implements `AiService`.
  * Maintains lists of registered `AiAction`s and `AgentTool`s.
  * Integrates with `AiAuditService`.

### 2.2 Implement Agent Logic

* **Enhance `AiChatView` / `AgentRunner`**:
  * Logic to construct the "System Prompt" from available `AgentTool` descriptions.
  * Logic to parse LLM function calls and dispatch to the correct `AgentTool`.
  * Logic to display the execution result (or error) back to the user.

### 2.3 Implement Audit Storage

* **Database (Drift)**:
  * Create `AiAuditLogs` table.
  * Implement DAO method to insert logs.

## Phase 3: Module Integration (`xuan-qimendunjia` & others)

### 3.1 Implement Link A (Actions)

* **Create `lib/ai/actions/analyze_qimen_action.dart`**:
  * Implements `AiAction`.
  * UI: Adds a button to the "Qimen Result Page".

### 3.2 Implement Link B (Tools)

* **Create `lib/ai/tools/recalc_qimen_tool.dart`**:
  * Implements `AgentTool`.
  * Logic: Calls internal Qimen calculation engine.
* **Create `lib/ai/tools/search_history_tool.dart`**:
  * Implements `AgentTool`.
  * Logic: Queries Qimen database.

### 3.3 Registration

* **Update Module Setup**:
  * In the module's initialization code, call `AiService.registerAction(...)` and `AiService.registerTool(...)`.

## Phase 4: GUI Control Integration

### 4.1 Define Window Manager

* **Create `lib/services/window_manager_service.dart`** (interface in `common` or `app`).
* **Implement `WindowManager`** in the main App.

### 4.2 Register GUI Tools

* **In `app/main.dart` (or setup)**:
  * Register `OpenWindowTool`, `MinimizeWindowTool`, `CloseWindowTool`.
  * These tools delegate to `WindowManager`.

## Phase 5: Verification & Testing

* **Unit Tests**:
  * Test serialization of `AiContext`.
  * Test matching logic for `AiAction` discovery.
  * Test `AgentTool` execution flow.
* **Integration Tests**:
  * Verify "Summarize" scenario end-to-end.
  * Verify "Cross-Module Call" scenario end-to-end.
  * Verify "GUI Control" scenario end-to-end.
