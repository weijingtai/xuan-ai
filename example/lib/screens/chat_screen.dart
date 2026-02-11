import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_core/ai_core.dart';

class ChatScreen extends StatelessWidget {
  final String? personaUuid;

  const ChatScreen({super.key, this.personaUuid});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AiChatViewModel(
        chatService: context.read<ChatService>(),
        persistenceService: context.read<ChatPersistenceService>(),
        db: context.read<AiDatabase>(),
      ),
      child: _ChatScreenContent(personaUuid: personaUuid),
    );
  }
}

class _ChatScreenContent extends StatefulWidget {
  final String? personaUuid;

  const _ChatScreenContent({this.personaUuid});

  @override
  State<_ChatScreenContent> createState() => _ChatScreenContentState();
}

class _ChatScreenContentState extends State<_ChatScreenContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initSession());
  }

  Future<void> _initSession() async {
    if (!mounted) return;
    final viewModel = context.read<AiChatViewModel>();

    if (viewModel.hasSession) return;

    // Get default persona if not specified
    String personaUuid = widget.personaUuid ?? '';
    if (personaUuid.isEmpty) {
      final db = context.read<AiDatabase>();
      final defaultPersona = await db.aiPersonasDao.getDefault();
      if (defaultPersona != null) {
        personaUuid = defaultPersona.uuid;
      }
    }

    if (personaUuid.isNotEmpty && mounted) {
      await viewModel.startSession(personaUuid: personaUuid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<AiChatViewModel>(
          builder: (_, vm, __) => Text(vm.currentPersona?.name ?? 'AI Chat'),
        ),
        actions: [
          // Persona selector
          IconButton(
            icon: const Icon(Icons.person_outline),
            tooltip: 'Switch Persona',
            onPressed: () => _showPersonaSelector(context),
          ),
        ],
      ),
      body: Consumer<AiChatViewModel>(
        builder: (_, vm, __) {
          if (vm.currentPersona == null && vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.currentLlmProvider == null || vm.currentPersona == null) {
            return const Center(child: Text('请选择一个 AI 人设'));
          }

          // TODO: Migrate example app to use SessionManager + ProviderFactory
          // The example app uses the deprecated ViewModel pattern.
          // Replace with AiServiceImpl.createSession() flow.
          return const Center(
            child: Text('Example app needs migration to new Session API'),
          );
        },
      ),
    );
  }

  Future<void> _showPersonaSelector(BuildContext context) async {
    final viewModel = context.read<AiChatViewModel>();
    final personas = await viewModel.getAvailablePersonas();

    if (!context.mounted) return;

    final selected = await PersonaSelector.showAsBottomSheet(
      context,
      personas: personas,
      selectedUuid: viewModel.currentPersona?.uuid,
    );

    if (selected != null) {
      await viewModel.switchPersona(selected.uuid);
    }
  }
}
