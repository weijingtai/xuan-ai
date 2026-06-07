import 'dart:async';

import 'package:ai_core/ai/agent_tool.dart';
import 'package:ai_core/ai/ai_audit_log.dart';
import 'package:ai_core/ai/ai_action.dart';
import 'package:ai_core/ai/ai_chat_event.dart';
import 'package:ai_core/ai/ai_config_summary.dart';
import 'package:ai_core/ai/ai_context.dart';
import 'package:ai_core/ai/resolved_persona.dart';
import 'package:ai_core/ai/session_summary.dart';
import 'package:ai_core/ai_core.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../widgets/ai_chat_view.dart';
import '../widgets/persona_selection_sheet.dart';
import 'ai_audit_service_impl.dart';
import 'llm/llm_service.dart';
import 'agent/agent_runner.dart';
import 'package:persistence_drift/ai/ai_database.dart';
import 'package:ai_core/ai/ai_persona.dart'
    as common; // Domain model alias
import 'chat/session_manager.dart';
import 'tool/tool_registry.dart';
import '../models/tool_definition.dart';

class AiServiceImpl implements AiService {
  final _logger = Logger('AiServiceImpl');

  // Maintain registries
  final List<AiAction> _actions = [];
  final List<AgentTool> _tools = [];

  // Active configuration stream (mock for now)
  final _configController = StreamController<AiConfigSummary>.broadcast();

  // Chat event broadcast stream (Phase 1)
  final _chatEventController = StreamController<AiChatEvent>.broadcast();

  // Tool Registry for DeepSeekProvider tool calling
  final ToolRegistry _toolRegistry;

  // Services
  final AiAuditService _auditService;
  final LlmService _llmService;
  final AiDatabase _db;
  late final SessionManager _sessionManager;

  AiServiceImpl({
    AiAuditService? auditService,
    required LlmService llmService,
    required AiDatabase db,
    ToolRegistry? toolRegistry,
  }) : _auditService = auditService ?? AiAuditServiceImpl(),
       _llmService = llmService,
       _db = db,
       _toolRegistry = toolRegistry ?? ToolRegistry() {
    _sessionManager = SessionManager(db: _db);
  }

  @override
  Stream<AiConfigSummary> get activeConfig => _configController.stream;

  @override
  Stream<AiChatEvent> get chatEvents => _chatEventController.stream;

  /// Emit a chat event to all subscribers.
  void emitChatEvent(AiChatEvent event) {
    if (event is ToolResultEvent) {
      _logger.info('[emitChatEvent] ToolResultEvent: '
          'tool="${event.toolName}", session=${event.sessionUuid}, '
          'hasError=${event.resultData.containsKey("error")}');
      debugPrint('📢 [AiServiceImpl] emitChatEvent: ToolResultEvent tool="${event.toolName}", '
          'listeners=${_chatEventController.hasListener}');
    } else {
      _logger.info('[emitChatEvent] ${event.runtimeType}: session=${event.sessionUuid}');
    }
    _chatEventController.add(event);
  }

  /// Access the tool registry (for registering tools from external modules).
  ToolRegistry get toolRegistry => _toolRegistry;

  /// Access the session manager (for session CRUD within AiChatView).
  SessionManager get sessionManager => _sessionManager;

  // ============================================================
  // 扩展注册
  // ============================================================

  @override
  void registerAction(AiAction action) {
    if (_actions.any((a) => a.id == action.id)) {
      _logger.warning('Overwriting existing action: ${action.id}');
      _actions.removeWhere((a) => a.id == action.id);
    }
    _actions.add(action);
    _logger.info('Registered Action: ${action.label} (${action.id})');
  }

  @override
  List<AiAction> getAvailableActions(AiContext context) {
    final uniqueActions = <String, AiAction>{};
    for (final a in AiRegistry.actions) {
      uniqueActions[a.id] = a;
    }
    for (final a in _actions) {
      uniqueActions[a.id] = a;
    }
    return uniqueActions.values.where((a) => a.isApplicable(context)).toList();
  }

  @override
  void registerTool(AgentTool tool) {
    if (_tools.any((t) => t.name == tool.name)) {
      _logger.warning('Overwriting existing tool: ${tool.name}');
      _tools.removeWhere((t) => t.name == tool.name);
    }
    _tools.add(tool);
    _logger.info('Registered Tool: ${tool.name} (description: ${tool.description})');

    // Also register in ToolRegistry for DeepSeekProvider tool calling
    _logger.fine('Registering "${tool.name}" in ToolRegistry for provider tool calling');
    _toolRegistry.registerTool(
      name: tool.name,
      definition: _agentToolToDefinition(tool),
      handler: (args) => tool.execute(args),
    );
  }

  @override
  List<AgentTool> getAvailableTools() {
    final uniqueTools = <String, AgentTool>{};
    for (final t in AiRegistry.tools) {
      uniqueTools[t.name] = t;
    }
    for (final t in _tools) {
      uniqueTools[t.name] = t;
    }
    return List.unmodifiable(uniqueTools.values);
  }

  // ============================================================
  // Persona 解析
  // ============================================================

  @override
  Future<ResolvedPersona?> resolvePersona(String personaUuid) async {
    final dbPersona = await _db.aiPersonasDao.getByUuid(personaUuid);
    if (dbPersona == null) {
      _logger.warning('Persona not found: $personaUuid');
      return null;
    }

    // 1. Resolve System Prompt
    String? systemInstruction;
    if (dbPersona.systemPromptUuid != null) {
      final template = await _db.promptTemplatesDao.getByUuid(
        dbPersona.systemPromptUuid!,
      );
      systemInstruction = template?.content;
    }

    // 2. Resolve Model + Provider
    LlmModel? model;
    LlmProvider? provider;

    if (dbPersona.modelUuid.isNotEmpty) {
      model = await _db.llmModelsDao.getByUuid(dbPersona.modelUuid);
    }
    model ??= await _db.llmModelsDao.getDefault();

    if (model != null) {
      provider = await _db.llmProvidersDao.getByUuid(model.providerUuid);
    }
    provider ??= await _db.llmProvidersDao.getDefault();

    if (provider == null) {
      _logger.severe('No LLM provider available for persona: $personaUuid');
      return null;
    }

    return ResolvedPersona(
      uuid: dbPersona.uuid,
      name: dbPersona.name,
      description: dbPersona.description,
      avatarUrl: dbPersona.avatarUrl,
      providerName: provider.name,
      apiKey: provider.encryptedApiKey ?? '',
      baseUrl: provider.baseUrl,
      modelId: model?.modelId ?? 'deepseek-chat',
      temperature: dbPersona.temperature,
      topP: dbPersona.topP,
      maxTokens: dbPersona.maxTokens,
      systemInstruction: systemInstruction,
    );
  }

  // ============================================================
  // Session 管理
  // ============================================================

  @override
  Future<String> createSession({
    required BuildContext context,
    required ResolvedPersona persona,
    AiContext? initialContext,
  }) async {
    _logger.info('Creating session for persona: ${persona.name}');

    final result = await _sessionManager.createSession(
      persona: persona,
      initialContext: initialContext,
    );
    final sessionUuid = result.sessionUuid;

    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => AiChatView(
            persona: persona,
            sessionUuid: sessionUuid,
            db: _db,
            aiService: this,
            toolRegistry: _toolRegistry,
            history: result.initialMessages,
            onSessionEnd: (history) {
              _sessionManager.saveHistory(
                sessionUuid: sessionUuid,
                history: history,
              );
            },
          ),
        ),
      );
    }

    return sessionUuid;
  }

  @override
  Future<void> resumeChat({
    required BuildContext context,
    required String sessionUuid,
  }) async {
    _logger.info('Resuming session: $sessionUuid');

    final result = await _sessionManager.resumeSession(sessionUuid);
    if (result == null) {
      _logger.warning('Cannot resume: session not found');
      return;
    }

    final persona = await resolvePersona(result.session.personaUuid);
    if (persona == null) {
      _logger.warning('Cannot resume: persona not found');
      return;
    }

    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => AiChatView(
            persona: persona,
            sessionUuid: sessionUuid,
            db: _db,
            aiService: this,
            toolRegistry: _toolRegistry,
            history: result.messages,
            onSessionEnd: (history) {
              _sessionManager.saveHistory(
                sessionUuid: sessionUuid,
                history: history,
              );
            },
          ),
        ),
      );
    }
  }

  @override
  Future<List<SessionSummary>> listSessions({
    String? personaUuid,
    String? status,
  }) async {
    return _sessionManager.listSessions(
      personaUuid: personaUuid,
      status: status,
    );
  }

  @override
  Future<void> updateSessionPersona({
    required String sessionUuid,
    required String personaUuid,
  }) async {
    await _sessionManager.updateSessionPersona(sessionUuid, personaUuid);
  }

  @override
  Future<void> archiveSession(String sessionUuid) async {
    await _sessionManager.archiveSession(sessionUuid);
  }

  @override
  Future<void> deleteSession(String sessionUuid) async {
    await _sessionManager.deleteSession(sessionUuid);
  }

  // ============================================================
  // 聊天 & 分析 (legacy + new)
  // ============================================================

  @override
  Future<void> openChat({
    required BuildContext context,
    AiContext? initialContext,
  }) async {
    _logger.info('Opening AI Chat with context: ${initialContext?.intention}');

    await _auditService.logInteraction(
      AiAuditLog(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
        type: AiAuditLogType.chat,
        sourceModule: 'ai_service',
        payload: {
          'action': 'open_chat',
          'intention': initialContext?.intention,
        },
      ),
    );

    final defaultPersona = await _db.aiPersonasDao.getDefault();
    if (defaultPersona == null) {
      _logger.warning('No default persona configured');
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('未配置默认 AI 人设，请先设置。')));
      }
      return;
    }

    final persona = await resolvePersona(defaultPersona.uuid);
    if (persona == null) {
      _logger.warning('Failed to resolve default persona');
      return;
    }

    if (!context.mounted) return;

    await createSession(
      context: context,
      persona: persona,
      initialContext: initialContext,
    );
  }

  @override
  Widget buildChatView(
    BuildContext context, {
    AiContext? initialContext,
    common.AiPersona? persona,
  }) {
    return _AsyncChatViewBuilder(
      aiService: this,
      initialContext: initialContext,
      personaUuid: persona?.uuid,
    );
  }

  @override
  Future<common.AiPersona?> showPersonaSelector({
    required BuildContext context,
    List<int>? requiredSkills,
  }) async {
    final dbPersonas = await _db.aiPersonasDao.getAllEnabled();

    if (!context.mounted) return null;

    final selectedDbPersona = await showModalBottomSheet<AiPersona>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) => PersonaSelectionSheet(
        initialPersonas: dbPersonas,
        selectedUuid: null,
        aiDatabase: _db,
        onDelete: (persona) async {
          await _db.aiPersonasDao.softDelete(persona.uuid);
        },
        onRefresh: () => _db.aiPersonasDao.getAllEnabled(),
      ),
    );

    if (selectedDbPersona != null) {
      String? instruction;
      if (selectedDbPersona.systemPromptUuid != null) {
        final template = await _db.promptTemplatesDao.getByUuid(
          selectedDbPersona.systemPromptUuid!,
        );
        instruction = template?.content;
      }

      return common.AiPersona(
        uuid: selectedDbPersona.uuid,
        name: selectedDbPersona.name,
        description: selectedDbPersona.description,
        instruction: instruction,
      );
    }
    return null;
  }

  @override
  Future<String> analyze({required AiContext context}) async {
    _logger.info('Analyzing with context: ${context.intention}');

    try {
      final defaultModel = await _llmService.getDefaultModel();
      if (defaultModel == null) {
        throw Exception('No default LLM model configured');
      }

      final runner = AgentRunner(
        llmService: _llmService,
        auditService: _auditService,
      );

      final result = await runner.run(
        context: context,
        tools: _tools,
        modelUuid: defaultModel.uuid,
      );

      return result;
    } catch (e) {
      _logger.severe('Analysis failed', e);
      return 'Analysis failed: $e';
    }
  }

  @override
  Future<String?> getSummary({required String entityId}) async {
    return null;
  }

  @override
  Stream<String?> watchSummary({required String entityId}) {
    return Stream.value(null);
  }

  @override
  Future<bool> showConfigSheet({required BuildContext context}) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('AI Configuration Sheet not implemented')),
    );
    return false;
  }

  void dispose() {
    _configController.close();
    _chatEventController.close();
  }

  /// Convert an [AgentTool] to a [ToolDefinition] for the ToolRegistry.
  static ToolDefinition _agentToolToDefinition(AgentTool tool) {
    return ToolDefinition(
      type: 'function',
      function: FunctionDefinition(
        name: tool.name,
        description: tool.description,
        parameters: tool.parametersSchema,
      ),
    );
  }
}

/// 异步构建 AiChatView 的辅助 Widget。
class _AsyncChatViewBuilder extends StatefulWidget {
  const _AsyncChatViewBuilder({
    required this.aiService,
    this.initialContext,
    this.personaUuid,
  });

  final AiServiceImpl aiService;
  final AiContext? initialContext;
  final String? personaUuid;

  @override
  State<_AsyncChatViewBuilder> createState() => _AsyncChatViewBuilderState();
}

class _AsyncChatViewBuilderState extends State<_AsyncChatViewBuilder> {
  AiChatView? _chatView;
  String? _error;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      ResolvedPersona? persona;
      if (widget.personaUuid != null) {
        persona = await widget.aiService.resolvePersona(widget.personaUuid!);
      } else {
        final defaultPersona = await widget.aiService._db.aiPersonasDao
            .getDefault();
        if (defaultPersona != null) {
          persona = await widget.aiService.resolvePersona(defaultPersona.uuid);
        }
      }

      if (persona == null) {
        if (mounted) setState(() => _error = '无法解析 AI 人设');
        return;
      }

      final result = await widget.aiService._sessionManager.createSession(
        persona: persona,
        initialContext: widget.initialContext,
      );
      final sessionUuid = result.sessionUuid;

      if (mounted) {
        setState(() {
          _chatView = AiChatView(
            persona: persona!,
            sessionUuid: sessionUuid,
            db: widget.aiService._db,
            aiService: widget.aiService,
            toolRegistry: widget.aiService._toolRegistry,
            history: result.initialMessages,
            onSessionEnd: (history) {
              widget.aiService._sessionManager.saveHistory(
                sessionUuid: sessionUuid,
                history: history,
              );
            },
          );
        });
      }
    } catch (e) {
      if (mounted) setState(() => _error = '初始化失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Center(
        child: Text(_error!, style: const TextStyle(color: Colors.red)),
      );
    }
    if (_chatView != null) {
      return _chatView!;
    }
    return const Center(child: CircularProgressIndicator());
  }
}
