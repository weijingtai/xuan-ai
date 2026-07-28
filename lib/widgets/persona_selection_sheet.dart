import 'package:persistence_drift/ai/ai_database.dart';
import 'package:flutter/material.dart';
import 'ai_persona_editor.dart';
import 'persona_selector.dart';

class PersonaSelectionSheet extends StatefulWidget {
  final List<AiPersona> initialPersonas;
  final String? selectedUuid;
  final AiDatabase? aiDatabase;
  final Future<void> Function(AiPersona) onDelete;
  final Future<List<AiPersona>> Function() onRefresh;

  const PersonaSelectionSheet({
    super.key,
    required this.initialPersonas,
    this.selectedUuid,
    this.aiDatabase,
    required this.onDelete,
    required this.onRefresh,
  });

  @override
  State<PersonaSelectionSheet> createState() => _PersonaSelectionSheetState();
}

class _PersonaSelectionSheetState extends State<PersonaSelectionSheet> {
  late List<AiPersona> _personas;
  String? _newPersonaUuid;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _personas = widget.initialPersonas;
  }

  Future<void> _handleRefresh() async {
    setState(() => _isLoading = true);
    try {
      final updated = await widget.onRefresh();
      if (mounted) {
        setState(() => _personas = updated);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleAdd() async {
    // Navigate to full featured Editor
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => AiPersonaEditor(db: widget.aiDatabase),
      ),
    );

    if (result != null) {
      if (!mounted) return;
      // Refresh list
      await _handleRefresh();
      if (mounted) {
        setState(() {
          _newPersonaUuid = result;
        });
      }
    }
  }

  Future<void> _handleDelete(AiPersona persona) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除人设'),
        content: Text('确定要删除 "${persona.name}" 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      if (!mounted) return;
      setState(() => _isLoading = true);
      try {
        await widget.onDelete(persona);
        await _handleRefresh();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('删除失败: $e')));
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SingleChildScrollView(
      child: PersonaSelector(
        personas: _personas,
        selectedUuid: widget.selectedUuid,
        newPersonaUuid: _newPersonaUuid,
        onSelected: (persona) => Navigator.of(context).pop(persona),
        onAdd: _handleAdd,
        onDelete: _handleDelete,
      ),
    );
  }
}
