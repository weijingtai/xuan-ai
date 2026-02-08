import 'package:drift/drift.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../ai_database.dart';
import '../tables/tables.dart';

part 'prompt_versions_dao.g.dart';

@DriftAccessor(tables: [PromptVersions, PromptTemplates])
class PromptVersionsDao extends DatabaseAccessor<AiDatabase>
    with _$PromptVersionsDaoMixin {
  PromptVersionsDao(super.db);

  /// Create a new version for a template
  Future<String> createVersion(
    String templateUuid,
    String content, {
    String? variablesJson,
    String? changeNote,
  }) async {
    final template = await (select(db.promptTemplates)
          ..where((t) => t.uuid.equals(templateUuid)))
        .getSingleOrNull();

    if (template == null) {
      throw Exception('Template not found: $templateUuid');
    }

    final version = template.currentVersion;
    final contentHash = _computeHash(content);
    final uuid = '${templateUuid}_v$version';

    await into(promptVersions).insert(
      PromptVersionsCompanion.insert(
        uuid: uuid,
        templateUuid: templateUuid,
        version: version,
        content: content,
        variablesJson: Value(variablesJson),
        contentHash: contentHash,
        createdAt: DateTime.now(),
        changeNote: Value(changeNote),
      ),
    );

    return uuid;
  }

  /// Get all versions for a template
  Future<List<PromptVersion>> getByTemplate(String templateUuid) {
    return (select(promptVersions)
          ..where((t) => t.templateUuid.equals(templateUuid))
          ..orderBy([(t) => OrderingTerm.desc(t.version)]))
        .get();
  }

  /// Get a specific version
  Future<PromptVersion?> getByUuid(String uuid) {
    return (select(promptVersions)..where((t) => t.uuid.equals(uuid)))
        .getSingleOrNull();
  }

  /// Get the latest version for a template
  Future<PromptVersion?> getLatest(String templateUuid) {
    return (select(promptVersions)
          ..where((t) => t.templateUuid.equals(templateUuid))
          ..orderBy([(t) => OrderingTerm.desc(t.version)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Verify version integrity
  Future<bool> verifyIntegrity(String uuid) async {
    final version = await getByUuid(uuid);
    if (version == null) return false;

    final computedHash = _computeHash(version.content);
    return computedHash == version.contentHash;
  }

  /// Compute SHA-256 hash of content
  String _computeHash(String content) {
    final bytes = utf8.encode(content);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
