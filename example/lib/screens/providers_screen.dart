import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';
import 'package:ai_core/ai_core.dart';

class ProvidersScreen extends StatefulWidget {
  const ProvidersScreen({super.key});

  @override
  State<ProvidersScreen> createState() => _ProvidersScreenState();
}

class _ProvidersScreenState extends State<ProvidersScreen> {
  List<LlmProvider> _providers = [];
  Map<String, List<LlmModel>> _modelsByProvider = {};
  final Set<String> _syncingProviders = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final db = context.read<AiDatabase>();
    final providers = await db.llmProvidersDao.getAllEnabled();
    final Map<String, List<LlmModel>> models = {};
    for (final p in providers) {
      models[p.uuid] = await db.llmModelsDao.getByProvider(p.uuid);
    }
    if (mounted) {
      setState(() {
        _providers = providers;
        _modelsByProvider = models;
        _isLoading = false;
      });
    }
  }

  Future<void> _syncModels(String providerUuid) async {
    debugPrint('[ProvidersScreen] _syncModels: starting for $providerUuid');
    setState(() => _syncingProviders.add(providerUuid));
    try {
      final llmService = context.read<LlmService>();
      final added = await llmService.syncModelsFromRemote(providerUuid);
      debugPrint('[ProvidersScreen] _syncModels: completed, $added new model(s)');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Synced $added new model(s)')),
        );
        _loadData();
      }
    } catch (e, st) {
      debugPrint('[ProvidersScreen] _syncModels: failed — $e\n$st');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sync failed: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _syncingProviders.remove(providerUuid));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LLM Providers & Models')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMenu(context),
        child: const Icon(Icons.add),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _providers.isEmpty
              ? const Center(child: Text('No providers. Tap + to add one.'))
              : ListView(
                  padding: const EdgeInsets.only(bottom: 80),
                  children: _providers.map((p) => _buildProviderSection(context, p)).toList(),
                ),
    );
  }

  void _showAddMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Text('Add Provider'),
              onTap: () {
                Navigator.pop(ctx);
                _openProviderEditor(context);
              },
            ),
            if (_providers.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.model_training),
                title: const Text('Add Model'),
                onTap: () {
                  Navigator.pop(ctx);
                  _openModelEditor(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderSection(BuildContext context, LlmProvider provider) {
    final models = _modelsByProvider[provider.uuid] ?? [];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        leading: const Icon(Icons.cloud),
        title: Text(provider.name),
        subtitle: Text(provider.baseUrl),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (provider.isDefault)
              Chip(
                label: const Text('Default'),
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              ),
            PopupMenuButton<String>(
              onSelected: (v) async {
                final db = context.read<AiDatabase>();
                if (v == 'edit') _openProviderEditor(context, provider: provider);
                if (v == 'default') {
                  await db.llmProvidersDao.setDefault(provider.uuid);
                  _loadData();
                }
                if (v == 'delete') {
                  await db.llmProvidersDao.softDelete(provider.uuid);
                  _loadData();
                }
              },
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                if (!provider.isDefault)
                  const PopupMenuItem(value: 'default', child: Text('Set Default')),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          ],
        ),
        children: [
          if (models.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No models for this provider.'),
            )
          else
            ...models.map((m) => _buildModelTile(context, m)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () => _openModelEditor(context, providerUuid: provider.uuid),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Model'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: _syncingProviders.contains(provider.uuid)
                      ? null
                      : () => _syncModels(provider.uuid),
                  icon: _syncingProviders.contains(provider.uuid)
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.sync, size: 18),
                  label: const Text('Sync Models'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModelTile(BuildContext context, LlmModel model) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: const Icon(Icons.model_training, size: 20),
      title: Text(model.displayName),
      subtitle: Text('${model.modelId} / ${model.modelType}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (model.supportsFunctionCalling)
            Tooltip(
              message: 'Supports function calling',
              child: Icon(Icons.build, size: 16, color: Theme.of(context).colorScheme.primary),
            ),
          if (model.isDefault)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Chip(label: Text('Default')),
            ),
          PopupMenuButton<String>(
            onSelected: (v) async {
              final db = context.read<AiDatabase>();
              if (v == 'edit') _openModelEditor(context, model: model);
              if (v == 'default') {
                await db.llmModelsDao.setDefault(model.uuid);
                _loadData();
              }
              if (v == 'delete') {
                await db.llmModelsDao.softDelete(model.uuid);
                _loadData();
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              if (!model.isDefault) const PopupMenuItem(value: 'default', child: Text('Set Default')),
              const PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _openProviderEditor(BuildContext context, {LlmProvider? provider}) async {
    final db = context.read<AiDatabase>();
    final llmService = context.read<LlmService>();
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _ProviderEditorPage(db: db, llmService: llmService, provider: provider)),
    );
    _loadData();
  }

  Future<void> _openModelEditor(BuildContext context,
      {LlmModel? model, String? providerUuid}) async {
    final db = context.read<AiDatabase>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _ModelEditorPage(
          db: db,
          model: model,
          providers: _providers,
          initialProviderUuid: providerUuid ?? model?.providerUuid,
        ),
      ),
    );
    _loadData();
  }
}

// --- Provider Editor ---

class _ProviderEditorPage extends StatefulWidget {
  final AiDatabase db;
  final LlmService llmService;
  final LlmProvider? provider;

  const _ProviderEditorPage({required this.db, required this.llmService, this.provider});

  @override
  State<_ProviderEditorPage> createState() => _ProviderEditorPageState();
}

class _ProviderEditorPageState extends State<_ProviderEditorPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _baseUrlCtrl;
  late final TextEditingController _apiKeyCtrl;
  bool _isSaving = false;

  bool get _isEditing => widget.provider != null;

  @override
  void initState() {
    super.initState();
    final p = widget.provider;
    _nameCtrl = TextEditingController(text: p?.name ?? '');
    _baseUrlCtrl = TextEditingController(text: p?.baseUrl ?? 'https://api.openai.com/v1');
    _apiKeyCtrl = TextEditingController(text: p?.encryptedApiKey ?? '');
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final isNew = !_isEditing;
    debugPrint('[ProviderEditor] _save: isNew=$isNew');
    try {
      final uuid = _isEditing ? widget.provider!.uuid : const Uuid().v4();
      debugPrint('[ProviderEditor] _save: upserting provider uuid=$uuid, '
          'name=${_nameCtrl.text.trim()}, baseUrl=${_baseUrlCtrl.text.trim()}');
      await widget.db.llmProvidersDao.upsert(
        LlmProvidersCompanion(
          uuid: Value(uuid),
          name: Value(_nameCtrl.text.trim()),
          baseUrl: Value(_baseUrlCtrl.text.trim()),
          encryptedApiKey: Value(_apiKeyCtrl.text.trim().isEmpty ? null : _apiKeyCtrl.text.trim()),
          createdAt: Value(_isEditing ? widget.provider!.createdAt : DateTime.now()),
          lastUpdatedAt: Value(DateTime.now()),
        ),
      );
      debugPrint('[ProviderEditor] _save: provider saved successfully');

      // Auto-sync models for new providers (best-effort).
      if (isNew) {
        debugPrint('[ProviderEditor] _save: auto-syncing models for '
            'new provider $uuid');
        try {
          final added = await widget.llmService.syncModelsFromRemote(uuid);
          debugPrint('[ProviderEditor] _save: auto-sync completed, '
              '$added model(s) added');
        } catch (e, st) {
          debugPrint('[ProviderEditor] _save: auto-sync failed (non-fatal) '
              '— $e\n$st');
        }
      }

      if (mounted) Navigator.pop(context);
    } catch (e, st) {
      debugPrint('[ProviderEditor] _save: error — $e\n$st');
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
        title: Text(_isEditing ? 'Edit Provider' : 'New Provider'),
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
              controller: _baseUrlCtrl,
              decoration: const InputDecoration(
                labelText: 'Base URL',
                border: OutlineInputBorder(),
                hintText: 'https://api.openai.com/v1',
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
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

// --- Model Editor ---

class _ModelEditorPage extends StatefulWidget {
  final AiDatabase db;
  final LlmModel? model;
  final List<LlmProvider> providers;
  final String? initialProviderUuid;

  const _ModelEditorPage({
    required this.db,
    this.model,
    required this.providers,
    this.initialProviderUuid,
  });

  @override
  State<_ModelEditorPage> createState() => _ModelEditorPageState();
}

class _ModelEditorPageState extends State<_ModelEditorPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _displayNameCtrl;
  late final TextEditingController _modelIdCtrl;
  late final TextEditingController _maxContextCtrl;
  late final TextEditingController _maxOutputCtrl;
  String? _providerUuid;
  String _modelType = 'chat';
  bool _supportsStreaming = true;
  bool _supportsFunctionCalling = false;
  bool _isSaving = false;

  bool get _isEditing => widget.model != null;

  @override
  void initState() {
    super.initState();
    final m = widget.model;
    _displayNameCtrl = TextEditingController(text: m?.displayName ?? '');
    _modelIdCtrl = TextEditingController(text: m?.modelId ?? '');
    _maxContextCtrl = TextEditingController(text: (m?.maxContextLength ?? 4096).toString());
    _maxOutputCtrl = TextEditingController(text: (m?.maxOutputTokens ?? 4096).toString());
    _providerUuid = widget.initialProviderUuid ?? m?.providerUuid;
    _modelType = m?.modelType ?? 'chat';
    _supportsStreaming = m?.supportsStreaming ?? true;
    _supportsFunctionCalling = m?.supportsFunctionCalling ?? false;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_providerUuid == null) return;
    setState(() => _isSaving = true);
    try {
      final uuid = _isEditing ? widget.model!.uuid : const Uuid().v4();
      await widget.db.llmModelsDao.upsert(
        LlmModelsCompanion(
          uuid: Value(uuid),
          providerUuid: Value(_providerUuid!),
          modelId: Value(_modelIdCtrl.text.trim()),
          displayName: Value(_displayNameCtrl.text.trim()),
          modelType: Value(_modelType),
          maxContextLength: Value(int.tryParse(_maxContextCtrl.text) ?? 4096),
          maxOutputTokens: Value(int.tryParse(_maxOutputCtrl.text) ?? 4096),
          supportsStreaming: Value(_supportsStreaming),
          supportsFunctionCalling: Value(_supportsFunctionCalling),
          createdAt: Value(_isEditing ? widget.model!.createdAt : DateTime.now()),
          lastUpdatedAt: Value(DateTime.now()),
        ),
      );
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
        title: Text(_isEditing ? 'Edit Model' : 'New Model'),
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
            DropdownButtonFormField<String>(
              initialValue: _providerUuid,
              decoration: const InputDecoration(labelText: 'Provider', border: OutlineInputBorder()),
              items: widget.providers
                  .map((p) => DropdownMenuItem(value: p.uuid, child: Text(p.name)))
                  .toList(),
              onChanged: _isEditing ? null : (v) => setState(() => _providerUuid = v),
              validator: (v) => v == null ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _displayNameCtrl,
              decoration: const InputDecoration(labelText: 'Display Name', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _modelIdCtrl,
              decoration: const InputDecoration(
                labelText: 'Model ID',
                border: OutlineInputBorder(),
                hintText: 'e.g. gpt-4, claude-3-opus',
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _modelType,
              decoration: const InputDecoration(labelText: 'Model Type', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'chat', child: Text('Chat')),
                DropdownMenuItem(value: 'completion', child: Text('Completion')),
                DropdownMenuItem(value: 'embedding', child: Text('Embedding')),
              ],
              onChanged: (v) => setState(() => _modelType = v ?? 'chat'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _maxContextCtrl,
                    decoration: const InputDecoration(labelText: 'Max Context', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _maxOutputCtrl,
                    decoration: const InputDecoration(labelText: 'Max Output', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Supports Streaming'),
              value: _supportsStreaming,
              onChanged: (v) => setState(() => _supportsStreaming = v),
            ),
            SwitchListTile(
              title: const Text('Supports Function Calling'),
              value: _supportsFunctionCalling,
              onChanged: (v) => setState(() => _supportsFunctionCalling = v),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _displayNameCtrl.dispose();
    _modelIdCtrl.dispose();
    _maxContextCtrl.dispose();
    _maxOutputCtrl.dispose();
    super.dispose();
  }
}
