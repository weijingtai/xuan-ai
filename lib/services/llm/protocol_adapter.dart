import 'llm_client.dart';

/// Signal thrown by [ProtocolAdapter.parseStreamLine] to indicate
/// that the stream is complete and no more data should be expected.
class StreamDoneSignal implements Exception {
  const StreamDoneSignal();
}

/// Pluggable protocol adapter that translates between the canonical
/// (OpenAI-compatible) request/response format used internally and
/// the wire format required by a specific LLM provider.
///
/// The [OpenAICompatibleClient] delegates all format-specific logic
/// to the active adapter, keeping HTTP and SSE plumbing in one place.
abstract class ProtocolAdapter {
  /// REST path for chat completions (e.g. '/chat/completions').
  String get chatEndpoint;

  /// REST path for streaming chat completions.
  /// Defaults to [chatEndpoint]; override for providers that use a
  /// separate endpoint for streaming (e.g. Gemini).
  String get streamEndpoint => chatEndpoint;

  /// REST path for listing available models, or `null` if the
  /// provider does not expose such an endpoint.
  String? get modelsEndpoint;

  /// Build provider-specific HTTP headers.
  Map<String, String> buildHeaders(LlmClientConfig config);

  /// Build provider-specific query parameters appended to every
  /// request URL.  Returns an empty map by default.
  Map<String, String> buildQueryParams(LlmClientConfig config) => {};

  /// Resolve the final endpoint path.
  ///
  /// Called with the raw path (e.g. from [chatEndpoint]) and the
  /// canonical request JSON so that template variables such as
  /// `{model}` can be substituted.
  String resolveEndpoint(String path, Map<String, dynamic> requestJson) => path;

  /// Transform the canonical (OpenAI-format) request JSON into the
  /// wire format expected by this provider.
  Map<String, dynamic> transformRequest(Map<String, dynamic> canonicalJson);

  /// Transform the wire-format response JSON back into canonical
  /// (OpenAI-format) response JSON.
  Map<String, dynamic> transformResponse(Map<String, dynamic> wireJson);

  /// Parse a single SSE line from the stream.
  ///
  /// Returns the parsed JSON chunk in **canonical** format, or
  /// `null` to skip the line (e.g. comments, keep-alive pings).
  /// Throw [StreamDoneSignal] to indicate the stream has ended.
  Map<String, dynamic>? parseStreamLine(String line);

  /// Parse the wire-format model list response into a simple list
  /// of model identifier strings.
  List<String> parseModelsResponse(Map<String, dynamic> wireJson);
}
