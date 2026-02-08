import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_core/ai_core.dart';

import 'chat_screen.dart';
import 'settings_screen.dart';
import 'personas_screen.dart';
import 'prompts_screen.dart';
import 'providers_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AiPersona> _personas = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final db = context.read<AiDatabase>();
      final personas = await db.aiPersonasDao.getAllEnabled();
      if (mounted) {
        setState(() {
          _personas = personas;
          _isLoading = false;
        });
      }
    } catch (e, stack) {
      debugPrint('Error loading data: $e\n$stack');
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Core Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? _buildError(context)
          : _buildBody(context),
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _error = null;
                });
                _loadData();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Personas section
        Text('AI Personas', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        if (_personas.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'No personas found. The database should have seeded a default persona.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          )
        else
          ..._personas.map((persona) => _buildPersonaCard(context, persona)),

        const SizedBox(height: 24),

        // Management
        Text('Management', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        _buildActionCard(
          context,
          icon: Icons.chat,
          title: 'Start Chat',
          subtitle: 'Open a chat session with the default persona',
          onTap: () => _startChat(context),
        ),
        _buildActionCard(
          context,
          icon: Icons.auto_awesome,
          title: 'AI Toolkit Chat',
          subtitle: 'Chat using Flutter AI Toolkit (DeepSeek/NVIDIA)',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatScreen()),
          ),
        ),
        _buildActionCard(
          context,
          icon: Icons.person_outline,
          title: 'Manage Personas',
          subtitle: 'Create, edit, and delete AI personas',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PersonasScreen()),
          ),
        ),
        _buildActionCard(
          context,
          icon: Icons.description_outlined,
          title: 'Manage Prompts',
          subtitle: 'Create, edit, and delete prompt templates',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PromptsScreen()),
          ),
        ),
        _buildActionCard(
          context,
          icon: Icons.cloud_outlined,
          title: 'Manage Providers & Models',
          subtitle: 'Configure LLM providers and models',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProvidersScreen()),
          ),
        ),
        _buildActionCard(
          context,
          icon: Icons.build,
          title: 'Registered Tools',
          subtitle: _getToolsSummary(),
          onTap: null,
        ),

        const SizedBox(height: 24),

        // Info section
        Text('Package Info', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRow('Package', 'ai_core'),
                _infoRow('Database', 'Drift (SQLite)'),
                _infoRow('State Management', 'Provider'),
                _infoRow('LLM Client', 'OpenAI-compatible'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPersonaCard(BuildContext context, AiPersona persona) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            persona.name.substring(0, 1),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(persona.name),
        subtitle: Text(persona.description ?? 'No description'),
        trailing: persona.isDefault
            ? Chip(
                label: const Text('Default'),
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer,
              )
            : null,
        onTap: () => _startChatWithPersona(context, persona.uuid),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
        onTap: onTap,
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _getToolsSummary() {
    final registry = context.read<ToolRegistry>();
    final tools = registry.getRegisteredToolNames();
    if (tools.isEmpty) return 'No tools registered';
    return '${tools.length} tool(s): ${tools.join(", ")}';
  }

  void _startChat(BuildContext context) {
    final persona = _personas.isNotEmpty ? _personas.first : null;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatScreen(personaUuid: persona?.uuid)),
    );
  }

  void _startChatWithPersona(BuildContext context, String personaUuid) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatScreen(personaUuid: personaUuid)),
    );
  }
}
