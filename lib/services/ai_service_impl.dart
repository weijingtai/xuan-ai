import 'dart:async';

import 'package:common/domain/ai/agent_tool.dart';
import 'package:common/domain/ai/ai_audit_log.dart';
import 'package:common/domain/ai/ai_action.dart';
import 'package:common/domain/ai/ai_config_summary.dart';
import 'package:common/domain/ai/ai_context.dart';
import 'package:common/services/ai_audit_service.dart';
import 'package:common/services/ai_service.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
// import 'package:provider/provider.dart'; // Unused

import '../widgets/ai_chat_view.dart';
import '../widgets/persona_selector.dart'; // Added
import 'ai_audit_service_impl.dart';
import 'llm/llm_service.dart';
import 'agent/agent_runner.dart';
import '../database/ai_database.dart'; // Added for AiDatabase and DB AiPersona
import 'package:common/domain/ai/ai_persona.dart'
    as common; // Domain model alias
import 'package:drift/drift.dart'; // For Value
import 'package:uuid/uuid.dart'; // Added

import '../widgets/add_persona_dialog.dart'; // Added

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

  AiServiceImpl({
    AiAuditService? auditService,
    required LlmService llmService,
    required AiDatabase db,
  }) : _auditService = auditService ?? AiAuditServiceImpl(),
       _llmService = llmService,
       _db = db;

  @override
  Stream<AiConfigSummary> get activeConfig => _configController.stream;

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
    return _actions.where((a) => a.isApplicable(context)).toList();
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
    return List.unmodifiable(_tools);
  }

  @override
  Future<void> openChat({
    required BuildContext context,
    AiContext? initialContext,
  }) async {
    _logger.info('Opening AI Chat with context: ${initialContext?.intention}');

    // Log the interaction
    await _auditService.logInteraction(
      AiAuditLog(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // TODO: Use UUID
        timestamp: DateTime.now(),
        type: AiAuditLogType.chat,
        sourceModule: 'ai_service',
        payload: {
          'action': 'open_chat',
          'intention': initialContext?.intention,
        },
      ),
    );

    // Push the ChatView
    // Check if we are already in a chat view? usually pushing    // Push the ChatView
    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => AiChatView(initialContext: initialContext),
        ),
      );
    }
  }

  @override
  Widget buildChatView(
    BuildContext context, {
    AiContext? initialContext,
    common.AiPersona? persona,
  }) {
    return AiChatView(
      initialContext: initialContext,
      persona: persona,
      database: _db,
    );
  }

  @override
  Future<common.AiPersona?> showPersonaSelector({
    required BuildContext context,
    List<int>? requiredSkills,
  }) async {
    // 1. Fetch personas from DB
    // If strict skill filtering is needed, we would need to join with PromptSkillBindings and PromptTemplates.
    // For now, we fetch all enabled personas and filter in memory if needed (though not implemented yet).
    final dbPersonas = await _db.aiPersonasDao.getAllEnabled();

    // 2. Show Bottom Sheet
    if (!context.mounted) return null;

    final selectedDbPersona = await PersonaSelector.showAsBottomSheet(
      context,
      personas: dbPersonas,
      onAdd: () async {
        // Close the bottom sheet first? Or handle on top?
        // Better to handle on top or close and re-open.
        // Let's try handling on top.
        final result = await showDialog<PersonaCreationData>(
          context: context,
          builder: (context) => const AddPersonaDialog(),
        );

        if (result != null) {
          if (!context.mounted) return;
          await _createPersona(context, result);
          // We need to refresh the list.
          // Since showAsBottomSheet doesn't support live refresh easily without state management,
          // we might need to close and reopen, or use a StatefulBuilder inside the sheet.
          // For MVP, simplistic approach: close and reopen or just return null to let user re-open.
          // BETTER: The PersonaSelector should be wrapped in a StatefulWidget that handles the list.
          // However, we are using a static method.
          // Let's modify showPersonaSelector to handle the refresh by closing if successful and maybe re-opening?
          // No, that's jarring.
          if (context.mounted) {
            Navigator.of(context).pop(); // Close sheet
            // Re-open sheet (hacky but works for now without rewriting Selector to be stateful controller)
            if (context.mounted) {
              showPersonaSelector(
                context: context,
                requiredSkills: requiredSkills,
              );
            }
          }
        }
      },
      onDelete: (persona) async {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('删除人设'),
            content: Text('确定要删除 "${persona.name}" 吗？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('取消'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('删除'),
              ),
            ],
          ),
        );

        if (confirm == true) {
          await _db.aiPersonasDao.softDelete(persona.uuid);
          if (context.mounted) {
            Navigator.of(context).pop(); // Close sheet
            // Re-open sheet to refresh
            showPersonaSelector(
              context: context,
              requiredSkills: requiredSkills,
            );
          }
        }
      },
    );

    // 3. Map back to domain model
    if (selectedDbPersona != null) {
      return common.AiPersona(
        uuid: selectedDbPersona.uuid,
        name: selectedDbPersona.name,
        description: selectedDbPersona.description,
      );
    }
    return null;
  }

  Future<void> _createPersona(
    BuildContext context,
    PersonaCreationData data,
  ) async {
    try {
      final templateUuid = const Uuid().v4();
      final personaUuid = const Uuid().v4();

      // 1. Create System Prompt Template
      await _db.promptTemplatesDao.insertTemplate(
        PromptTemplatesCompanion(
          uuid: Value(templateUuid),
          name: Value('${data.name} System Prompt'),
          content: Value(data.systemPrompt),
          templateType: const Value('system'),
          createdAt: Value(DateTime.now()),
          lastUpdatedAt: Value(DateTime.now()),
        ),
      );

      // 2. Get Default Model (to link)
      final defaultModel = await _db.llmModelsDao.getDefault();
      final modelUuid = defaultModel?.uuid;

      if (modelUuid == null) {
        throw Exception('No default model found');
      }

      // 3. Create Persona
      await _db.aiPersonasDao.insertPersona(
        AiPersonasCompanion(
          uuid: Value(personaUuid),
          name: Value(data.name),
          description: Value(data.description),
          systemPromptUuid: Value(templateUuid),
          modelUuid: Value(modelUuid),
          createdAt: Value(DateTime.now()),
          lastUpdatedAt: Value(DateTime.now()),
        ),
      );

      _logger.info('Created persona: ${data.name} ($personaUuid)');
    } catch (e) {
      _logger.severe('Failed to create persona', e);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('创建失败: $e')));
      }
    }
  }

  @override
  Future<String> analyze({required AiContext context}) async {
    _logger.info('Analyzing with context: ${context.intention}');

    try {
      // Get default model
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
