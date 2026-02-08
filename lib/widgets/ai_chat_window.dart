import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/ai_database.dart';
import '../viewmodels/ai_chat_viewmodel.dart';
import 'chat_message_bubble.dart';
import 'chat_input_bar.dart';

/// Main AI chat window widget
class AiChatWindow extends StatefulWidget {
  final String? divinationUuid;
  final Map<String, dynamic>? initialContext;
  final String? initialPersonaUuid;
  final VoidCallback? onClose;

  const AiChatWindow({
    super.key,
    this.divinationUuid,
    this.initialContext,
    this.initialPersonaUuid,
    this.onClose,
  });

  @override
  State<AiChatWindow> createState() => _AiChatWindowState();
}

class _AiChatWindowState extends State<AiChatWindow> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initSession();
  }

  Future<void> _initSession() async {
    final viewModel = context.read<AiChatViewModel>();

    if (viewModel.hasSession) return;

    // Get default persona if not specified
    String personaUuid = widget.initialPersonaUuid ?? '';
    if (personaUuid.isEmpty) {
      final db = context.read<AiDatabase>();
      final defaultPersona = await db.aiPersonasDao.getDefault();
      personaUuid = defaultPersona?.uuid ?? 'default-master';
    }

    await viewModel.startSession(
      personaUuid: personaUuid,
      divinationUuid: widget.divinationUuid,
      context: widget.initialContext,
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AiChatViewModel>(
      builder: (context, viewModel, child) {
        // Auto-scroll when messages change
        if (viewModel.messages.isNotEmpty) {
          _scrollToBottom();
        }

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header
              _buildHeader(context, viewModel),

              // Messages
              Expanded(
                child: _buildMessageList(context, viewModel),
              ),

              // Input
              ChatInputBar(
                onSend: viewModel.sendMessage,
                isLoading: viewModel.isLoading,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, AiChatViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          // Persona avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
            child: Text(
              viewModel.currentPersona?.name.substring(0, 1) ?? 'AI',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Persona name and status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.currentPersona?.name ?? 'AI 助手',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (viewModel.isLoading)
                  const Text(
                    '正在思考...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),

          // Actions
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: viewModel.messages.isEmpty
                ? null
                : viewModel.regenerateLastResponse,
            tooltip: '重新生成',
          ),
          if (widget.onClose != null)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: widget.onClose,
              tooltip: '关闭',
            ),
        ],
      ),
    );
  }

  Widget _buildMessageList(BuildContext context, AiChatViewModel viewModel) {
    if (viewModel.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              viewModel.error!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (viewModel.messages.isEmpty && !viewModel.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              '开始与${viewModel.currentPersona?.name ?? "AI"}对话',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.messages.length,
      itemBuilder: (context, index) {
        final message = viewModel.messages[index];
        // Skip system messages
        if (message.role == 'system') return const SizedBox.shrink();

        return ChatMessageBubble(
          message: message,
          isStreaming: message.isStreaming,
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
