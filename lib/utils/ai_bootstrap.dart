import 'package:ai_core/database/ai_database.dart';
import 'package:drift/drift.dart';

const _kDeepSeekProviderUuid = '50b69123-5735-4309-b695-188880628238';
const _kDeepSeekModelUuid = 'd827c19a-9426-4a4b-9e4a-188880628239';
const _kDefaultPersonaUuid = '10000000-0000-0000-0000-000000000001';

/// Ensures that the DeepSeek provider exists in the database.
Future<void> ensureDeepSeekProvider(AiDatabase db, {String? apiKey}) async {
  final dao = db.llmProvidersDao;
  final keyToUse = apiKey ?? '';

  // 1. Ensure Provider
  final existing = await dao.getByUuid(_kDeepSeekProviderUuid);

  if (existing == null) {
    await dao.upsert(
      LlmProvidersCompanion(
        uuid: const Value(_kDeepSeekProviderUuid),
        name: const Value('DeepSeek'),
        baseUrl: const Value('https://api.deepseek.com'),
        encryptedApiKey: Value(keyToUse),
        configJson: const Value('{"model":"deepseek-chat"}'),
        isEnabled: const Value(true),
        isDefault: const Value(true),
        createdAt: Value(DateTime.now()),
        lastUpdatedAt: Value(DateTime.now()),
      ),
    );
  } else if (apiKey != null) {
    // Update API Key if provided
    await dao.upsert(
      LlmProvidersCompanion.insert(
        uuid: existing.uuid,
        name: existing.name,
        baseUrl: existing.baseUrl,
        encryptedApiKey: Value(apiKey),
        lastUpdatedAt: Value(DateTime.now()),
        createdAt: existing.createdAt, // Keep original createdAt
      ),
    );
  }

  // Ensure default provider
  final defaultProvider = await dao.getDefault();
  if (defaultProvider == null) {
    await dao.setDefault(_kDeepSeekProviderUuid);
  }

  // 2. Ensure Model
  await _ensureDeepSeekModel(db);

  // 3. Ensure Persona
  await _ensureDefaultPersona(db);
}

Future<void> _ensureDeepSeekModel(AiDatabase db) async {
  final dao = db.llmModelsDao;
  final existing = await dao.getByUuid(_kDeepSeekModelUuid);

  if (existing == null) {
    await dao.upsert(
      LlmModelsCompanion(
        uuid: const Value(_kDeepSeekModelUuid),
        providerUuid: const Value(_kDeepSeekProviderUuid),
        displayName: const Value('DeepSeek V3'),
        modelId: const Value('deepseek-chat'),
        modelType: const Value('chat'),
        maxContextLength: const Value(64000),
        maxOutputTokens: const Value(4096),
        isEnabled: const Value(true),
        isDefault: const Value(true),
        createdAt: Value(DateTime.now()),
        lastUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  // Ensure default model
  final defaultModel = await dao.getDefault();
  if (defaultModel == null) {
    await dao.setDefault(_kDeepSeekModelUuid);
  }
}

Future<void> _ensureDefaultPersona(AiDatabase db) async {
  final dao = db.aiPersonasDao;
  final existing = await dao.getByUuid(_kDefaultPersonaUuid);

  if (existing == null) {
    await dao.insertPersona(
      AiPersonasCompanion(
        uuid: const Value(_kDefaultPersonaUuid),
        name: const Value('玄学助手'),
        description: const Value('您的智能玄学顾问，精通八字、奇门、六壬等术数。'),
        avatarUrl: const Value('assets/images/ai_avatar_default.png'),
        modelUuid: const Value(_kDeepSeekModelUuid),
        temperature: const Value(0.7),
        topP: const Value(0.9),
        maxTokens: const Value(2000),
        isEnabled: const Value(true),
        isDefault: const Value(true),
        createdAt: Value(DateTime.now()),
        lastUpdatedAt: Value(DateTime.now()),
      ),
    );
  } else {
    // Optional: Update standard fields if needed, but usually we respect user edits
    // Here we just ensure it exists.
  }

  // Ensure default persona
  final defaultPersona = await dao.getDefault();
  if (defaultPersona == null) {
    await dao.setDefault(_kDefaultPersonaUuid);
  }
}
