import 'package:drift/drift.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../ai_database.dart';
import '../tables/tables.dart';

part 'ai_provenances_dao.g.dart';

@DriftAccessor(tables: [AiProvenances])
class AiProvenancesDao extends DatabaseAccessor<AiDatabase>
    with _$AiProvenancesDaoMixin {
  AiProvenancesDao(super.db);

  /// Get provenance by UUID
  Future<AiProvenance?> getByUuid(String uuid) {
    return (select(aiProvenances)..where((t) => t.uuid.equals(uuid)))
        .getSingleOrNull();
  }

  /// Get provenance chain for an entity
  Future<List<AiProvenance>> getChain(String entityUuid) async {
    final List<AiProvenance> chain = [];
    AiProvenance? current = await (select(aiProvenances)
          ..where((t) => t.entityUuid.equals(entityUuid))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();

    while (current != null) {
      chain.add(current);
      if (current.previousProvenanceUuid == null) break;
      current = await getByUuid(current.previousProvenanceUuid!);
    }

    return chain.reversed.toList();
  }

  /// Create a new provenance record
  Future<String> createProvenance({
    required String uuid,
    required String provenanceType,
    required String entityUuid,
    required String entityType,
    required String contextSnapshotJson,
    required String inputSnapshotJson,
    String? outputSnapshotJson,
    String? promptVersionUuid,
    String? modelUuid,
    String? previousProvenanceUuid,
  }) async {
    final integrityHash = _computeIntegrityHash(
      provenanceType: provenanceType,
      entityUuid: entityUuid,
      contextSnapshotJson: contextSnapshotJson,
      inputSnapshotJson: inputSnapshotJson,
      outputSnapshotJson: outputSnapshotJson,
      previousProvenanceUuid: previousProvenanceUuid,
    );

    await into(aiProvenances).insert(
      AiProvenancesCompanion.insert(
        uuid: uuid,
        provenanceType: provenanceType,
        entityUuid: entityUuid,
        entityType: entityType,
        createdAt: DateTime.now(),
        contextSnapshotJson: contextSnapshotJson,
        inputSnapshotJson: inputSnapshotJson,
        outputSnapshotJson: Value(outputSnapshotJson),
        promptVersionUuid: Value(promptVersionUuid),
        modelUuid: Value(modelUuid),
        previousProvenanceUuid: Value(previousProvenanceUuid),
        integrityHash: integrityHash,
      ),
    );
    return uuid;
  }

  /// Verify the integrity of a provenance record
  Future<bool> verifyIntegrity(String uuid) async {
    final provenance = await getByUuid(uuid);
    if (provenance == null) return false;

    final computedHash = _computeIntegrityHash(
      provenanceType: provenance.provenanceType,
      entityUuid: provenance.entityUuid,
      contextSnapshotJson: provenance.contextSnapshotJson,
      inputSnapshotJson: provenance.inputSnapshotJson,
      outputSnapshotJson: provenance.outputSnapshotJson,
      previousProvenanceUuid: provenance.previousProvenanceUuid,
    );

    return computedHash == provenance.integrityHash;
  }

  /// Verify the entire chain
  Future<bool> verifyChain(String entityUuid) async {
    final chain = await getChain(entityUuid);
    for (final provenance in chain) {
      if (!await verifyIntegrity(provenance.uuid)) {
        return false;
      }
    }
    return true;
  }

  /// Compute integrity hash
  String _computeIntegrityHash({
    required String provenanceType,
    required String entityUuid,
    required String contextSnapshotJson,
    required String inputSnapshotJson,
    String? outputSnapshotJson,
    String? previousProvenanceUuid,
  }) {
    final data = jsonEncode({
      'provenanceType': provenanceType,
      'entityUuid': entityUuid,
      'contextSnapshotJson': contextSnapshotJson,
      'inputSnapshotJson': inputSnapshotJson,
      'outputSnapshotJson': outputSnapshotJson,
      'previousProvenanceUuid': previousProvenanceUuid,
    });
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
