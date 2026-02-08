import 'package:drift/drift.dart';
import '../ai_database.dart';
import '../tables/tables.dart';

part 'prompt_templates_dao.g.dart';

@DriftAccessor(tables: [PromptTemplates])
class PromptTemplatesDao extends DatabaseAccessor<AiDatabase>
    with _$PromptTemplatesDaoMixin {
  PromptTemplatesDao(super.db);

  /// Get all enabled templates
  Future<List<PromptTemplate>> getAllEnabled() {
    return (select(promptTemplates)
          ..where((t) => t.isEnabled.equals(true))
          ..where((t) => t.deletedAt.isNull()))
        .get();
  }

  /// Get templates by type
  Future<List<PromptTemplate>> getByType(String templateType) {
    return (select(promptTemplates)
          ..where((t) => t.templateType.equals(templateType))
          ..where((t) => t.isEnabled.equals(true))
          ..where((t) => t.deletedAt.isNull()))
        .get();
  }

  /// Get template by UUID
  Future<PromptTemplate?> getByUuid(String uuid) {
    return (select(promptTemplates)
          ..where((t) => t.uuid.equals(uuid))
          ..where((t) => t.deletedAt.isNull()))
        .getSingleOrNull();
  }

  /// Get system prompt templates
  Future<List<PromptTemplate>> getSystemPrompts() {
    return getByType('system');
  }

  /// Insert a new template
  Future<void> insertTemplate(PromptTemplatesCompanion template) {
    return into(promptTemplates).insert(template);
  }

  /// Update template content and increment version
  Future<void> updateContent(String uuid, String newContent,
      {String? changeNote}) async {
    final template = await getByUuid(uuid);
    if (template == null) return;

    await (update(promptTemplates)..where((t) => t.uuid.equals(uuid))).write(
      PromptTemplatesCompanion(
        content: Value(newContent),
        currentVersion: Value(template.currentVersion + 1),
        lastUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Soft delete a template
  Future<void> softDelete(String uuid) {
    return (update(promptTemplates)..where((t) => t.uuid.equals(uuid)))
        .write(PromptTemplatesCompanion(deletedAt: Value(DateTime.now())));
  }

  /// Watch all templates (for reactive UI)
  Stream<List<PromptTemplate>> watchAll() {
    return (select(promptTemplates)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }
}
