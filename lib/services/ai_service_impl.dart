import 'dart:async';

import 'package:common/domain/ai/agent_tool.dart';
import 'package:common/domain/ai/ai_audit_log.dart';
import 'package:common/domain/ai/ai_action.dart';
import 'package:common/domain/ai/ai_config_summary.dart';
import 'package:common/domain/ai/ai_context.dart';
import 'package:common/domain/ai/resolved_persona.dart';
import 'package:common/domain/ai/session_summary.dart';
import 'package:common/services/ai_audit_service.dart';
import 'package:common/services/ai_service.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../widgets/ai_chat_view.dart';
import '../widgets/persona_selection_sheet.dart';
import 'ai_audit_service_impl.dart';
import 'llm/llm_service.dart';
import 'agent/agent_runner.dart';
import '../database/ai_database.dart';
import 'package:common/domain/ai/ai_persona.dart'
    as common; // Domain model alias
import 'package:common/services/ai_registry.dart';
import 'chat/session_manager.dart';

class AiServiceImpl implements AiService {
  final _logger = Logger('AiServiceImpl');

  // Maintain registries
  final List<AiAction> _actions = [];
  final List<AgentTool> _tools = [];

  // Active configuration stream (mock for now)
  final _configController = StreamController<AiConfigSummary>.broadcast();

  // Services
  final AiAuditService _auditService;
  final LlmService _llmService;
  final AiDatabase _db;
  late final SessionManager _sessionManager;

  AiServiceImpl({
    AiAuditService? auditService,
    required LlmService llmService,
    required AiDatabase db,
  }) : _auditService = auditService ?? AiAuditServiceImpl(),
       _llmService = llmService,
       _db = db {
    _sessionManager = SessionManager(db: _db);
  }

  @override
  Stream<AiConfigSummary> get activeConfig => _configController.stream;

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
    _logger.info('Registered Tool: ${tool.name}');
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

    // 1. 从 DB 恢复 Session 和消息
    final result = await _sessionManager.resumeSession(sessionUuid);
    if (result == null) {
      _logger.warning('Cannot resume: session not found');
      return;
    }

    // 2. 解析 Persona
    final persona = await resolvePersona(result.session.personaUuid);
    if (persona == null) {
      _logger.warning('Cannot resume: persona not found');
      return;
    }

    // 3. 打开聊天界面（AiChatView 内部从 Persona 构造 Provider）
    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => AiChatView(
            persona: persona,
            sessionUuid: sessionUuid,
            db: _db,
            aiService: this,
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

    // 使用默认 Persona 打开 Session
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
    // buildChatView 是同步的，但我们需要异步解析。
    // 返回一个 FutureBuilder 来处理异步初始化。
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
    // TODO: Implement persistence lookup
    return null;
  }

  @override
  Stream<String?> watchSummary({required String entityId}) {
    // TODO: Implement persistence stream
    return Stream.value(null);
  }

  @override
  Future<bool> showConfigSheet({required BuildContext context}) async {
    // TODO: Implement Config Sheet
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('AI Configuration Sheet not implemented')),
    );
    return false;
  }

  void dispose() {
    _configController.close();
  }
}

/// 异步构建 AiChatView 的辅助 Widget。
///
/// 用于 [AiServiceImpl.buildChatView]，因为该方法是同步的，
/// 但我们需要异步解析 Persona 和创建 Session。
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
      // 1. 解析 Persona
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

      // 2. 创建 Session
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
