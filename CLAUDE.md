# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`ai_core` is a Flutter package providing AI/LLM capabilities for the xuan divination (玄学占测) application. It lives in the `xuan-migration` mono-repo alongside sibling packages (`xuan-common`, `xuan-account`, `xuan-qimendunjia`, etc.). The shared `common` package is referenced as `path: ../xuan-common`.

## Build Commands

```bash
# Install dependencies (must also have ../xuan-common available)
flutter pub get

# Code generation (Drift ORM + JSON serialization)
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch   # watch mode for development

# Static analysis
flutter analyze

# Run all tests
flutter test

# Run a single test file
flutter test test/path_to_test.dart
```

## Code Generation

This project uses `build_runner` with two generators:
- **drift_dev** — generates `*.g.dart` for database classes (tables, DAOs, database)
- **json_serializable** — generates `*.g.dart` for JSON model serialization

After modifying any file with `part '*.g.dart'`, `@DriftDatabase`, `@DriftAccessor`, `@JsonSerializable`, or table definitions, re-run `build_runner build`.

**build.yaml options:**
- `explicit_to_json: true` for json_serializable
- `store_date_time_values_as_text: true` for Drift
- `apply_converters_on_variables: true` for Drift

## Architecture

```
Widgets (AiChatWindow, ChatInputBar, ChatMessageBubble, PersonaSelector)
    ↓
ViewModel (AiChatViewModel — ChangeNotifier via Provider)
    ↓
Services
├── ChatService          — main orchestrator: session mgmt, message flow, tool call handling
├── ChatPersistenceService — DB operations for sessions/messages, Drift stream watchers
├── LlmService           — manages LLM client instances, records API calls & usage audits
├── PromptService         — template CRUD, versioning with SHA-256, {{variable}} substitution
├── ToolRegistry          — registers tools & skill interfaces, executes function calls
├── ToolExecutor          — middleware pipeline (logging, validation, rate limiting)
├── ProvenanceService     — immutable SHA-256 audit chain for all AI operations
└── AgentOrchestrator     — multi-agent collaboration with depth limits
    ↓
Database (Drift ORM)
├── AiDatabase           — 14 tables, 14 DAOs, schema v2
├── Tables: providers, models, prompts, versions, skill bindings,
│   personas, sessions, messages, api_calls, provenance, divinations,
│   agent_invocations, usage_audits, tools
└── Migration: drop-and-recreate strategy, auto-seeds defaults on first run
```

### Request Flow

1. User sends message via `AiChatViewModel.sendMessage()`
2. `ChatService` persists user message, gathers conversation history + tool definitions
3. `LlmService` streams response via `OpenAICompatibleClient` (Dio HTTP + SSE parsing)
4. If response contains tool calls: execute via `ToolRegistry`, feed results back to LLM
5. `ChatPersistenceService` updates messages in DB; Drift watchers notify ViewModel
6. ViewModel's `ChangeNotifier` triggers UI rebuild

### Tool/Function Calling System

- `DivinationSkillInterface` (abstract) defines the contract for skill modules to register tools
- Each skill provides `ToolDefinition` list + execution handlers
- `ToolRegistry.registerSkillInterface()` auto-registers all tools from a skill
- `ToolExecutor` wraps execution with composable middleware (logging, validation, rate limiting, confirmation)

### Provenance System

Every AI operation (API call, tool invocation, agent call, message) is recorded as an immutable provenance entry with SHA-256 integrity hash. Records are chained via `previousProvenanceUuid` forming a verifiable audit trail.

## Key Conventions

- **UUIDs as primary keys** across all tables (v5 deterministic UUIDs for seeded data)
- **Immutable tables**: `prompt_versions`, `ai_provenance`, `ai_usage_audits` — append-only, never update
- **Soft deletes** via `deletedAt` timestamps on mutable tables
- **`@ReferenceName()` annotation** required when a Drift table has multiple foreign keys to the same target table
- **`json_annotation`** is a runtime dependency; **`json_serializable`** and **`drift_dev`** are dev-only (never import in runtime code)
- **`Duration` fields** are not JSON-serializable — use `@JsonKey(includeFromJson: false, includeToJson: false)`

## Lint Rules

Uses `package:flutter_lints/flutter.yaml` with additional rules:
- `prefer_single_quotes`
- `prefer_const_constructors` / `prefer_const_declarations`
- `prefer_final_locals`
- `avoid_print` (use `logger` package instead)

## Example App

The `example/` directory contains a full demo app with service locator DI setup, screens for chat, personas, prompts, provider settings, and demonstrates how to wire up all services.
