import 'package:drift/drift.dart';
import '../ai_database.dart';
import '../tables/tables.dart';

part 'ai_personas_dao.g.dart';

@DriftAccessor(tables: [AiPersonas, LlmModels, PromptTemplates])
class AiPersonasDao extends DatabaseAccessor<AiDatabase>
    with _$AiPersonasDaoMixin {
  AiPersonasDao(super.db);

  /// Get all enabled personas
  Future<List<AiPersona>> getAllEnabled() {
    return (select(aiPersonas)
          ..where((t) => t.isEnabled.equals(true))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  /// Get the default persona
  Future<AiPersona?> getDefault() {
    return (select(aiPersonas)
          ..where((t) => t.isDefault.equals(true))
          ..where((t) => t.deletedAt.isNull())
          ..limit(1))
        .getSingleOrNull();
  }

  /// Get persona by UUID
  Future<AiPersona?> getByUuid(String uuid) {
    return (select(aiPersonas)
          ..where((t) => t.uuid.equals(uuid))
          ..where((t) => t.deletedAt.isNull()))
        .getSingleOrNull();
  }

  /// Insert a new persona
  Future<void> insertPersona(AiPersonasCompanion persona) {
    return into(aiPersonas).insert(persona);
  }

  /// Update a persona
  Future<void> updatePersona(String uuid, AiPersonasCompanion updates) {
    return (update(aiPersonas)..where((t) => t.uuid.equals(uuid))).write(
      updates.copyWith(lastUpdatedAt: Value(DateTime.now())),
    );
  }

  /// Set default persona
  Future<void> setDefault(String uuid) async {
    await transaction(() async {
      await (update(aiPersonas)..where((t) => t.isDefault.equals(true)))
          .write(const AiPersonasCompanion(isDefault: Value(false)));

      await (update(aiPersonas)..where((t) => t.uuid.equals(uuid)))
          .write(const AiPersonasCompanion(isDefault: Value(true)));
    });
  }

  /// Update temperature
  Future<void> updateTemperature(String uuid, double temperature) {
    return (update(aiPersonas)..where((t) => t.uuid.equals(uuid))).write(
      AiPersonasCompanion(
        temperature: Value(temperature),
        lastUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Soft delete a persona
  Future<void> softDelete(String uuid) {
    return (update(aiPersonas)..where((t) => t.uuid.equals(uuid)))
        .write(AiPersonasCompanion(deletedAt: Value(DateTime.now())));
  }

  /// Watch all personas (for reactive UI)
  Stream<List<AiPersona>> watchAll() {
    return (select(aiPersonas)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }
}
