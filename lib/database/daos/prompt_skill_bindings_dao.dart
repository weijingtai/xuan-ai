import 'package:drift/drift.dart';
import '../ai_database.dart';
import '../tables/tables.dart';

part 'prompt_skill_bindings_dao.g.dart';

@DriftAccessor(tables: [PromptSkillBindings, PromptTemplates])
class PromptSkillBindingsDao extends DatabaseAccessor<AiDatabase>
    with _$PromptSkillBindingsDaoMixin {
  PromptSkillBindingsDao(super.db);

  /// Get bindings for a skill
  Future<List<PromptSkillBinding>> getBySkill(int skillId) {
    return (select(promptSkillBindings)
          ..where((t) => t.skillId.equals(skillId))
          ..where((t) => t.isEnabled.equals(true))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.priority)]))
        .get();
  }

  /// Get bindings for a template
  Future<List<PromptSkillBinding>> getByTemplate(String templateUuid) {
    return (select(promptSkillBindings)
          ..where((t) => t.promptTemplateUuid.equals(templateUuid))
          ..where((t) => t.deletedAt.isNull()))
        .get();
  }

  /// Get bindings by type for a skill
  Future<List<PromptSkillBinding>> getBySkillAndType(
      int skillId, String bindingType) {
    return (select(promptSkillBindings)
          ..where((t) => t.skillId.equals(skillId))
          ..where((t) => t.bindingType.equals(bindingType))
          ..where((t) => t.isEnabled.equals(true))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.priority)]))
        .get();
  }

  /// Create a new binding
  Future<int> createBinding(PromptSkillBindingsCompanion binding) {
    return into(promptSkillBindings).insert(binding);
  }

  /// Update binding priority
  Future<void> updatePriority(int id, int priority) {
    return (update(promptSkillBindings)..where((t) => t.id.equals(id))).write(
      PromptSkillBindingsCompanion(
        priority: Value(priority),
        lastUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Toggle binding enabled status
  Future<void> toggleEnabled(int id, bool isEnabled) {
    return (update(promptSkillBindings)..where((t) => t.id.equals(id))).write(
      PromptSkillBindingsCompanion(
        isEnabled: Value(isEnabled),
        lastUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Soft delete a binding
  Future<void> softDelete(int id) {
    return (update(promptSkillBindings)..where((t) => t.id.equals(id)))
        .write(PromptSkillBindingsCompanion(deletedAt: Value(DateTime.now())));
  }
}
