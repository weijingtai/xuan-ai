import 'package:drift/drift.dart';
import '../ai_database.dart';
import '../tables/tables.dart';

part 'ai_tools_dao.g.dart';

@DriftAccessor(tables: [AiTools])
class AiToolsDao extends DatabaseAccessor<AiDatabase> with _$AiToolsDaoMixin {
  AiToolsDao(super.db);

  /// Get all enabled tools
  Future<List<AiTool>> getAllEnabled() {
    return (select(aiTools)
          ..where((t) => t.isEnabled.equals(true))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  /// Get tools by type
  Future<List<AiTool>> getByType(String toolType) {
    return (select(aiTools)
          ..where((t) => t.toolType.equals(toolType))
          ..where((t) => t.isEnabled.equals(true))
          ..where((t) => t.deletedAt.isNull()))
        .get();
  }

  /// Get tools for a skill
  Future<List<AiTool>> getBySkill(int skillId) {
    return (select(aiTools)
          ..where((t) => t.skillId.equals(skillId))
          ..where((t) => t.isEnabled.equals(true))
          ..where((t) => t.deletedAt.isNull()))
        .get();
  }

  /// Get tool by UUID
  Future<AiTool?> getByUuid(String uuid) {
    return (select(aiTools)
          ..where((t) => t.uuid.equals(uuid))
          ..where((t) => t.deletedAt.isNull()))
        .getSingleOrNull();
  }

  /// Get tool by name
  Future<AiTool?> getByName(String name) {
    return (select(aiTools)
          ..where((t) => t.name.equals(name))
          ..where((t) => t.deletedAt.isNull()))
        .getSingleOrNull();
  }

  /// Register a new tool
  Future<void> registerTool(AiToolsCompanion tool) {
    return into(aiTools).insert(tool);
  }

  /// Update tool configuration
  Future<void> updateTool(String uuid, AiToolsCompanion updates) {
    return (update(aiTools)..where((t) => t.uuid.equals(uuid))).write(
      updates.copyWith(lastUpdatedAt: Value(DateTime.now())),
    );
  }

  /// Toggle tool enabled status
  Future<void> toggleEnabled(String uuid, bool isEnabled) {
    return (update(aiTools)..where((t) => t.uuid.equals(uuid))).write(
      AiToolsCompanion(
        isEnabled: Value(isEnabled),
        lastUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Soft delete a tool
  Future<void> softDelete(String uuid) {
    return (update(aiTools)..where((t) => t.uuid.equals(uuid)))
        .write(AiToolsCompanion(deletedAt: Value(DateTime.now())));
  }

  /// Watch all tools (for reactive UI)
  Stream<List<AiTool>> watchAll() {
    return (select(aiTools)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }
}
