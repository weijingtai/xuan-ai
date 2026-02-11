import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';

import '../database/ai_database.dart';
import 'provider_selection_sheet.dart';

/// 对话框：实时修改聊天配置（Provider, Model, Prompt）。
///
/// 返回 String?：
/// - null: 取消
/// - uuid: 保存/另存为后的 Persona UUID
class AiChatSettingsDialog extends StatefulWidget {
  final AiDatabase db;
  final String personaUuid;

  const AiChatSettingsDialog({
    super.key,
    required this.db,
    required this.personaUuid,
  });

  @override
  State<AiChatSettingsDialog> createState() => _AiChatSettingsDialogState();
}

class _AiChatSettingsDialogState extends State<AiChatSettingsDialog> {
  final _formKey = GlobalKey<FormState>();

  // State
  bool _isLoading = true;
  AiPersona? _originalPersona;

  // Form Controllers
  late final TextEditingController _nameCtrl; // For Save As
  late final TextEditingController _promptContentCtrl;
  late final TextEditingController _promptNameCtrl; // For new prompt creation

  // Configuration
  List<LlmProvider> _providers = [];
  List<LlmModel> _models = [];
  List<PromptTemplate> _prompts = [];

  String? _selectedProviderUuid;
  String? _selectedModelUuid;
  String? _selectedPromptUuid;

  bool _isCreatingNewPrompt = false;
  static const _createNewSentinel = '__create_new__';

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _promptContentCtrl = TextEditingController();
    _promptNameCtrl = TextEditingController();
    _loadData();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _promptContentCtrl.dispose();
    _promptNameCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final persona = await widget.db.aiPersonasDao.getByUuid(
        widget.personaUuid,
      );
      if (persona == null) {
        if (mounted) Navigator.pop(context); // Should not happen
        return;
      }

      final providers = await widget.db.llmProvidersDao.getAllEnabled();
      final prompts = await widget.db.promptTemplatesDao.getSystemPrompts();

      // Load Model to find Provider
      LlmModel? currentModel;
      if (persona.modelUuid.isNotEmpty) {
        currentModel = await widget.db.llmModelsDao.getByUuid(
          persona.modelUuid,
        );
      }

      // Determine initial selection
      final initialProviderUuid =
          currentModel?.providerUuid ??
          (providers.isNotEmpty ? providers.first.uuid : null);

      // Load models for selected provider
      final models = initialProviderUuid != null
          ? await widget.db.llmModelsDao.getByProvider(initialProviderUuid)
          : <LlmModel>[];

      // Load Prompt Content
      if (persona.systemPromptUuid != null) {
        final prompt = await widget.db.promptTemplatesDao.getByUuid(
          persona.systemPromptUuid!,
        );
        _promptContentCtrl.text = prompt?.content ?? '';
      }

      if (mounted) {
        setState(() {
          _originalPersona = persona;
          _nameCtrl.text = persona.name; // Default name for Save As
          _providers = providers;
          _prompts = prompts;
          _models = models;

          _selectedProviderUuid = initialProviderUuid;
          _selectedModelUuid = persona.modelUuid;
          _selectedPromptUuid = persona.systemPromptUuid;

          // Ensure valid model selection
          if (_selectedModelUuid == null && models.isNotEmpty) {
            _selectedModelUuid = models.first.uuid;
          }

          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
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
        aiDatabase: widget.db,
        onRefresh: () => widget.db.llmProvidersDao.getAllEnabled(),
      ),
    );

    if (selectedProvider != null && mounted) {
      final models = await widget.db.llmModelsDao.getByProvider(
        selectedProvider.uuid,
      );
      if (mounted) {
        setState(() {
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

    _isCreatingNewPrompt = false;
    if (value != null) {
      final prompt = await widget.db.promptTemplatesDao.getByUuid(value);
      if (mounted) {
        setState(() {
          _selectedPromptUuid = value;
          _promptContentCtrl.text = prompt?.content ?? '';
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _selectedPromptUuid = null;
          _promptContentCtrl.clear();
        });
      }
    }
  }

  Future<String?> _savePromptIfNeeded() async {
    final content = _promptContentCtrl.text.trim();
    if (content.isEmpty) return null;

    // 1. Updating existing prompt
    if (!_isCreatingNewPrompt && _selectedPromptUuid != null) {
      await widget.db.promptTemplatesDao.updateContent(
        _selectedPromptUuid!,
        content,
      );
      return _selectedPromptUuid;
    }

    // 2. Creating new prompt (explicitly or implicitly)
    String name = _promptNameCtrl.text.trim();
    if (name.isEmpty) {
      // If no name provided for new prompt, generate one
      name = 'Chat Prompt ${DateTime.now().hour}:${DateTime.now().minute}';
    }

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
    return newUuid;
  }

  Future<void> _handleSave({required bool isSaveAs}) async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedModelUuid == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请选择模型')));
      return;
    }

    // Save prompt first
    final promptUuid = await _savePromptIfNeeded();

    if (!mounted) return;

    String targetUuid;

    if (isSaveAs) {
      // Prompt for new name
      final newName = await showDialog<String>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('另存为人设'),
          content: TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(labelText: '新名称'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, _nameCtrl.text.trim()),
              child: const Text('确定'),
            ),
          ],
        ),
      );

      if (newName == null || newName.isEmpty) return;
      if (!mounted) return;

      targetUuid = const Uuid().v4();
      await widget.db.aiPersonasDao.insertPersona(
        AiPersonasCompanion.insert(
          uuid: targetUuid,
          name: newName,
          description: Value(_originalPersona?.description),
          modelUuid: _selectedModelUuid!,
          systemPromptUuid: Value(promptUuid),
          temperature: Value(_originalPersona?.temperature ?? 0.7),
          topP: Value(_originalPersona?.topP ?? 1.0),
          maxTokens: Value(_originalPersona?.maxTokens ?? 2048),
          expertiseJson: Value(
            _originalPersona?.expertiseJson,
          ), // Clone expertise
          createdAt: DateTime.now(),
        ),
      );
    } else {
      // Update existing
      targetUuid = widget.personaUuid;
      await widget.db.aiPersonasDao.updatePersona(
        targetUuid,
        AiPersonasCompanion(
          modelUuid: Value(_selectedModelUuid!),
          systemPromptUuid: Value(promptUuid),
        ),
      );
    }

    if (mounted) {
      Navigator.pop(context, targetUuid);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return AlertDialog(
      title: const Text('配置'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('当前人设: ${_originalPersona?.name}', style: Theme.of(context).textTheme.bodySmall),
                // const SizedBox(height: 16),

                // Provider
                InkWell(
                  onTap: _onProviderSelection,
                  borderRadius: BorderRadius.circular(4),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Provider',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      isDense: true,
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
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Model
                InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Model',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      key: ValueKey(
                        'model_${_selectedProviderUuid}_$_selectedModelUuid',
                      ),
                      value: _models.any((m) => m.uuid == _selectedModelUuid)
                          ? _selectedModelUuid
                          : null,
                      isExpanded: true,
                      isDense: true,
                      items: _models
                          .map(
                            (m) => DropdownMenuItem(
                              value: m.uuid,
                              child: Text(
                                m.displayName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _selectedModelUuid = v),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // System Prompt Selection
                InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'System Prompt',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _isCreatingNewPrompt
                          ? _createNewSentinel
                          : _selectedPromptUuid,
                      isExpanded: true,
                      isDense: true,
                      items: [
                        const DropdownMenuItem<String>(
                          value: null,
                          child: Text('None'),
                        ),
                        ..._prompts.map(
                          (p) => DropdownMenuItem(
                            value: p.uuid,
                            child: Text(
                              p.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const DropdownMenuItem<String>(
                          value: _createNewSentinel,
                          child: Text('Create New...'),
                        ),
                      ],
                      onChanged: _onPromptChanged,
                    ),
                  ),
                ),

                // Prompt Content Editor
                if (_isCreatingNewPrompt || _selectedPromptUuid != null) ...[
                  const SizedBox(height: 8),
                  if (_isCreatingNewPrompt)
                    TextFormField(
                      controller: _promptNameCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Prompt Name',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _promptContentCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Content',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    minLines: 3,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () => _handleSave(isSaveAs: true),
          child: const Text('另存为...'),
        ),
        FilledButton(
          onPressed: () => _handleSave(isSaveAs: false),
          child: const Text('保存'),
        ),
      ],
    );
  }
}
