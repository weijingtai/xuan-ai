import 'package:flutter/material.dart';

import '../database/ai_database.dart';

/// Persona selector widget
class PersonaSelector extends StatelessWidget {
  final List<AiPersona> personas;
  final String? selectedUuid;
  final ValueChanged<AiPersona> onSelected;

  const PersonaSelector({
    super.key,
    required this.personas,
    this.selectedUuid,
    required this.onSelected,
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            itemCount: personas.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final persona = personas[index];
              final isSelected = persona.uuid == selectedUuid;

              return _PersonaCard(
                persona: persona,
                isSelected: isSelected,
                onTap: () => onSelected(persona),
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
  }) {
    return showModalBottomSheet<AiPersona>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => PersonaSelector(
        personas: personas,
        selectedUuid: selectedUuid,
        onSelected: (persona) => Navigator.of(context).pop(persona),
      ),
    );
  }
}

class _PersonaCard extends StatelessWidget {
  final AiPersona persona;
  final bool isSelected;
  final VoidCallback onTap;

  const _PersonaCard({
    required this.persona,
    required this.isSelected,
    required this.onTap,
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
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: isSelected
                    ? Theme.of(context).primaryColor.withOpacity(0.2)
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
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
