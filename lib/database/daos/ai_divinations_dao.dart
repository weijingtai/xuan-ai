import 'package:drift/drift.dart';
import '../ai_database.dart';
import '../tables/tables.dart';

part 'ai_divinations_dao.g.dart';

@DriftAccessor(tables: [AiDivinations, AiPersonas, AiChatSessions])
class AiDivinationsDao extends DatabaseAccessor<AiDatabase>
    with _$AiDivinationsDaoMixin {
  AiDivinationsDao(super.db);

  /// Get AI divination results for a divination
  Future<List<AiDivination>> getByDivination(String divinationUuid) {
    return (select(aiDivinations)
          ..where((t) => t.divinationUuid.equals(divinationUuid))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Get AI divination results by persona
  Future<List<AiDivination>> getByPersona(String personaUuid) {
    return (select(aiDivinations)
          ..where((t) => t.personaUuid.equals(personaUuid))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Get by UUID
  Future<AiDivination?> getByUuid(String uuid) {
    return (select(aiDivinations)
          ..where((t) => t.uuid.equals(uuid))
          ..where((t) => t.deletedAt.isNull()))
        .getSingleOrNull();
  }

  /// Get by divination and persona (dual index query)
  Future<AiDivination?> getByDivinationAndPersona(
      String divinationUuid, String personaUuid) {
    return (select(aiDivinations)
          ..where((t) => t.divinationUuid.equals(divinationUuid))
          ..where((t) => t.personaUuid.equals(personaUuid))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Create a new AI divination result
  Future<String> createDivination({
    required String uuid,
    required String divinationUuid,
    required String personaUuid,
    required String interpretation,
    String? sessionUuid,
    String? fortuneLevel,
    String? advice,
    String resultType = 'summary',
    String? provenanceUuid,
  }) async {
    await into(aiDivinations).insert(
      AiDivinationsCompanion.insert(
        uuid: uuid,
        divinationUuid: divinationUuid,
        personaUuid: personaUuid,
        interpretation: interpretation,
        sessionUuid: Value(sessionUuid),
        fortuneLevel: Value(fortuneLevel),
        advice: Value(advice),
        resultType: Value(resultType),
        provenanceUuid: Value(provenanceUuid),
        createdAt: DateTime.now(),
      ),
    );
    return uuid;
  }

  /// Update user rating
  Future<void> updateRating(String uuid, int rating, {String? feedback}) {
    return (update(aiDivinations)..where((t) => t.uuid.equals(uuid))).write(
      AiDivinationsCompanion(
        userRating: Value(rating),
        userFeedback: Value(feedback),
        lastUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Soft delete
  Future<void> softDelete(String uuid) {
    return (update(aiDivinations)..where((t) => t.uuid.equals(uuid)))
        .write(AiDivinationsCompanion(deletedAt: Value(DateTime.now())));
  }

  /// Get recent divinations with ratings
  Future<List<AiDivination>> getWithRatings({int limit = 50}) {
    return (select(aiDivinations)
          ..where((t) => t.userRating.isNotNull())
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();
  }
}
