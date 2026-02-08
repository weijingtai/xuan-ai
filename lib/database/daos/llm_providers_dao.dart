import 'package:drift/drift.dart';
import '../ai_database.dart';
import '../tables/tables.dart';

part 'llm_providers_dao.g.dart';

@DriftAccessor(tables: [LlmProviders])
class LlmProvidersDao extends DatabaseAccessor<AiDatabase>
    with _$LlmProvidersDaoMixin {
  LlmProvidersDao(super.db);

  /// Get all enabled providers
  Future<List<LlmProvider>> getAllEnabled() {
    return (select(llmProviders)
          ..where((t) => t.isEnabled.equals(true))
          ..where((t) => t.deletedAt.isNull()))
        .get();
  }

  /// Get the default provider
  Future<LlmProvider?> getDefault() {
    return (select(llmProviders)
          ..where((t) => t.isDefault.equals(true))
          ..where((t) => t.deletedAt.isNull())
          ..limit(1))
        .getSingleOrNull();
  }

  /// Get provider by UUID
  Future<LlmProvider?> getByUuid(String uuid) {
    return (select(llmProviders)
          ..where((t) => t.uuid.equals(uuid))
          ..where((t) => t.deletedAt.isNull()))
        .getSingleOrNull();
  }

  /// Insert or update a provider
  Future<void> upsert(LlmProvidersCompanion provider) {
    return into(llmProviders).insertOnConflictUpdate(provider);
  }

  /// Set default provider
  Future<void> setDefault(String uuid) async {
    await transaction(() async {
      // Clear all defaults
      await (update(llmProviders)
            ..where((t) => t.isDefault.equals(true)))
          .write(const LlmProvidersCompanion(isDefault: Value(false)));

      // Set new default
      await (update(llmProviders)..where((t) => t.uuid.equals(uuid)))
          .write(const LlmProvidersCompanion(isDefault: Value(true)));
    });
  }

  /// Soft delete a provider
  Future<void> softDelete(String uuid) {
    return (update(llmProviders)..where((t) => t.uuid.equals(uuid)))
        .write(LlmProvidersCompanion(deletedAt: Value(DateTime.now())));
  }

  /// Update API key
  Future<void> updateApiKey(String uuid, String encryptedApiKey) {
    return (update(llmProviders)..where((t) => t.uuid.equals(uuid))).write(
        LlmProvidersCompanion(
            encryptedApiKey: Value(encryptedApiKey),
            lastUpdatedAt: Value(DateTime.now())));
  }
}
