import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';
import 'package:ai_core/ai_core.dart';

class PersonasScreen extends StatefulWidget {
  const PersonasScreen({super.key});

  @override
  State<PersonasScreen> createState() => _PersonasScreenState();
}

class _PersonasScreenState extends State<PersonasScreen> {
  @override
  Widget build(BuildContext context) {
    final db = context.read<AiDatabase>();

    return Scaffold(
      appBar: AppBar(title: const Text('AI Personas')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEditor(context, db),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<AiPersona>>(
        stream: db.aiPersonasDao.watchAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final personas = snapshot.data!;
          if (personas.isEmpty) {
            return const Center(child: Text('No personas yet. Tap + to create one.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: personas.length,
            itemBuilder: (context, index) {
              final p = personas[index];
              return _PersonaTile(
                persona: p,
                onTap: () => _openEditor(context, db, persona: p),
                onDelete: () => _confirmDelete(context, db, p),
                onSetDefault: p.isDefault
                    ? null
                    : () async {
                        await db.aiPersonasDao.setDefault(p.uuid);
                      },
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _openEditor(BuildContext context, AiDatabase db,
      {AiPersona? persona}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _PersonaEditorPage(db: db, persona: persona),
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, AiDatabase db, AiPersona persona) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete persona?'),
        content: Text('Are you sure you want to delete "${persona.name}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed == true) {
      await db.aiPersonasDao.softDelete(persona.uuid);
    }
  }
}

class _PersonaTile extends StatelessWidget {
  final AiPersona persona;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback? onSetDefault;

  const _PersonaTile({
    required this.persona,
    required this.onTap,
    required this.onDelete,
    this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            persona.name.isNotEmpty ? persona.name.substring(0, 1) : '?',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(persona.name),
        subtitle: Text(persona.description ?? 'No description'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (persona.isDefault)
              Chip(
                label: const Text('Default'),
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              )
            else if (onSetDefault != null)
              IconButton(
                icon: const Icon(Icons.star_border),
                tooltip: 'Set as default',
                onPressed: onSetDefault,
              ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') onTap();
                if (value == 'delete') onDelete();
              },
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class _PersonaEditorPage extends StatefulWidget {
  final AiDatabase db;
  final AiPersona? persona;

  const _PersonaEditorPage({required this.db, this.persona});

  @override
  State<_PersonaEditorPage> createState() => _PersonaEditorPageState();
}

class _PersonaEditorPageState extends State<_PersonaEditorPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _tempCtrl;
  late final TextEditingController _topPCtrl;
  late final TextEditingController _maxTokensCtrl;

  List<LlmModel> _models = [];
  List<PromptTemplate> _prompts = [];
  String? _selectedModelUuid;
  String? _selectedPromptUuid;
  bool _isSaving = false;

  bool get _isEditing => widget.persona != null;

  @override
  void initState() {
    super.initState();
    final p = widget.persona;
    _nameCtrl = TextEditingController(text: p?.name ?? '');
    _descCtrl = TextEditingController(text: p?.description ?? '');
    _tempCtrl = TextEditingController(text: (p?.temperature ?? 0.7).toString());
    _topPCtrl = TextEditingController(text: (p?.topP ?? 1.0).toString());
    _maxTokensCtrl = TextEditingController(text: (p?.maxTokens ?? 2048).toString());
    _selectedModelUuid = p?.modelUuid;
    _selectedPromptUuid = p?.systemPromptUuid;
    _loadDropdowns();
  }

  Future<void> _loadDropdowns() async {
    final models = await widget.db.llmModelsDao.getByProvider(
      (await widget.db.llmProvidersDao.getDefault())?.uuid ?? '',
    );
    final prompts = await widget.db.promptTemplatesDao.getSystemPrompts();
    if (mounted) {
      setState(() {
        _models = models;
        _prompts = prompts;
        if (_selectedModelUuid == null && models.isNotEmpty) {
          _selectedModelUuid = models.first.uuid;
        }
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedModelUuid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a model')),
      );
      return;
    }
    setState(() => _isSaving = true);
    try {
      if (_isEditing) {
        await widget.db.aiPersonasDao.updatePersona(
          widget.persona!.uuid,
          AiPersonasCompanion(
            name: Value(_nameCtrl.text.trim()),
            description: Value(_descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim()),
            modelUuid: Value(_selectedModelUuid!),
            systemPromptUuid: Value(_selectedPromptUuid),
            temperature: Value(double.tryParse(_tempCtrl.text) ?? 0.7),
            topP: Value(double.tryParse(_topPCtrl.text) ?? 1.0),
            maxTokens: Value(int.tryParse(_maxTokensCtrl.text) ?? 2048),
          ),
        );
      } else {
        await widget.db.aiPersonasDao.insertPersona(
          AiPersonasCompanion.insert(
            uuid: const Uuid().v4(),
            name: _nameCtrl.text.trim(),
            description: Value(_descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim()),
            modelUuid: _selectedModelUuid!,
            systemPromptUuid: Value(_selectedPromptUuid),
            temperature: Value(double.tryParse(_tempCtrl.text) ?? 0.7),
            topP: Value(double.tryParse(_topPCtrl.text) ?? 1.0),
            maxTokens: Value(int.tryParse(_maxTokensCtrl.text) ?? 2048),
            createdAt: DateTime.now(),
          ),
        );
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Persona' : 'New Persona'),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _save,
            child: _isSaving
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedModelUuid,
              decoration: const InputDecoration(labelText: 'Model', border: OutlineInputBorder()),
              items: _models.map((m) => DropdownMenuItem(value: m.uuid, child: Text(m.displayName))).toList(),
              onChanged: (v) => setState(() => _selectedModelUuid = v),
              validator: (v) => v == null ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedPromptUuid,
              decoration: const InputDecoration(labelText: 'System Prompt (optional)', border: OutlineInputBorder()),
              items: [
                const DropdownMenuItem(value: null, child: Text('None')),
                ..._prompts.map((p) => DropdownMenuItem(value: p.uuid, child: Text(p.name))),
              ],
              onChanged: (v) => setState(() => _selectedPromptUuid = v),
            ),
            const SizedBox(height: 24),
            Text('Parameters', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _tempCtrl,
                    decoration: const InputDecoration(labelText: 'Temperature', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _topPCtrl,
                    decoration: const InputDecoration(labelText: 'Top P', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _maxTokensCtrl,
                    decoration: const InputDecoration(labelText: 'Max Tokens', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _tempCtrl.dispose();
    _topPCtrl.dispose();
    _maxTokensCtrl.dispose();
    super.dispose();
  }
}
