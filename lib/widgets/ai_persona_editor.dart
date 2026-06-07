import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';

import 'package:persistence_drift/ai/ai_database.dart';
import '../ports/expertise_catalog_port.dart';
import 'provider_selection_sheet.dart';

class AiPersonaEditor extends StatefulWidget {
  final AiDatabase? db;
  final ExpertiseCatalogPort? expertiseCatalog;
  final AiPersona? persona;

  const AiPersonaEditor({super.key, this.db, this.expertiseCatalog, this.persona});

  @override
  State<AiPersonaEditor> createState() => _AiPersonaEditorState();
}

class _AiPersonaEditorState extends State<AiPersonaEditor> {
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
  List<ExpertiseDivinationType> _divinationTypes = [];
  List<ExpertiseSubDivinationType> _subDivinationTypes = [];
  List<ExpertiseSkill> _skills = [];
  List<ExpertiseSkillClass> _skillClasses = [];

  // Expertise selections: null = "全部" (all), Set = specific selections
  Set<String>? _selectedDivTypeUuids;
  Set<String>? _selectedSubDivTypeUuids;
  Set<int>? _selectedSkillIds;
  Set<String>? _selectedSkillClassUuids;

  static const _createNewSentinel = '__create_new__';

  bool get _isEditing => widget.persona != null;

  AiDatabase get _db => widget.db ?? context.read<AiDatabase>();
  ExpertiseCatalogPort? get _expertiseCatalog => widget.expertiseCatalog;

  @override
  void initState() {
    super.initState();
    final p = widget.persona;
    _nameCtrl = TextEditingController(text: p?.name ?? '');
    _descCtrl = TextEditingController(text: p?.description ?? '');
    _tempCtrl = TextEditingController(text: (p?.temperature ?? 0.7).toString());
    _topPCtrl = TextEditingController(text: (p?.topP ?? 1.0).toString());
    _maxTokensCtrl = TextEditingController(
      text: (p?.maxTokens ?? 2048).toString(),
    );
    _promptContentCtrl = TextEditingController();
    _promptNameCtrl = TextEditingController();
    _selectedModelUuid = p?.modelUuid;
    _selectedPromptUuid = p?.systemPromptUuid;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDropdowns();
    });
  }

  Future<void> _loadDropdowns() async {
    final db = _db;
    final providers = await db.llmProvidersDao.getAllEnabled();
    final prompts = await db.promptTemplatesDao.getSystemPrompts();

    // Resolve initial provider
    String? providerUuid;
    if (_isEditing && _selectedModelUuid != null) {
      final model = await db.llmModelsDao.getByUuid(_selectedModelUuid!);
      providerUuid = model?.providerUuid;
    }
    providerUuid ??= (await db.llmProvidersDao.getDefault())?.uuid;
    providerUuid ??= providers.isNotEmpty ? providers.first.uuid : null;

    // Load models for the resolved provider
    final models = providerUuid != null
        ? await db.llmModelsDao.getByProvider(providerUuid)
        : <LlmModel>[];

    // Load selected prompt content
    if (_selectedPromptUuid != null) {
      final prompt = await db.promptTemplatesDao.getByUuid(
        _selectedPromptUuid!,
      );
      if (prompt != null) {
        _promptContentCtrl.text = prompt.content;
      }
    }

    // Load expertise categories from port (or empty if unavailable)
    final port = _expertiseCatalog;
    final List<ExpertiseDivinationType> divinationTypes;
    final List<ExpertiseSubDivinationType> subDivinationTypes;
    final List<ExpertiseSkill> skills;
    final List<ExpertiseSkillClass> skillClasses;
    if (port != null) {
      divinationTypes = await port.getDivinationTypes();
      subDivinationTypes = await port.getSubDivinationTypes();
      skills = await port.getSkills();
      skillClasses = await port.getSkillClasses();
    } else {
      divinationTypes = [];
      subDivinationTypes = [];
      skills = [];
      skillClasses = [];
    }

    // Parse existing expertiseJson if editing
    if (_isEditing && widget.persona?.expertiseJson != null) {
      final map =
          jsonDecode(widget.persona!.expertiseJson!) as Map<String, dynamic>;
      _selectedDivTypeUuids = _parseStringSet(map['divinationTypeUuids']);
      _selectedSubDivTypeUuids = _parseStringSet(map['subDivinationTypeUuids']);
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

  /// Parse a JSON value into a `Set<String>`. Returns null if the value is null
  /// (meaning "全部").
  Set<String>? _parseStringSet(dynamic value) {
    if (value == null) return null;
    if (value is List) return value.cast<String>().toSet();
    return null;
  }

  /// Parse a JSON value into a `Set<int>`. Returns null if the value is null
  /// (meaning "全部").
  Set<int>? _parseIntSet(dynamic value) {
    if (value == null) return null;
    if (value is List) return value.map((e) => e as int).toSet();
    return null;
  }

  Future<void> _onProviderSelection() async {
    final selectedProvider = await showModalBottomSheet<LlmProvider>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) => ProviderSelectionSheet(
        initialProviders: _providers,
        selectedUuid: _selectedProviderUuid,
        aiDatabase: _db,
        onRefresh: () => _db.llmProvidersDao.getAllEnabled(),
      ),
    );

    if (selectedProvider != null && mounted) {
      // Refresh providers list and select the chosen one
      final providers = await _db.llmProvidersDao.getAllEnabled();
      final models = await _db.llmModelsDao.getByProvider(
        selectedProvider.uuid,
      );
      if (mounted) {
        setState(() {
          _providers = providers;
          _selectedProviderUuid = selectedProvider.uuid;
          _models = models;
          _selectedModelUuid = models.isNotEmpty ? models.first.uuid : null;
        });
      }
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
    // Note: null is no longer allowed since we removed the "None" option
    _isCreatingNewPrompt = false;
    final prompt = await _db.promptTemplatesDao.getByUuid(value!);
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
      await _db.promptTemplatesDao.updateContent(_selectedPromptUuid!, content);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Prompt 已更新')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('请输入 Prompt 名称')));
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
      await _db.promptTemplatesDao.insertTemplate(
        PromptTemplatesCompanion.insert(
          uuid: newUuid,
          name: name,
          templateType: 'system',
          content: content,
          createdAt: DateTime.now(),
        ),
      );
      // Refresh prompt list and auto-select the new one
      final prompts = await _db.promptTemplatesDao.getSystemPrompts();
      if (mounted) {
        setState(() {
          _prompts = prompts;
          _selectedPromptUuid = newUuid;
          _isCreatingNewPrompt = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('已保存新 Prompt: $name')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSavingPrompt = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedModelUuid == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a model')));
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

    final personaUuid = widget.persona?.uuid ?? const Uuid().v4();

    try {
      if (_isEditing) {
        await _db.aiPersonasDao.updatePersona(
          widget.persona!.uuid,
          AiPersonasCompanion(
            name: Value(_nameCtrl.text.trim()),
            description: Value(
              _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
            ),
            modelUuid: Value(_selectedModelUuid!),
            systemPromptUuid: Value(_selectedPromptUuid),
            temperature: Value(double.tryParse(_tempCtrl.text) ?? 0.7),
            topP: Value(double.tryParse(_topPCtrl.text) ?? 1.0),
            maxTokens: Value(int.tryParse(_maxTokensCtrl.text) ?? 2048),
            expertiseJson: Value(expertiseJson),
          ),
        );
      } else {
        await _db.aiPersonasDao.insertPersona(
          AiPersonasCompanion.insert(
            uuid: personaUuid,
            name: _nameCtrl.text.trim(),
            description: Value(
              _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
            ),
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
      if (mounted) Navigator.pop(context, personaUuid);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
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
  List<ExpertiseSkillClass> get _filteredSkillClasses {
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
            // --- Name ---
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

            // --- Description ---
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // --- Provider & Model ---
            Text(
              'Provider & Model',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            // Provider selection button (opens bottom sheet)
            InkWell(
              onTap: _onProviderSelection,
              borderRadius: BorderRadius.circular(4),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Provider',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
                child: Text(
                  _selectedProviderUuid != null
                      ? _providers
                            .firstWhere(
                              (p) => p.uuid == _selectedProviderUuid,
                              orElse: () => _providers.first,
                            )
                            .name
                      : 'Select Provider',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              key: ValueKey(
                'model_${_selectedProviderUuid}_$_selectedModelUuid',
              ),
              initialValue: _models.any((m) => m.uuid == _selectedModelUuid)
                  ? _selectedModelUuid
                  : null,
              decoration: const InputDecoration(
                labelText: 'Model',
                border: OutlineInputBorder(),
              ),
              items: _models
                  .map(
                    (m) => DropdownMenuItem(
                      value: m.uuid,
                      child: Text(m.displayName),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _selectedModelUuid = v),
              validator: (v) => v == null ? 'Required' : null,
            ),
            const SizedBox(height: 24),

            // --- System Prompt ---
            Text(
              'System Prompt',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey('prompt_$_promptDropdownValue'),
              initialValue: _safePromptDropdownValue,
              decoration: const InputDecoration(
                labelText: 'System Prompt',
                border: OutlineInputBorder(),
              ),
              items: [
                ..._prompts.map(
                  (p) => DropdownMenuItem(value: p.uuid, child: Text(p.name)),
                ),
                const DropdownMenuItem<String>(
                  value: _createNewSentinel,
                  child: Text('Create New...'),
                ),
              ],
              onChanged: _onPromptChanged,
              validator: (v) =>
                  (v == null || v == _createNewSentinel) ? 'Required' : null,
            ),
            if (_isCreatingNewPrompt) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _promptNameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Prompt Name',
                  border: OutlineInputBorder(),
                ),
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
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('更新'),
                    ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _isSavingPrompt ? null : _saveNewPrompt,
                    child: _isSavingPrompt
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('保存'),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),

            // --- Expertise Scope (专业范围) ---
            Text(
              '专业范围 (Expertise Scope)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _buildStringMultiSelectSection(
              title: '占测类型 (Divination Types)',
              items: _divinationTypes,
              labelOf: (t) => t.name,
              idOf: (t) => t.uuid,
              selectedIds: _selectedDivTypeUuids,
              onChanged: (v) => setState(() => _selectedDivTypeUuids = v),
            ),
            const SizedBox(height: 12),
            _buildStringMultiSelectSection(
              title: '子类型 (Sub-Divination Types)',
              items: _subDivinationTypes,
              labelOf: (t) => t.name,
              idOf: (t) => t.uuid,
              selectedIds: _selectedSubDivTypeUuids,
              onChanged: (v) => setState(() => _selectedSubDivTypeUuids = v),
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
                    final pruned = _selectedSkillClassUuids!.intersection(
                      allowedClassUuids,
                    );
                    _selectedSkillClassUuids = pruned.isEmpty ? null : pruned;
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
              onChanged: (v) => setState(() => _selectedSkillClassUuids = v),
            ),
            const SizedBox(height: 24),

            // --- Parameters ---
            Text('Parameters', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _tempCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Temperature',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _topPCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Top P',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _maxTokensCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Max Tokens',
                      border: OutlineInputBorder(),
                    ),
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
