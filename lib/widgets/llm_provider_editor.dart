import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';

import '../database/ai_database.dart';
import '../services/llm/llm_service.dart';

/// LLM Provider editor widget for creating and editing providers.
///
/// Can be used standalone or as part of a larger flow. Optionally accepts
/// [db] and [llmService], otherwise fetches from Provider context.
class LlmProviderEditor extends StatefulWidget {
  final AiDatabase? db;
  final LlmService? llmService;
  final LlmProvider? provider;

  const LlmProviderEditor({super.key, this.db, this.llmService, this.provider});

  @override
  State<LlmProviderEditor> createState() => _LlmProviderEditorState();
}

class _LlmProviderEditorState extends State<LlmProviderEditor> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _baseUrlCtrl;
  late final TextEditingController _apiKeyCtrl;
  bool _isSaving = false;

  bool get _isEditing => widget.provider != null;

  AiDatabase get _db => widget.db ?? context.read<AiDatabase>();
  LlmService get _llmService => widget.llmService ?? context.read<LlmService>();

  @override
  void initState() {
    super.initState();
    final p = widget.provider;
    _nameCtrl = TextEditingController(text: p?.name ?? '');
    _baseUrlCtrl = TextEditingController(
      text: p?.baseUrl ?? 'https://api.openai.com/v1',
    );
    _apiKeyCtrl = TextEditingController(text: p?.encryptedApiKey ?? '');
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final isNew = !_isEditing;
    debugPrint('[LlmProviderEditor] _save: isNew=$isNew');
    try {
      final uuid = _isEditing ? widget.provider!.uuid : const Uuid().v4();
      debugPrint(
        '[LlmProviderEditor] _save: upserting provider uuid=$uuid, '
        'name=${_nameCtrl.text.trim()}, baseUrl=${_baseUrlCtrl.text.trim()}',
      );
      await _db.llmProvidersDao.upsert(
        LlmProvidersCompanion(
          uuid: Value(uuid),
          name: Value(_nameCtrl.text.trim()),
          baseUrl: Value(_baseUrlCtrl.text.trim()),
          encryptedApiKey: Value(
            _apiKeyCtrl.text.trim().isEmpty ? null : _apiKeyCtrl.text.trim(),
          ),
          createdAt: Value(
            _isEditing ? widget.provider!.createdAt : DateTime.now(),
          ),
          lastUpdatedAt: Value(DateTime.now()),
        ),
      );
      debugPrint('[LlmProviderEditor] _save: provider saved successfully');

      // Auto-sync models for new providers (best-effort).
      if (isNew) {
        debugPrint(
          '[LlmProviderEditor] _save: auto-syncing models for '
          'new provider $uuid',
        );
        try {
          final added = await _llmService.syncModelsFromRemote(uuid);
          debugPrint(
            '[LlmProviderEditor] _save: auto-sync completed, '
            '$added model(s) added',
          );
        } catch (e, st) {
          debugPrint(
            '[LlmProviderEditor] _save: auto-sync failed (non-fatal) '
            '— $e\n$st',
          );
        }
      }

      if (mounted) Navigator.pop(context, uuid);
    } catch (e, st) {
      debugPrint('[LlmProviderEditor] _save: error — $e\n$st');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Provider' : 'New Provider'),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _save,
            child: _isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
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
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _baseUrlCtrl,
              decoration: const InputDecoration(
                labelText: 'Base URL',
                border: OutlineInputBorder(),
                hintText: 'https://api.openai.com/v1',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _apiKeyCtrl,
              decoration: const InputDecoration(
                labelText: 'API Key',
                border: OutlineInputBorder(),
                hintText: 'sk-...',
              ),
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _baseUrlCtrl.dispose();
    _apiKeyCtrl.dispose();
    super.dispose();
  }
}
