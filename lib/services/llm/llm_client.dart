import 'dart:async';
import '../../models/llm_request_model.dart';
import '../../models/llm_response_model.dart';

/// Abstract LLM client interface
abstract class LlmClient {
  /// Send a chat completion request
  Future<LlmResponseModel> chatCompletion(LlmRequestModel request);

  /// Send a streaming chat completion request
  Stream<StreamChunkModel> streamChatCompletion(LlmRequestModel request);

  /// Test the connection
  Future<bool> testConnection();

  /// Get available models
  Future<List<String>> listModels();

  /// Dispose resources
  void dispose();
}

/// Configuration for LLM client
class LlmClientConfig {
  final String baseUrl;
  final String? apiKey;
  final Duration timeout;
  final Map<String, String>? headers;

  const LlmClientConfig({
    required this.baseUrl,
    this.apiKey,
    this.timeout = const Duration(seconds: 60),
    this.headers,
  });

  LlmClientConfig copyWith({
    String? baseUrl,
    String? apiKey,
    Duration? timeout,
    Map<String, String>? headers,
  }) {
    return LlmClientConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      apiKey: apiKey ?? this.apiKey,
      timeout: timeout ?? this.timeout,
      headers: headers ?? this.headers,
    );
  }
}
