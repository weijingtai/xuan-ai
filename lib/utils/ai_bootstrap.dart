import 'package:ai_core/database/ai_database.dart';
import 'package:drift/drift.dart';

/// Ensures that the DeepSeek provider exists in the database.
/// This is a helper for the example app to bootstrap the AI service.
Future<void> ensureDeepSeekProvider(AiDatabase db, String apiKey) async {
  final dao = db.llmProvidersDao;

  const providerUuid = '50b69123-5735-4309-b695-188880628238';

  // Check if our specific provider exists
  final existing = await dao.getByUuid(providerUuid);

  if (existing == null) {
    await dao.upsert(
      LlmProvidersCompanion(
        uuid: const Value(providerUuid),
        name: const Value('DeepSeek V3'),
        baseUrl: const Value('https://api.deepseek.com'),
        encryptedApiKey: Value(apiKey),
        // type: const Value('openai'),
        configJson: const Value('{"model":"deepseek-chat"}'),
        isEnabled: const Value(true),
        isDefault: const Value(true),
        createdAt: Value(DateTime.now()),
        lastUpdatedAt: Value(DateTime.now()),
      ),
    );
  } else {
    // Ensure API key is up to date
    await dao.upsert(
      LlmProvidersCompanion(
        uuid: Value(existing.uuid),
        encryptedApiKey: Value(apiKey),
        lastUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  // Ensure we have a default
  final defaultProvider = await dao.getDefault();
  if (defaultProvider == null) {
    await dao.setDefault(providerUuid);
  }
}
