import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';
import 'package:ai_core/ai_core.dart';
import 'package:common/database/app_database.dart' as common_db;
import 'package:common/datamodel/divination_type_data_model.dart';
import 'package:common/datamodel/sub_divination_type_data_model.dart';

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
    final appDb = context.read<common_db.AppDatabase>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            _PersonaEditorPage(db: db, appDb: appDb, persona: persona),
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
  final common_db.AppDatabase appDb;
  final AiPersona? persona;

  const _PersonaEditorPage({
    required this.db,
    required this.appDb,
    this.persona,
  });

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
  late final TextEditingController _promptContentCtrl;
  late final TextEditingController _promptNameCtrl;

  List<LlmProvider> _providers = [];
  List<LlmModel> _models = [];
  List<PromptTemplate> _prompts = [];
  String? _selectedProviderUuid;
  String? _selectedModelUuid;
  String? _selectedPromptUuid;
  bool _isCreatingNewPrompt = false;
  bool _isSaving = false;
  bool _isSavingPrompt = false;

  // Expertise category options (loaded from AppDatabase)
  List<DivinationTypeDataModel> _divinationTypes = [];
  List<SubDivinationTypeDataModel> _subDivinationTypes = [];
  List<common_db.Skill> _skills = [];
  List<common_db.SkillClass> _skillClasses = [];

  // Expertise selections: null = "全部" (all), Set = specific selections
  Set<String>? _selectedDivTypeUuids;
  Set<String>? _selectedSubDivTypeUuids;
  Set<int>? _selectedSkillIds;
  Set<String>? _selectedSkillClassUuids;

  static const _createNewSentinel = '__create_new__';

  bool get _isEditing => widget.persona != null;

  @override
  void initState() {
    super.initState();
    final p = widget.persona;
    _nameCtrl = TextEditingController(text: p?.name ?? '');
    _descCtrl = TextEditingController(text: p?.description ?? '');
    _tempCtrl =
        TextEditingController(text: (p?.temperature ?? 0.7).toString());
    _topPCtrl = TextEditingController(text: (p?.topP ?? 1.0).toString());
    _maxTokensCtrl =
        TextEditingController(text: (p?.maxTokens ?? 2048).toString());
    _promptContentCtrl = TextEditingController();
    _promptNameCtrl = TextEditingController();
    _selectedModelUuid = p?.modelUuid;
    _selectedPromptUuid = p?.systemPromptUuid;
    _loadDropdowns();
  }

  Future<void> _loadDropdowns() async {
    final providers = await widget.db.llmProvidersDao.getAllEnabled();
    final prompts = await widget.db.promptTemplatesDao.getSystemPrompts();

    // Resolve initial provider
    String? providerUuid;
    if (_isEditing && _selectedModelUuid != null) {
      final model =
          await widget.db.llmModelsDao.getByUuid(_selectedModelUuid!);
      providerUuid = model?.providerUuid;
    }
    providerUuid ??= (await widget.db.llmProvidersDao.getDefault())?.uuid;
    providerUuid ??= providers.isNotEmpty ? providers.first.uuid : null;

    // Load models for the resolved provider
    final models = providerUuid != null
        ? await widget.db.llmModelsDao.getByProvider(providerUuid)
        : <LlmModel>[];

    // Load selected prompt content
    if (_selectedPromptUuid != null) {
      final prompt =
          await widget.db.promptTemplatesDao.getByUuid(_selectedPromptUuid!);
      if (prompt != null) {
        _promptContentCtrl.text = prompt.content;
      }
    }

    // Load expertise categories from AppDatabase
    final appDb = widget.appDb;
    final divinationTypes =
        await appDb.divinationTypesDao.getAllDivinationTypes();
    final subDivinationTypes = await (appDb.select(appDb.subDivinationTypes)
          ..where((t) => t.deletedAt.isNull()))
        .get();
    final skills = await appDb.skillsDao.getAllSkills();
    final skillClasses = await appDb.skillClassesDao.getAllSkillClasses();

    // Parse existing expertiseJson if editing
    if (_isEditing && widget.persona?.expertiseJson != null) {
      final map =
          jsonDecode(widget.persona!.expertiseJson!) as Map<String, dynamic>;
      _selectedDivTypeUuids = _parseStringSet(map['divinationTypeUuids']);
      _selectedSubDivTypeUuids =
          _parseStringSet(map['subDivinationTypeUuids']);
      _selectedSkillIds = _parseIntSet(map['skillIds']);
      _selectedSkillClassUuids = _parseStringSet(map['skillClassUuids']);
    }

    if (mounted) {
      setState(() {
        _providers = providers;
        _selectedProviderUuid = providerUuid;
        _models = models;
        _prompts = prompts;
        _divinationTypes = divinationTypes;
        _subDivinationTypes = subDivinationTypes;
        _skills = skills;
        _skillClasses = skillClasses;
        if (_selectedModelUuid == null && models.isNotEmpty) {
          _selectedModelUuid = models.first.uuid;
        }
      });
    }
  }

  /// Parse a JSON value into a Set<String>. Returns null if the value is null
  /// (meaning "全部").
  Set<String>? _parseStringSet(dynamic value) {
    if (value == null) return null;
    if (value is List) return value.cast<String>().toSet();
    return null;
  }

  /// Parse a JSON value into a Set<int>. Returns null if the value is null
  /// (meaning "全部").
  Set<int>? _parseIntSet(dynamic value) {
    if (value == null) return null;
    if (value is List) return value.map((e) => e as int).toSet();
    return null;
  }

  Future<void> _onProviderChanged(String? providerUuid) async {
    if (providerUuid == null || providerUuid == _selectedProviderUuid) return;
    final models = await widget.db.llmModelsDao.getByProvider(providerUuid);
    if (mounted) {
      setState(() {
        _selectedProviderUuid = providerUuid;
        _models = models;
        _selectedModelUuid = models.isNotEmpty ? models.first.uuid : null;
      });
    }
  }

  Future<void> _onPromptChanged(String? value) async {
    if (value == _createNewSentinel) {
      setState(() {
        _isCreatingNewPrompt = true;
        _selectedPromptUuid = null;
        _promptContentCtrl.clear();
        _promptNameCtrl.clear();
      });
      return;
    }
    _isCreatingNewPrompt = false;
    if (value == null) {
      setState(() {
        _selectedPromptUuid = null;
        _promptContentCtrl.clear();
      });
      return;
    }
    final prompt = await widget.db.promptTemplatesDao.getByUuid(value);
    if (mounted) {
      setState(() {
        _selectedPromptUuid = value;
        _promptContentCtrl.text = prompt?.content ?? '';
      });
    }
  }

  Future<void> _updatePrompt() async {
    if (_selectedPromptUuid == null) return;
    final content = _promptContentCtrl.text.trim();
    if (content.isEmpty) return;
    setState(() => _isSavingPrompt = true);
    try {
      await widget.db.promptTemplatesDao
          .updateContent(_selectedPromptUuid!, content);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Prompt 已更新')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSavingPrompt = false);
    }
  }

  Future<void> _saveNewPrompt() async {
    final content = _promptContentCtrl.text.trim();
    if (content.isEmpty) return;

    String name;
    if (_isCreatingNewPrompt) {
      name = _promptNameCtrl.text.trim();
      if (name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('请输入 Prompt 名称')),
        );
        return;
      }
    } else {
      // Saving a copy of an existing prompt
      final existing = _prompts
          .where((p) => p.uuid == _selectedPromptUuid)
          .firstOrNull;
      name = '${existing?.name ?? 'Prompt'}(副本)';
    }

    setState(() => _isSavingPrompt = true);
    try {
      final newUuid = const Uuid().v4();
      await widget.db.promptTemplatesDao.insertTemplate(
        PromptTemplatesCompanion.insert(
          uuid: newUuid,
          name: name,
          templateType: 'system',
          content: content,
          createdAt: DateTime.now(),
        ),
      );
      // Refresh prompt list and auto-select the new one
      final prompts = await widget.db.promptTemplatesDao.getSystemPrompts();
      if (mounted) {
        setState(() {
          _prompts = prompts;
          _selectedPromptUuid = newUuid;
          _isCreatingNewPrompt = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('已保存新 Prompt: $name')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSavingPrompt = false);
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

    final expertiseMap = <String, dynamic>{
      'divinationTypeUuids': _selectedDivTypeUuids?.toList(),
      'subDivinationTypeUuids': _selectedSubDivTypeUuids?.toList(),
      'skillIds': _selectedSkillIds?.toList(),
      'skillClassUuids': _selectedSkillClassUuids?.toList(),
    };
    final expertiseJson = jsonEncode(expertiseMap);

    try {
      if (_isEditing) {
        await widget.db.aiPersonasDao.updatePersona(
          widget.persona!.uuid,
          AiPersonasCompanion(
            name: Value(_nameCtrl.text.trim()),
            description: Value(
                _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim()),
            modelUuid: Value(_selectedModelUuid!),
            systemPromptUuid: Value(_selectedPromptUuid),
            temperature: Value(double.tryParse(_tempCtrl.text) ?? 0.7),
            topP: Value(double.tryParse(_topPCtrl.text) ?? 1.0),
            maxTokens: Value(int.tryParse(_maxTokensCtrl.text) ?? 2048),
            expertiseJson: Value(expertiseJson),
          ),
        );
      } else {
        await widget.db.aiPersonasDao.insertPersona(
          AiPersonasCompanion.insert(
            uuid: const Uuid().v4(),
            name: _nameCtrl.text.trim(),
            description: Value(
                _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim()),
            modelUuid: _selectedModelUuid!,
            systemPromptUuid: Value(_selectedPromptUuid),
            temperature: Value(double.tryParse(_tempCtrl.text) ?? 0.7),
            topP: Value(double.tryParse(_topPCtrl.text) ?? 1.0),
            maxTokens: Value(int.tryParse(_maxTokensCtrl.text) ?? 2048),
            expertiseJson: Value(expertiseJson),
            createdAt: DateTime.now(),
          ),
        );
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  /// The dropdown value for the prompt selector.
  /// Maps internal state to the dropdown's value space.
  String? get _promptDropdownValue {
    if (_isCreatingNewPrompt) return _createNewSentinel;
    return _selectedPromptUuid;
  }

  /// Safe version that only returns a value if it exists in the items list.
  /// Prevents assertion errors when items haven't loaded yet.
  String? get _safePromptDropdownValue {
    final v = _promptDropdownValue;
    if (v == null) return null; // null = "None" item, always present
    if (v == _createNewSentinel) return v; // always present
    if (_prompts.any((p) => p.uuid == v)) return v;
    return null; // not yet loaded
  }

  /// Whether to show the inline prompt content editor.
  bool get _showPromptEditor =>
      _isCreatingNewPrompt || _selectedPromptUuid != null;

  /// Skill classes filtered by the current skill selection.
  /// When skills = "全部" (null), show all classes.
  /// When specific skills are selected, only show classes belonging to them.
  List<common_db.SkillClass> get _filteredSkillClasses {
    if (_selectedSkillIds == null) return _skillClasses;
    return _skillClasses
        .where((sc) => _selectedSkillIds!.contains(sc.skillId))
        .toList();
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
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // --- Name ---
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),

            // --- Description ---
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(
                  labelText: 'Description', border: OutlineInputBorder()),
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // --- Provider & Model ---
            Text('Provider & Model',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey('provider_$_selectedProviderUuid'),
              initialValue: _providers.any((p) => p.uuid == _selectedProviderUuid)
                  ? _selectedProviderUuid
                  : null,
              decoration: const InputDecoration(
                  labelText: 'Provider', border: OutlineInputBorder()),
              items: _providers
                  .map((p) => DropdownMenuItem(value: p.uuid, child: Text(p.name)))
                  .toList(),
              onChanged: _onProviderChanged,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              key: ValueKey('model_${_selectedProviderUuid}_$_selectedModelUuid'),
              initialValue: _models.any((m) => m.uuid == _selectedModelUuid)
                  ? _selectedModelUuid
                  : null,
              decoration: const InputDecoration(
                  labelText: 'Model', border: OutlineInputBorder()),
              items: _models
                  .map((m) =>
                      DropdownMenuItem(value: m.uuid, child: Text(m.displayName)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedModelUuid = v),
              validator: (v) => v == null ? 'Required' : null,
            ),
            const SizedBox(height: 24),

            // --- System Prompt ---
            Text('System Prompt',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey('prompt_$_promptDropdownValue'),
              initialValue: _safePromptDropdownValue,
              decoration: const InputDecoration(
                  labelText: 'System Prompt (optional)',
                  border: OutlineInputBorder()),
              items: [
                const DropdownMenuItem<String>(
                    value: null, child: Text('None')),
                ..._prompts.map((p) =>
                    DropdownMenuItem(value: p.uuid, child: Text(p.name))),
                const DropdownMenuItem<String>(
                    value: _createNewSentinel,
                    child: Text('Create New...')),
              ],
              onChanged: _onPromptChanged,
            ),
            if (_isCreatingNewPrompt) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _promptNameCtrl,
                decoration: const InputDecoration(
                    labelText: 'Prompt Name', border: OutlineInputBorder()),
              ),
            ],
            if (_showPromptEditor) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _promptContentCtrl,
                decoration: const InputDecoration(
                  labelText: 'Prompt Content',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 8,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!_isCreatingNewPrompt && _selectedPromptUuid != null)
                    OutlinedButton(
                      onPressed: _isSavingPrompt ? null : _updatePrompt,
                      child: _isSavingPrompt
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2))
                          : const Text('更新'),
                    ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _isSavingPrompt ? null : _saveNewPrompt,
                    child: _isSavingPrompt
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child:
                                CircularProgressIndicator(strokeWidth: 2))
                        : const Text('保存'),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),

            // --- Expertise Scope (专业范围) ---
            Text('专业范围 (Expertise Scope)',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _buildStringMultiSelectSection(
              title: '占测类型 (Divination Types)',
              items: _divinationTypes,
              labelOf: (t) => t.name,
              idOf: (t) => t.uuid,
              selectedIds: _selectedDivTypeUuids,
              onChanged: (v) =>
                  setState(() => _selectedDivTypeUuids = v),
            ),
            const SizedBox(height: 12),
            _buildStringMultiSelectSection(
              title: '子类型 (Sub-Divination Types)',
              items: _subDivinationTypes,
              labelOf: (t) => t.name,
              idOf: (t) => t.uuid,
              selectedIds: _selectedSubDivTypeUuids,
              onChanged: (v) =>
                  setState(() => _selectedSubDivTypeUuids = v),
            ),
            const SizedBox(height: 12),
            _buildIntMultiSelectSection(
              title: '技能 (Skills)',
              items: _skills,
              labelOf: (s) => s.name,
              idOf: (s) => s.id,
              selectedIds: _selectedSkillIds,
              onChanged: (v) {
                setState(() {
                  _selectedSkillIds = v;
                  // Cascade: remove skill class selections whose parent
                  // skill is no longer selected
                  if (v != null && _selectedSkillClassUuids != null) {
                    final allowedClassUuids = _skillClasses
                        .where((sc) => v.contains(sc.skillId))
                        .map((sc) => sc.uuid)
                        .toSet();
                    final pruned = _selectedSkillClassUuids!
                        .intersection(allowedClassUuids);
                    _selectedSkillClassUuids =
                        pruned.isEmpty ? null : pruned;
                  }
                });
              },
            ),
            const SizedBox(height: 12),
            _buildStringMultiSelectSection(
              title: '技能分类 (Skill Classes)',
              items: _filteredSkillClasses,
              labelOf: (sc) => sc.name,
              idOf: (sc) => sc.uuid,
              selectedIds: _selectedSkillClassUuids,
              onChanged: (v) =>
                  setState(() => _selectedSkillClassUuids = v),
            ),
            const SizedBox(height: 24),

            // --- Parameters ---
            Text('Parameters',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _tempCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Temperature',
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _topPCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Top P', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _maxTokensCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Max Tokens',
                        border: OutlineInputBorder()),
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

  /// Builds a multi-select FilterChip section for items with String IDs.
  /// When [selectedIds] is null, "全部" (All) is selected.
  Widget _buildStringMultiSelectSection<T>({
    required String title,
    required List<T> items,
    required String Function(T) labelOf,
    required String Function(T) idOf,
    required Set<String>? selectedIds,
    required ValueChanged<Set<String>?> onChanged,
  }) {
    final isAll = selectedIds == null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            FilterChip(
              label: const Text('全部'),
              selected: isAll,
              onSelected: (_) => onChanged(null),
            ),
            ...items.map((item) {
              final id = idOf(item);
              final selected = !isAll && selectedIds.contains(id);
              return FilterChip(
                label: Text(labelOf(item)),
                selected: selected,
                onSelected: (checked) {
                  if (isAll) {
                    // Switching from "全部" to a single selection
                    onChanged({id});
                  } else {
                    final updated = Set<String>.from(selectedIds);
                    if (checked) {
                      updated.add(id);
                      // If all items selected, auto-switch to "全部"
                      if (updated.length == items.length) {
                        onChanged(null);
                        return;
                      }
                    } else {
                      updated.remove(id);
                      // If nothing left, fall back to "全部"
                      if (updated.isEmpty) {
                        onChanged(null);
                        return;
                      }
                    }
                    onChanged(updated);
                  }
                },
              );
            }),
          ],
        ),
      ],
    );
  }

  /// Builds a multi-select FilterChip section for items with int IDs (Skills).
  /// When [selectedIds] is null, "全部" (All) is selected.
  Widget _buildIntMultiSelectSection<T>({
    required String title,
    required List<T> items,
    required String Function(T) labelOf,
    required int Function(T) idOf,
    required Set<int>? selectedIds,
    required ValueChanged<Set<int>?> onChanged,
  }) {
    final isAll = selectedIds == null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            FilterChip(
              label: const Text('全部'),
              selected: isAll,
              onSelected: (_) => onChanged(null),
            ),
            ...items.map((item) {
              final id = idOf(item);
              final selected = !isAll && selectedIds.contains(id);
              return FilterChip(
                label: Text(labelOf(item)),
                selected: selected,
                onSelected: (checked) {
                  if (isAll) {
                    onChanged({id});
                  } else {
                    final updated = Set<int>.from(selectedIds);
                    if (checked) {
                      updated.add(id);
                      if (updated.length == items.length) {
                        onChanged(null);
                        return;
                      }
                    } else {
                      updated.remove(id);
                      if (updated.isEmpty) {
                        onChanged(null);
                        return;
                      }
                    }
                    onChanged(updated);
                  }
                },
              );
            }),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _tempCtrl.dispose();
    _topPCtrl.dispose();
    _maxTokensCtrl.dispose();
    _promptContentCtrl.dispose();
    _promptNameCtrl.dispose();
    super.dispose();
  }
}
