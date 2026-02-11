import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:common/domain/ai/ai_persona.dart' as common;

import '../database/ai_database.dart' as db;
import '../src/providers/deepseek_provider.dart';
import '../src/providers/nvidia_provider.dart';

/// A wrapper widget for the AI Chat interface.
/// It allows switching between different AI providers and customizing the UI.
class AiChatView extends StatefulWidget {
  const AiChatView({
    super.key,
    this.provider,
    this.model,
    this.systemInstruction,
    this.initialContext,
    this.persona,
    this.database,
  });

  final db.LlmProvider? provider;
  final db.LlmModel? model;
  final String? systemInstruction;
  final dynamic initialContext;
  final common.AiPersona? persona;
  final db.AiDatabase? database;

  @override
  State<AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<AiChatView> {
  late LlmProvider _provider;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initProvider();
  }

  @override
  void didUpdateWidget(AiChatView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.systemInstruction != oldWidget.systemInstruction ||
        widget.provider != oldWidget.provider ||
        widget.model != oldWidget.model ||
        widget.persona != oldWidget.persona) {
      // Re-initialize provider if config changes
      _initProvider();
    }
  }

  void _initProvider() async {
    if (widget.persona != null && widget.database != null) {
      setState(() => _isLoading = true);
      await _initFromPersona();
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    if (widget.provider == null) {
      // Fallback or error state handling
      // For now using a dummy provider to prevent crash if data is missing
      _provider = DeepSeekProvider(apiKey: '');
      return;
    }

    _configureProvider(
      widget.provider!,
      widget.model,
      widget.systemInstruction,
    );
  }

  Future<void> _initFromPersona() async {
    final database = widget.database!;
    final commonPersona = widget.persona!;

    // 1. Fetch full Persona from DB to get configuration (system prompt UUID, model UUID)
    // database.aiPersonasDao.getByUuid returns the Drift-generated AiPersona
    final dbPersona = await database.aiPersonasDao.getByUuid(
      commonPersona.uuid,
    );

    if (dbPersona == null) {
      // Should not happen if data consistency is maintained
      _provider = DeepSeekProvider(apiKey: '');
      return;
    }

    // 2. Fetch System Prompt
    String? systemInstruction;
    if (dbPersona.systemPromptUuid != null) {
      final template = await database.promptTemplatesDao.getByUuid(
        dbPersona.systemPromptUuid!,
      );
      systemInstruction = template?.content;
    }

    // 3. Fetch Model Config
    db.LlmProvider? provider;
    db.LlmModel? model;

    // Use modelUuid from the DB entity
    // modelUuid is not nullable in DB schema
    model = await database.llmModelsDao.getByUuid(dbPersona.modelUuid);
    if (model != null) {
      provider = await database.llmProvidersDao.getByUuid(model.providerUuid);
    }

    // Fallback to default model if not found in persona
    if (provider == null || model == null) {
      final defaultModel = await database.llmModelsDao.getDefault();
      if (defaultModel != null) {
        model = defaultModel;
        provider = await database.llmProvidersDao.getByUuid(
          defaultModel.providerUuid,
        );
      }
    }

    if (provider != null) {
      _configureProvider(provider, model, systemInstruction);
    } else {
      // Last resort fallback
      _provider = DeepSeekProvider(
        apiKey: '',
        systemInstruction: systemInstruction,
      );
    }
  }

  void _configureProvider(
    db.LlmProvider p,
    db.LlmModel? m,
    String? systemInstruction,
  ) {
    final apiKey = p.encryptedApiKey ?? '';
    final baseUrl = p.baseUrl;
    final modelId = m?.modelId ?? 'deepseek-chat';

    if (p.name.toLowerCase().contains('deepseek') ||
        baseUrl.contains('deepseek.com')) {
      _provider = DeepSeekProvider(
        apiKey: apiKey,
        baseUrl: baseUrl,
        model: modelId,
        systemInstruction: systemInstruction,
      );
    } else if (p.name.toLowerCase().contains('nvidia') ||
        baseUrl.contains('nvidia.com')) {
      _provider = NvidiaProvider(
        apiKey: apiKey,
        baseUrl: baseUrl,
        model: modelId,
        systemInstruction: systemInstruction,
      );
    } else {
      _provider = DeepSeekProvider(
        apiKey: apiKey,
        baseUrl: baseUrl,
        model: modelId,
        systemInstruction: systemInstruction,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Custom style for the chat view to match Xuan aesthetic
    final style = LlmChatViewStyle(
      backgroundColor: Colors.grey[50], // Or a parchment color
      userMessageStyle: const UserMessageStyle(
        decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
      ),
      llmMessageStyle: const LlmMessageStyle(
        decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
        icon: Icons.psychology,
      ),
    );

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('AI 占测助手')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('AI 占测助手'), actions: []),
      body: LlmChatView(
        provider: _provider,
        style: style,
        welcomeMessage: '您好，我是您的 AI 占测助手。请问有什么可以帮您？',
      ),
    );
  }
}
