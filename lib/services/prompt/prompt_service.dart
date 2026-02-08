import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

import '../../database/ai_database.dart';

/// Prompt service for managing prompt templates and versions
class PromptService {
  final AiDatabase _db;
  final Uuid _uuid = const Uuid();

  PromptService(this._db);

  /// Get a prompt template by UUID
  Future<PromptTemplate?> getTemplate(String uuid) {
    return _db.promptTemplatesDao.getByUuid(uuid);
  }

  /// Get all system prompt templates
  Future<List<PromptTemplate>> getSystemPrompts() {
    return _db.promptTemplatesDao.getSystemPrompts();
  }

  /// Create a new prompt template
  Future<String> createTemplate({
    required String name,
    required String templateType,
    required String content,
    String? description,
    List<String>? variables,
  }) async {
    final uuid = _uuid.v4();
    await _db.promptTemplatesDao.insertTemplate(
      PromptTemplatesCompanion.insert(
        uuid: uuid,
        name: name,
        templateType: templateType,
        content: content,
        description: Value(description),
        variablesJson: Value(variables != null ? jsonEncode(variables) : null),
        createdAt: DateTime.now(),
      ),
    );

    // Create initial version
    await _createVersion(uuid, content, variables);

    return uuid;
  }

  /// Update template content and create a new version
  Future<void> updateTemplate(
    String uuid,
    String newContent, {
    String? changeNote,
    List<String>? variables,
  }) async {
    final template = await getTemplate(uuid);
    if (template == null) {
      throw Exception('Template not found: $uuid');
    }

    // Update the template
    await _db.promptTemplatesDao.updateContent(uuid, newContent,
        changeNote: changeNote);

    // Create new version
    await _createVersion(uuid, newContent, variables, changeNote: changeNote);
  }

  /// Create a version record
  Future<String> _createVersion(
    String templateUuid,
    String content,
    List<String>? variables, {
    String? changeNote,
  }) async {
    return await _db.promptVersionsDao.createVersion(
      templateUuid,
      content,
      variablesJson: variables != null ? jsonEncode(variables) : null,
      changeNote: changeNote,
    );
  }

  /// Get the rendered content with variables substituted
  Future<String> renderTemplate(
    String templateUuid,
    Map<String, dynamic> variables,
  ) async {
    final template = await getTemplate(templateUuid);
    if (template == null) {
      throw Exception('Template not found: $templateUuid');
    }

    return substituteVariables(template.content, variables);
  }

  /// Get prompt for a skill
  Future<String?> getSkillPrompt(int skillId, String bindingType) async {
    final bindings =
        await _db.promptSkillBindingsDao.getBySkillAndType(skillId, bindingType);

    if (bindings.isEmpty) return null;

    final binding = bindings.first; // Highest priority
    final template = await getTemplate(binding.promptTemplateUuid);

    return template?.content;
  }

  /// Verify version integrity
  Future<bool> verifyVersionIntegrity(String versionUuid) {
    return _db.promptVersionsDao.verifyIntegrity(versionUuid);
  }

  /// Get version history for a template
  Future<List<PromptVersion>> getVersionHistory(String templateUuid) {
    return _db.promptVersionsDao.getByTemplate(templateUuid);
  }
}

/// Substitute variables in template content
String substituteVariables(String template, Map<String, dynamic> variables) {
  String result = template;

  // Replace {{variable}} patterns
  final pattern = RegExp(r'\{\{(\w+)\}\}');
  result = result.replaceAllMapped(pattern, (match) {
    final key = match.group(1)!;
    if (variables.containsKey(key)) {
      return variables[key]?.toString() ?? '';
    }
    return match.group(0)!; // Keep original if no substitution
  });

  return result;
}
