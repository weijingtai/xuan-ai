import 'package:drift/drift.dart';
import '../ai_database.dart';
import '../tables/tables.dart';

part 'llm_models_dao.g.dart';

@DriftAccessor(tables: [LlmModels, LlmProviders])
class LlmModelsDao extends DatabaseAccessor<AiDatabase>
    with _$LlmModelsDaoMixin {
  LlmModelsDao(super.db);

  /// Get all enabled models for a provider
  Future<List<LlmModel>> getByProvider(String providerUuid) {
    return (select(llmModels)
          ..where((t) => t.providerUuid.equals(providerUuid))
          ..where((t) => t.isEnabled.equals(true))
          ..where((t) => t.deletedAt.isNull()))
        .get();
  }

  /// Get the default model
  Future<LlmModel?> getDefault() {
    return (select(llmModels)
          ..where((t) => t.isDefault.equals(true))
          ..where((t) => t.deletedAt.isNull())
          ..limit(1))
        .getSingleOrNull();
  }

  /// Get model by UUID
  Future<LlmModel?> getByUuid(String uuid) {
    return (select(llmModels)
          ..where((t) => t.uuid.equals(uuid))
          ..where((t) => t.deletedAt.isNull()))
        .getSingleOrNull();
  }

  /// Get models that support function calling
  Future<List<LlmModel>> getWithFunctionCalling() {
    return (select(llmModels)
          ..where((t) => t.supportsFunctionCalling.equals(true))
          ..where((t) => t.isEnabled.equals(true))
          ..where((t) => t.deletedAt.isNull()))
        .get();
  }

  /// Insert or update a model
  Future<void> upsert(LlmModelsCompanion model) {
    return into(llmModels).insertOnConflictUpdate(model);
  }

  /// Set default model
  Future<void> setDefault(String uuid) async {
    await transaction(() async {
      await (update(llmModels)..where((t) => t.isDefault.equals(true)))
          .write(const LlmModelsCompanion(isDefault: Value(false)));

      await (update(llmModels)..where((t) => t.uuid.equals(uuid)))
          .write(const LlmModelsCompanion(isDefault: Value(true)));
    });
  }

  /// Soft delete a model
  Future<void> softDelete(String uuid) {
    return (update(llmModels)..where((t) => t.uuid.equals(uuid)))
        .write(LlmModelsCompanion(deletedAt: Value(DateTime.now())));
  }
}
