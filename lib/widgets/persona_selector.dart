import 'package:flutter/material.dart';

import '../database/ai_database.dart';

/// Persona selector widget
class PersonaSelector extends StatelessWidget {
  final List<AiPersona> personas;
  final String? selectedUuid;
  final ValueChanged<AiPersona> onSelected;
  final VoidCallback? onAdd;
  final ValueChanged<AiPersona>? onDelete;

  const PersonaSelector({
    super.key,
    required this.personas,
    this.selectedUuid,
    required this.onSelected,
    this.onAdd,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '选择 AI 人设',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            itemCount: personas.length + 1, // +1 for "Add" button
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              if (index == personas.length) {
                return _AddPersonaCard(
                  onTap: () {
                    if (onAdd != null) {
                      onAdd!();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('新增人设功能开发中...')),
                      );
                    }
                  },
                );
              }

              final persona = personas[index];
              final isSelected = persona.uuid == selectedUuid;

              return _PersonaCard(
                persona: persona,
                isSelected: isSelected,
                onTap: () => onSelected(persona),
                onDelete: onDelete != null ? () => onDelete!(persona) : null,
              );
            },
          ),
        ],
      ),
    );
  }

  /// Show as bottom sheet
  static Future<AiPersona?> showAsBottomSheet(
    BuildContext context, {
    required List<AiPersona> personas,
    String? selectedUuid,
    VoidCallback? onAdd,
    ValueChanged<AiPersona>? onDelete,
  }) {
    return showModalBottomSheet<AiPersona>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true, // Allow it to grow
      builder: (context) => SingleChildScrollView(
        child: PersonaSelector(
          personas: personas,
          selectedUuid: selectedUuid,
          onSelected: (persona) => Navigator.of(context).pop(persona),
          onAdd: onAdd,
          onDelete: onDelete,
        ),
      ),
    );
  }
}

class _PersonaCard extends StatelessWidget {
  final AiPersona persona;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const _PersonaCard({
    required this.persona,
    required this.isSelected,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: onDelete,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: isSelected
                    ? Theme.of(context).primaryColor.withValues(alpha: 0.2)
                    : Colors.grey.shade200,
                child: Text(
                  persona.name.substring(0, 1),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade700,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      persona.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                    ),
                    if (persona.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        persona.description!,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Selection indicator
              if (isSelected)
                Icon(Icons.check_circle, color: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddPersonaCard extends StatelessWidget {
  final VoidCallback onTap;

  const _AddPersonaCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                '添加新 AI 人设',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
