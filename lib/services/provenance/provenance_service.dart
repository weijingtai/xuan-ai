import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

import '../../database/ai_database.dart';

/// Provenance service for tracking AI decision chains
class ProvenanceService {
  final AiDatabase _db;
  final Uuid _uuid = const Uuid();

  ProvenanceService(this._db);

  /// Create a provenance record for an API call
  Future<String> recordApiCall({
    required String apiCallUuid,
    required Map<String, dynamic> context,
    required Map<String, dynamic> input,
    Map<String, dynamic>? output,
    String? promptVersionUuid,
    String? modelUuid,
    String? previousProvenanceUuid,
  }) async {
    return await _db.aiProvenancesDao.createProvenance(
      uuid: _uuid.v4(),
      provenanceType: 'api_call',
      entityUuid: apiCallUuid,
      entityType: 'AiApiCall',
      contextSnapshotJson: jsonEncode(context),
      inputSnapshotJson: jsonEncode(input),
      outputSnapshotJson: output != null ? jsonEncode(output) : null,
      promptVersionUuid: promptVersionUuid,
      modelUuid: modelUuid,
      previousProvenanceUuid: previousProvenanceUuid,
    );
  }

  /// Create a provenance record for a tool invocation
  Future<String> recordToolInvocation({
    required String toolCallId,
    required String toolName,
    required Map<String, dynamic> context,
    required Map<String, dynamic> input,
    Map<String, dynamic>? output,
    String? previousProvenanceUuid,
  }) async {
    return await _db.aiProvenancesDao.createProvenance(
      uuid: _uuid.v4(),
      provenanceType: 'tool_invocation',
      entityUuid: toolCallId,
      entityType: 'ToolCall',
      contextSnapshotJson: jsonEncode({
        ...context,
        'toolName': toolName,
      }),
      inputSnapshotJson: jsonEncode(input),
      outputSnapshotJson: output != null ? jsonEncode(output) : null,
      previousProvenanceUuid: previousProvenanceUuid,
    );
  }

  /// Create a provenance record for an agent call
  Future<String> recordAgentCall({
    required String agentInvocationUuid,
    required String callerPersonaName,
    required String calleePersonaName,
    required Map<String, dynamic> context,
    required Map<String, dynamic> input,
    Map<String, dynamic>? output,
    String? previousProvenanceUuid,
  }) async {
    return await _db.aiProvenancesDao.createProvenance(
      uuid: _uuid.v4(),
      provenanceType: 'agent_call',
      entityUuid: agentInvocationUuid,
      entityType: 'AgentInvocation',
      contextSnapshotJson: jsonEncode({
        ...context,
        'callerPersona': callerPersonaName,
        'calleePersona': calleePersonaName,
      }),
      inputSnapshotJson: jsonEncode(input),
      outputSnapshotJson: output != null ? jsonEncode(output) : null,
      previousProvenanceUuid: previousProvenanceUuid,
    );
  }

  /// Create a provenance record for a message
  Future<String> recordMessage({
    required String messageUuid,
    required String role,
    required Map<String, dynamic> context,
    required String content,
    String? previousProvenanceUuid,
  }) async {
    return await _db.aiProvenancesDao.createProvenance(
      uuid: _uuid.v4(),
      provenanceType: 'message',
      entityUuid: messageUuid,
      entityType: 'AiChatMessage',
      contextSnapshotJson: jsonEncode({
        ...context,
        'role': role,
      }),
      inputSnapshotJson: jsonEncode({'content': content}),
      previousProvenanceUuid: previousProvenanceUuid,
    );
  }

  /// Get the provenance chain for an entity
  Future<List<AiProvenance>> getProvenanceChain(String entityUuid) {
    return _db.aiProvenancesDao.getChain(entityUuid);
  }

  /// Verify the integrity of a provenance record
  Future<bool> verifyIntegrity(String provenanceUuid) {
    return _db.aiProvenancesDao.verifyIntegrity(provenanceUuid);
  }

  /// Verify the entire chain
  Future<bool> verifyChain(String entityUuid) {
    return _db.aiProvenancesDao.verifyChain(entityUuid);
  }

  /// Build a human-readable provenance report
  Future<String> buildProvenanceReport(String entityUuid) async {
    final chain = await getProvenanceChain(entityUuid);
    if (chain.isEmpty) return 'No provenance records found.';

    final buffer = StringBuffer();
    buffer.writeln('=== Provenance Report ===');
    buffer.writeln('Entity: $entityUuid');
    buffer.writeln('Chain length: ${chain.length}');
    buffer.writeln();

    for (var i = 0; i < chain.length; i++) {
      final record = chain[i];
      final isVerified = await verifyIntegrity(record.uuid);

      buffer.writeln('[$i] ${record.provenanceType}');
      buffer.writeln('    UUID: ${record.uuid}');
      buffer.writeln('    Time: ${record.createdAt}');
      buffer.writeln('    Verified: ${isVerified ? "✓" : "✗"}');
      if (record.modelUuid != null) {
        buffer.writeln('    Model: ${record.modelUuid}');
      }
      if (record.promptVersionUuid != null) {
        buffer.writeln('    Prompt Version: ${record.promptVersionUuid}');
      }
      buffer.writeln();
    }

    return buffer.toString();
  }

  /// Export provenance chain as JSON
  Future<String> exportProvenanceChainJson(String entityUuid) async {
    final chain = await getProvenanceChain(entityUuid);
    final exportData = chain.map((p) => {
      'uuid': p.uuid,
      'type': p.provenanceType,
      'entityUuid': p.entityUuid,
      'entityType': p.entityType,
      'createdAt': p.createdAt.toIso8601String(),
      'contextSnapshot': jsonDecode(p.contextSnapshotJson),
      'inputSnapshot': jsonDecode(p.inputSnapshotJson),
      'outputSnapshot':
          p.outputSnapshotJson != null ? jsonDecode(p.outputSnapshotJson!) : null,
      'promptVersionUuid': p.promptVersionUuid,
      'modelUuid': p.modelUuid,
      'integrityHash': p.integrityHash,
    }).toList();

    return jsonEncode({
      'entityUuid': entityUuid,
      'exportedAt': DateTime.now().toIso8601String(),
      'chain': exportData,
    });
  }
}
