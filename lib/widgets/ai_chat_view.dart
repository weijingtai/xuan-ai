import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

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
  });

  final db.LlmProvider? provider;
  final db.LlmModel? model;
  final String? systemInstruction;

  @override
  State<AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<AiChatView> {
  late LlmProvider _provider;

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
        widget.model != oldWidget.model) {
      // Re-initialize provider if config changes
      _initProvider();
    }
  }

  void _initProvider() {
    if (widget.provider == null) {
      // Fallback or error state handling
      // For now using a dummy provider to prevent crash if data is missing
      _provider = DeepSeekProvider(apiKey: '');
      return;
    }

    final p = widget.provider!;
    final apiKey = p.encryptedApiKey ?? '';
    final baseUrl = p.baseUrl;
    final modelId = widget.model?.modelId ?? 'deepseek-chat';

    // Heuristic to choose provider implementation based on name or URL
    // In strict Clean Architecture, we might have a factory class for this.
    // For now, simple string matching is fine.

    if (p.name.toLowerCase().contains('deepseek') ||
        baseUrl.contains('deepseek.com')) {
      _provider = DeepSeekProvider(
        apiKey: apiKey,
        baseUrl: baseUrl,
        model: modelId,
        systemInstruction: widget.systemInstruction,
      );
    } else if (p.name.toLowerCase().contains('nvidia') ||
        baseUrl.contains('nvidia.com')) {
      _provider = NvidiaProvider(
        apiKey: apiKey,
        baseUrl: baseUrl,
        model: modelId,
        systemInstruction: widget.systemInstruction,
      );
    } else {
      // Default to OpenAI-compatible provider (which DeepSeek/Nvidia are)
      // We can reuse DeepSeekProvider as a generic OpenAI-compatible one
      // since the implementation is basically standard.
      _provider = DeepSeekProvider(
        apiKey: apiKey,
        baseUrl: baseUrl,
        model: modelId,
        systemInstruction: widget.systemInstruction,
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
