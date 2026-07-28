import 'package:repository_interface_ai/repository_interface_ai.dart';

/// Bundle of storage/secret ports injected into ai_core by the host/assembly.
///
/// The product receives these ports; it must not construct concrete
/// implementations or know which backend was chosen.
class AiStorageDependencies {
  const AiStorageDependencies({
    required this.chatHistory,
    required this.config,
    required this.prompts,
    required this.secrets,
  });

  final AiChatHistoryRepository chatHistory;
  final AiConfigRepository config;
  final AiPromptStore prompts;
  final AiSecretStore secrets;
}
