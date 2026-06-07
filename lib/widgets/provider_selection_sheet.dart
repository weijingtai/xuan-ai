import 'package:flutter/material.dart';

import 'package:persistence_drift/ai/ai_database.dart';
import 'llm_provider_editor.dart';

/// Bottom sheet for selecting an LLM provider.
/// Displays a list of enabled providers with an "Add New Provider" option.
class ProviderSelectionSheet extends StatefulWidget {
  final List<LlmProvider> initialProviders;
  final String? selectedUuid;
  final AiDatabase? aiDatabase;
  final Future<List<LlmProvider>> Function() onRefresh;

  const ProviderSelectionSheet({
    super.key,
    required this.initialProviders,
    this.selectedUuid,
    this.aiDatabase,
    required this.onRefresh,
  });

  @override
  State<ProviderSelectionSheet> createState() => _ProviderSelectionSheetState();
}

class _ProviderSelectionSheetState extends State<ProviderSelectionSheet> {
  late List<LlmProvider> _providers;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _providers = widget.initialProviders;
  }

  Future<void> _handleRefresh() async {
    setState(() => _isLoading = true);
    try {
      final updated = await widget.onRefresh();
      if (mounted) {
        setState(() => _providers = updated);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleAdd() async {
    final providerUuid = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => LlmProviderEditor(db: widget.aiDatabase),
      ),
    );

    if (providerUuid != null) {
      if (!mounted) return;
      // Refresh list and select the new provider
      await _handleRefresh();
      if (mounted) {
        // Find the newly created provider and return it
        final newProvider = _providers.firstWhere(
          (p) => p.uuid == providerUuid,
          orElse: () => _providers.first,
        );
        Navigator.of(context).pop(newProvider);
      }
    }
  }

  Future<void> _handleEdit(LlmProvider provider) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            LlmProviderEditor(db: widget.aiDatabase, provider: provider),
      ),
    );

    // Refresh list after editing
    if (!mounted) return;
    await _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  'Select Provider',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Provider list
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _providers.length + 1, // +1 for "Add New" button
              itemBuilder: (context, index) {
                if (index == _providers.length) {
                  // "Add New Provider" button
                  return ListTile(
                    leading: const Icon(Icons.add_circle_outline),
                    title: const Text('Add New Provider'),
                    onTap: _handleAdd,
                  );
                }

                final provider = _providers[index];
                final isSelected = provider.uuid == widget.selectedUuid;

                return ListTile(
                  leading: Icon(
                    Icons.cloud,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  title: Text(provider.name),
                  subtitle: Text(provider.baseUrl),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected)
                        Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () => _handleEdit(provider),
                        tooltip: 'Edit Provider',
                      ),
                    ],
                  ),
                  selected: isSelected,
                  onTap: () => Navigator.of(context).pop(provider),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
