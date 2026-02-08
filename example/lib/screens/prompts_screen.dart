import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';
import 'package:ai_core/ai_core.dart';

class PromptsScreen extends StatefulWidget {
  const PromptsScreen({super.key});

  @override
  State<PromptsScreen> createState() => _PromptsScreenState();
}

class _PromptsScreenState extends State<PromptsScreen> {
  @override
  Widget build(BuildContext context) {
    final db = context.read<AiDatabase>();

    return Scaffold(
      appBar: AppBar(title: const Text('Prompt Templates')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEditor(context, db),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<PromptTemplate>>(
        stream: db.promptTemplatesDao.watchAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final templates = snapshot.data!;
          if (templates.isEmpty) {
            return const Center(child: Text('No templates yet. Tap + to create one.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final t = templates[index];
              return _TemplateTile(
                template: t,
                onTap: () => _openEditor(context, db, template: t),
                onDelete: () => _confirmDelete(context, db, t),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _openEditor(BuildContext context, AiDatabase db,
      {PromptTemplate? template}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _PromptEditorPage(db: db, template: template),
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, AiDatabase db, PromptTemplate template) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete template?'),
        content: Text('Are you sure you want to delete "${template.name}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed == true) {
      await db.promptTemplatesDao.softDelete(template.uuid);
    }
  }
}

class _TemplateTile extends StatelessWidget {
  final PromptTemplate template;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _TemplateTile({
    required this.template,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(
          _iconForType(template.templateType),
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(template.name),
        subtitle: Text(
          template.content.length > 80
              ? '${template.content.substring(0, 80)}...'
              : template.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Chip(label: Text(template.templateType)),
            if (template.isBuiltin)
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(Icons.lock, size: 16),
              ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') onTap();
                if (value == 'delete') onDelete();
              },
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                if (!template.isBuiltin)
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'system':
        return Icons.psychology;
      case 'user':
        return Icons.person;
      case 'assistant':
        return Icons.smart_toy;
      default:
        return Icons.description;
    }
  }
}

class _PromptEditorPage extends StatefulWidget {
  final AiDatabase db;
  final PromptTemplate? template;

  const _PromptEditorPage({required this.db, this.template});

  @override
  State<_PromptEditorPage> createState() => _PromptEditorPageState();
}

class _PromptEditorPageState extends State<_PromptEditorPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _contentCtrl;
  late final TextEditingController _descCtrl;
  String _templateType = 'system';
  bool _isSaving = false;

  bool get _isEditing => widget.template != null;

  static const _types = ['system', 'user', 'assistant', 'context'];

  @override
  void initState() {
    super.initState();
    final t = widget.template;
    _nameCtrl = TextEditingController(text: t?.name ?? '');
    _contentCtrl = TextEditingController(text: t?.content ?? '');
    _descCtrl = TextEditingController(text: t?.description ?? '');
    _templateType = t?.templateType ?? 'system';
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    try {
      if (_isEditing) {
        await widget.db.promptTemplatesDao.updateContent(
          widget.template!.uuid,
          _contentCtrl.text.trim(),
        );
      } else {
        await widget.db.promptTemplatesDao.insertTemplate(
          PromptTemplatesCompanion.insert(
            uuid: const Uuid().v4(),
            name: _nameCtrl.text.trim(),
            templateType: _templateType,
            content: _contentCtrl.text.trim(),
            description: Value(_descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim()),
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
        title: Text(_isEditing ? 'Edit Template' : 'New Template'),
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
              enabled: !_isEditing,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              enabled: !_isEditing,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _templateType,
              decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()),
              items: _types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: _isEditing ? null : (v) => setState(() => _templateType = v ?? 'system'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contentCtrl,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
                hintText: 'Use {{variable}} for template variables',
              ),
              maxLines: 12,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            if (_isEditing) ...[
              const SizedBox(height: 16),
              Text(
                'Editing an existing template creates a new version.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _contentCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }
}
