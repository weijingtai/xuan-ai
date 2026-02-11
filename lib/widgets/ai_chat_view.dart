import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:common/domain/ai/resolved_persona.dart';

import '../services/chat/provider_factory.dart';

/// AI 聊天界面。
///
/// 接收 [ResolvedPersona] 和 [sessionUuid]，内部通过 [ProviderFactory]
/// 从 Persona 配置中构建 Provider，确保 Provider 使用的所有参数
/// （apiKey、baseUrl、modelId、temperature、systemInstruction）
/// 全部来自 Persona。
class AiChatView extends StatefulWidget {
  const AiChatView({
    super.key,
    required this.persona,
    required this.sessionUuid,
    this.history,
    this.onSessionEnd,
    this.welcomeMessage,
  });

  /// 完整的 Persona 运行时配置（含 provider/model 信息）
  final ResolvedPersona persona;

  /// 关联的 Session UUID
  final String sessionUuid;

  /// 可选的历史消息（用于恢复 Session）
  final List<ChatMessage>? history;

  /// Session 结束回调（页面关闭时触发，上层负责保存历史）
  final void Function(Iterable<ChatMessage> history)? onSessionEnd;

  /// 欢迎消息
  final String? welcomeMessage;

  @override
  State<AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<AiChatView> {
  late final LlmProvider _provider;

  @override
  void initState() {
    super.initState();
    // Provider 从 Persona 配置构建，所有参数（baseUrl 等）来自 Persona
    _provider = ProviderFactory.createFromPersona(
      widget.persona,
      history: widget.history,
    );
  }

  @override
  void dispose() {
    // 页面关闭时，将 Provider 中的消息历史回传给上层保存
    widget.onSessionEnd?.call(_provider.history);
    super.dispose();
  }

  void _showPersonaDetails() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(widget.persona.name),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.persona.description != null &&
                    widget.persona.description!.isNotEmpty) ...[
                  Text('描述:', style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 4),
                  Text(widget.persona.description!),
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
                    widget.persona.systemInstruction ?? '无系统提示词',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
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
        title: Text(widget.persona.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: '查看人设详情',
            onPressed: _showPersonaDetails,
          ),
        ],
      ),
      body: LlmChatView(
        provider: _provider,
        style: style,
        welcomeMessage:
            widget.welcomeMessage ?? '您好，我是${widget.persona.name}。请问有什么可以帮您？',
      ),
    );
  }
}
