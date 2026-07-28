import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:repository_interface_ai/repository_interface_ai.dart';

/// Host-side AiSecretStore backed by OS secure storage (Keychain/Keystore).
///
/// SECURITY: API keys live ONLY here at runtime. They are never written to the
/// app database, SharedPreferences, assets, or committed to source control.
class SecureAiSecretStore implements AiSecretStore {
  SecureAiSecretStore([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  String _key(String providerUuid) => 'ai_api_key::$providerUuid';

  @override
  Future<String?> getApiKey(String providerUuid) =>
      _storage.read(key: _key(providerUuid));

  @override
  Future<void> setApiKey(String providerUuid, String apiKey) =>
      _storage.write(key: _key(providerUuid), value: apiKey);

  @override
  Future<void> deleteApiKey(String providerUuid) =>
      _storage.delete(key: _key(providerUuid));
}
