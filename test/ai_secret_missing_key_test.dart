import 'package:flutter_test/flutter_test.dart';
import 'package:repository_interface_ai/repository_interface_ai.dart';

class _FakeSecretStore implements AiSecretStore {
  @override
  Future<String?> getApiKey(String providerUuid) async => null;

  @override
  Future<void> setApiKey(String providerUuid, String apiKey) async {}

  @override
  Future<void> deleteApiKey(String providerUuid) async {}
}

void main() {
  test('missing key returns null without throwing', () async {
    final store = _FakeSecretStore();
    final result = await store.getApiKey('non-existent-uuid');
    expect(result, isNull);
  });
}
