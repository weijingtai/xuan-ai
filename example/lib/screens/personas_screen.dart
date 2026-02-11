import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_core/ai_core.dart';
import 'package:common/database/app_database.dart' as common_db;

/// Persona management screen that lists all AI personas and allows
/// creating, editing, deleting, and setting defaults.
/// Uses [AiPersonaEditor] from the core library for the editor page.
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
            return const Center(
              child: Text('No personas yet. Tap + to create one.'),
            );
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

  Future<void> _openEditor(
    BuildContext context,
    AiDatabase db, {
    AiPersona? persona,
  }) async {
    final appDb = context.read<common_db.AppDatabase>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AiPersonaEditor(db: db, appDb: appDb, persona: persona),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    AiDatabase db,
    AiPersona persona,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete persona?'),
        content: Text('Are you sure you want to delete "${persona.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
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
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer,
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
