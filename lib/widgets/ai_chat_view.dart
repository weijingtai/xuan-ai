import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:common/domain/ai/resolved_persona.dart';
import 'package:common/services/ai_service.dart';

import '../services/chat/provider_factory.dart';
import '../database/ai_database.dart' hide LlmProvider;
import 'ai_chat_settings_dialog.dart';

/// AI 聊天界面。
///
/// 接收 [ResolvedPersona] 和 [sessionUuid]，内部通过 [ProviderFactory]
/// 从 Persona 配置中构建 Provider。
///
/// 支持实时修改配置（Provider/Model/Prompt），修改引发 [LlmProvider] 重建。
class AiChatView extends StatefulWidget {
  const AiChatView({
    super.key,
    required this.persona,
    required this.sessionUuid,
    required this.db,
    required this.aiService,
    this.history,
    this.onSessionEnd,
    this.welcomeMessage,
  });

  /// 初始 Persona 运行时配置
  final ResolvedPersona persona;

  /// 关联的 Session UUID
  final String sessionUuid;

  /// 数据库实例（用于配置对话框）
  final AiDatabase db;

  /// AI 服务实例（用于解析 Persona 和更新 Session）
  final AiService aiService;

  /// 可选的历史消息
  final List<ChatMessage>? history;

  /// Session 结束回调
  final void Function(Iterable<ChatMessage> history)? onSessionEnd;

  /// 欢迎消息
  final String? welcomeMessage;

  @override
  State<AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<AiChatView> {
  late LlmProvider _provider;
  late ResolvedPersona _currentPersona;

  // Keep track of current history to preserve it across provider rebuilds
  List<ChatMessage> _currentHistory = [];

  @override
  void initState() {
    super.initState();
    _currentPersona = widget.persona;
    _currentHistory = widget.history ?? [];
    _initProvider();
  }

  void _initProvider() {
    // Re-create provider from current persona
    // Pass _currentHistory so messages are preserved
    _provider = ProviderFactory.createFromPersona(
      _currentPersona,
      history: _currentHistory,
    );

    // Listen to history changes to keep _currentHistory updated
    _provider.addListener(_onProviderChanged);
  }

  void _onProviderChanged() {
    // Sync history
    _currentHistory = _provider.history.toList();
  }

  @override
  void dispose() {
    _provider.removeListener(_onProviderChanged);
    // 页面关闭时，将 Provider 中的消息历史回传给上层保存
    widget.onSessionEnd?.call(_provider.history);
    super.dispose();
  }

  Future<void> _openSettings() async {
    final resultUuid = await showDialog<String>(
      context: context,
      builder: (context) => AiChatSettingsDialog(
        db: widget.db,
        personaUuid: _currentPersona.uuid,
      ),
    );

    if (resultUuid != null && mounted) {
      // 1. If user did "Save As", we need to update the session to point to the new persona
      if (resultUuid != _currentPersona.uuid) {
        await widget.aiService.updateSessionPersona(
          sessionUuid: widget.sessionUuid,
          personaUuid: resultUuid,
        );
        if (!mounted) return;
      }

      // 2. Resolve the new (or updated) persona configuration
      final newPersona = await widget.aiService.resolvePersona(resultUuid);
      if (!mounted) return;

      if (newPersona != null) {
        setState(() {
          _currentPersona = newPersona;

          // Re-initialize provider with new settings but SAME history
          _provider.removeListener(_onProviderChanged);
          _initProvider();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('已切换至: ${newPersona.name} (${newPersona.modelId})'),
          ),
        );
      }
    }
  }

  void _showPersonaDetails() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_currentPersona.name), // Use current
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_currentPersona.description != null &&
                    _currentPersona.description!.isNotEmpty) ...[
                  Text('描述:', style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 4),
                  Text(_currentPersona.description!),
                  const Divider(height: 24),
                ],
                Text('系统提示词:', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    _currentPersona.systemInstruction ?? '无系统提示词',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '模型: ${_currentPersona.modelId}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('关闭'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = LlmChatViewStyle(
      backgroundColor: Colors.grey[50],
      userMessageStyle: const UserMessageStyle(
        decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
      ),
      llmMessageStyle: const LlmMessageStyle(
        decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
        icon: Icons.psychology,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentPersona.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: '设置',
            onPressed: _openSettings,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: '查看人设详情',
            onPressed: _showPersonaDetails,
          ),
        ],
      ),
      // Keying the LlmChatView by provider might strictly required if the provider instance changes?
      // LlmChatView takes `provider`. If provider changes, it should update.
      body: LlmChatView(
        key: ValueKey(_provider),
        provider: _provider,
        style: style,
        welcomeMessage:
            widget.welcomeMessage ?? '您好，我是${_currentPersona.name}。请问有什么可以帮您？',
      ),
    );
  }
}
