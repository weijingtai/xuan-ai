import 'package:ai_core/ai/ai_chat_event.dart';
import 'package:ai_core/ai/session_summary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:ai_core/ai/resolved_persona.dart';
import 'package:ai_core/ai_core.dart' hide LlmProvider;
import 'package:logging/logging.dart';

import '../services/ai_service_impl.dart';
import '../services/chat/provider_factory.dart';
import '../services/tool/tool_registry.dart';
import '../database/ai_database.dart' hide LlmProvider;
import 'ai_chat_settings_dialog.dart';

/// AI 聊天界面。
///
/// 接收 [ResolvedPersona] 和 [sessionUuid]，内部通过 [ProviderFactory]
/// 从 Persona 配置中构建 Provider。
///
/// 支持实时修改配置（Provider/Model/Prompt），修改引发 [LlmProvider] 重建。
/// 左侧 Drawer 提供历史会话列表，可切换/恢复历史对话。
class AiChatView extends StatefulWidget {
  const AiChatView({
    super.key,
    required this.persona,
    required this.sessionUuid,
    required this.db,
    required this.aiService,
    this.toolRegistry,
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

  /// 可选的 ToolRegistry（用于 DeepSeekProvider 的 tool calling）
  final ToolRegistry? toolRegistry;

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
  static final _log = Logger('AiChatView');
  late LlmProvider _provider;
  late ResolvedPersona _currentPersona;
  late String _currentSessionUuid;

  // Keep track of current history to preserve it across provider rebuilds
  List<ChatMessage> _currentHistory = [];

  @override
  void initState() {
    super.initState();
    _currentPersona = widget.persona;
    _currentSessionUuid = widget.sessionUuid;
    _currentHistory = widget.history ?? [];
    _initProvider();
  }

  void _initProvider() {
    _log.info('[_initProvider] persona=${_currentPersona.name}, '
        'model=${_currentPersona.modelId}, '
        'session=$_currentSessionUuid, '
        'history=${_currentHistory.length}, '
        'hasToolRegistry=${widget.toolRegistry != null}');
    _provider = ProviderFactory.createFromPersona(
      _currentPersona,
      history: _currentHistory,
      toolRegistry: widget.toolRegistry,
      onToolResult: _onToolResult,
    );

    // Listen to history changes to keep _currentHistory updated
    _provider.addListener(_onProviderChanged);
  }

  /// Called after a tool execution completes. Emits a [ToolResultEvent]
  /// via the AiService's chat event stream.
  void _onToolResult(String toolName, Map<String, dynamic> result) {
    _log.info('[_onToolResult] tool="$toolName", '
        'session=$_currentSessionUuid, '
        'resultKeys=${result.keys.toList()}, '
        'hasError=${result.containsKey("error")}');
    debugPrint('🔧 [AiChatView] _onToolResult: tool=$toolName, keys=${result.keys.toList()}');
    final aiService = widget.aiService;
    if (aiService is AiServiceImpl) {
      aiService.emitChatEvent(
        ToolResultEvent(
          sessionUuid: _currentSessionUuid,
          toolName: toolName,
          resultData: result,
        ),
      );
      debugPrint('🔧 [AiChatView] emitted ToolResultEvent for "$toolName"');
    } else {
      _log.warning('[_onToolResult] aiService is not AiServiceImpl (${aiService.runtimeType}), cannot emit event');
      debugPrint('🔧 [AiChatView] WARNING: aiService is ${aiService.runtimeType}, cannot emit event');
    }
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

  // ============================================================
  // Session History
  // ============================================================

  /// 切换到历史会话
  Future<void> _switchToSession(SessionSummary session) async {
    _log.info('[_switchToSession] switching to session=${session.uuid}');

    // 1. 先保存当前会话
    final aiService = widget.aiService;
    if (aiService is AiServiceImpl) {
      aiService.sessionManager.saveHistory(
        sessionUuid: _currentSessionUuid,
        history: _provider.history,
      );
    }

    // 2. 恢复目标会话
    if (aiService is AiServiceImpl) {
      final result = await aiService.sessionManager.resumeSession(session.uuid);
      if (result == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('无法恢复该会话')),
          );
        }
        return;
      }

      // 3. 解析 persona
      final persona = await aiService.resolvePersona(session.personaUuid);
      if (persona == null || !mounted) return;

      // 4. 切换 provider
      setState(() {
        _provider.removeListener(_onProviderChanged);
        _currentSessionUuid = session.uuid;
        _currentPersona = persona;
        _currentHistory = result.messages;
        _initProvider();
      });

      _log.info('[_switchToSession] switched to session=${session.uuid}, '
          'messages=${result.messages.length}');
    }
  }

  /// 创建新会话
  Future<void> _createNewSession() async {
    _log.info('[_createNewSession] creating new session');

    final aiService = widget.aiService;
    if (aiService is AiServiceImpl) {
      // 保存当前会话
      aiService.sessionManager.saveHistory(
        sessionUuid: _currentSessionUuid,
        history: _provider.history,
      );

      // 创建新会话
      final result = await aiService.sessionManager.createSession(
        persona: _currentPersona,
      );

      if (!mounted) return;

      setState(() {
        _provider.removeListener(_onProviderChanged);
        _currentSessionUuid = result.sessionUuid;
        _currentHistory = result.initialMessages;
        _initProvider();
      });

      _log.info('[_createNewSession] created session=${result.sessionUuid}');
    }
  }

  // ============================================================
  // Settings & Info
  // ============================================================

  Future<void> _openSettings() async {
    final resultUuid = await showDialog<String>(
      context: context,
      builder: (context) => AiChatSettingsDialog(
        db: widget.db,
        personaUuid: _currentPersona.uuid,
      ),
    );

    if (resultUuid != null && mounted) {
      if (resultUuid != _currentPersona.uuid) {
        await widget.aiService.updateSessionPersona(
          sessionUuid: _currentSessionUuid,
          personaUuid: resultUuid,
        );
        if (!mounted) return;
      }

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
          title: Text(_currentPersona.name),
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

  // ============================================================
  // Build
  // ============================================================

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
      drawer: _buildSessionHistoryDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.history),
            tooltip: '历史会话',
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: Text(_currentPersona.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment_outlined),
            tooltip: '新建会话',
            onPressed: _createNewSession,
          ),
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
      body: LlmChatView(
        key: ValueKey(_provider),
        provider: _provider,
        style: style,
        welcomeMessage:
            widget.welcomeMessage ?? '您好，我是${_currentPersona.name}。请问有什么可以帮您？',
      ),
    );
  }

  /// 构建历史会话抽屉
  Widget _buildSessionHistoryDrawer() {
    return Drawer(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '历史会话',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _currentPersona.name,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),

          // Session list
          Expanded(
            child: FutureBuilder<List<SessionSummary>>(
              future: widget.aiService.listSessions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('加载失败: ${snapshot.error}'),
                  );
                }

                final sessions = snapshot.data ?? [];
                if (sessions.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Text(
                        '暂无历史会话',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }

                // Sort by lastMessageAt descending (most recent first)
                sessions.sort((a, b) {
                  final aTime = a.lastMessageAt ?? a.createdAt;
                  final bTime = b.lastMessageAt ?? b.createdAt;
                  return bTime.compareTo(aTime);
                });

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    final session = sessions[index];
                    final isCurrentSession = session.uuid == _currentSessionUuid;
                    return _buildSessionTile(session, isCurrentSession);
                  },
                );
              },
            ),
          ),

          // New session button at bottom
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('新建会话'),
            onTap: () {
              Navigator.of(context).pop(); // Close drawer
              _createNewSession();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSessionTile(SessionSummary session, bool isCurrent) {
    final timeStr = _formatTime(session.lastMessageAt ?? session.createdAt);
    final title = session.title ?? '会话 ${session.uuid.substring(0, 8)}';

    return ListTile(
      selected: isCurrent,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
      leading: Icon(
        isCurrent ? Icons.chat_bubble : Icons.chat_bubble_outline,
        color: isCurrent ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: isCurrent
            ? TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)
            : null,
      ),
      subtitle: Text(
        '$timeStr  ${session.messageCount}条消息',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: isCurrent
          ? const Icon(Icons.check_circle, size: 16)
          : null,
      onTap: isCurrent
          ? null
          : () {
              Navigator.of(context).pop(); // Close drawer
              _switchToSession(session);
            },
      onLongPress: () => _showSessionActions(session),
    );
  }

  void _showSessionActions(SessionSummary session) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.archive_outlined),
              title: const Text('归档'),
              onTap: () async {
                Navigator.of(context).pop();
                await widget.aiService.archiveSession(session.uuid);
                if (mounted) setState(() {}); // Refresh drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('删除', style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.of(context).pop();
                final confirm = await showDialog<bool>(
                  context: this.context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('确认删除'),
                    content: const Text('删除后无法恢复，确定要删除这个会话吗？'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: const Text('取消'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: const Text('删除', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await widget.aiService.deleteSession(session.uuid);
                  if (mounted) setState(() {}); // Refresh drawer
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return '刚刚';
    if (diff.inHours < 1) return '${diff.inMinutes}分钟前';
    if (diff.inDays < 1) return '${diff.inHours}小时前';
    if (diff.inDays < 7) return '${diff.inDays}天前';
    return '${time.month}/${time.day}';
  }
}
