import 'dart:convert';

import '../../../models/remote_model_info.dart';
import '../protocol_adapter.dart';
import '../llm_client.dart';

/// Passthrough adapter for OpenAI-compatible APIs.
///
/// Since the internal canonical format *is* the OpenAI format,
/// this adapter performs no transformation — requests and responses
/// are forwarded as-is with zero overhead.
class OpenAIAdapter extends ProtocolAdapter {
  @override
  String get chatEndpoint => '/chat/completions';

  @override
  String? get modelsEndpoint => '/models';

  @override
  Map<String, String> buildHeaders(LlmClientConfig config) {
    return {
      if (config.apiKey != null) 'Authorization': 'Bearer ${config.apiKey}',
    };
  }

  @override
  Map<String, dynamic> transformRequest(Map<String, dynamic> canonicalJson) =>
      canonicalJson;

  @override
  Map<String, dynamic> transformResponse(Map<String, dynamic> wireJson) =>
      wireJson;

  @override
  Map<String, dynamic>? parseStreamLine(String line) {
    if (!line.startsWith('data: ')) return null;
    final data = line.substring(6);
    if (data == '[DONE]') throw const StreamDoneSignal();
    return jsonDecode(data) as Map<String, dynamic>;
  }

  @override
  List<String> parseModelsResponse(Map<String, dynamic> wireJson) {
    final data = wireJson['data'] as List?;
    if (data == null) return [];
    return data.map((m) => m['id'] as String).toList();
  }

  @override
  List<RemoteModelInfo> parseModelsDetailedResponse(
      Map<String, dynamic> wireJson) {
    final data = wireJson['data'] as List?;
    if (data == null) return [];
    return data
        .map((m) => RemoteModelInfo(
              id: m['id'] as String,
              object: m['object'] as String?,
              created: m['created'] as int?,
              ownedBy: m['owned_by'] as String?,
            ))
        .toList();
  }

  @override
  RemoteModelInfo parseModelDetailResponse(Map<String, dynamic> wireJson) {
    return RemoteModelInfo(
      id: wireJson['id'] as String,
      object: wireJson['object'] as String?,
      created: wireJson['created'] as int?,
      ownedBy: wireJson['owned_by'] as String?,
    );
  }
}
