import 'package:persistence_core/persistence_core.dart';

/// Registers xuan-ai's database schema with the central [SchemaRegistry].
///
/// Call this during app initialization before any AiDatabase access.
/// This enables the Federated Repository pattern: the hub knows about
/// ai_core's tables without ai_core needing to own the database connection.
void registerAiSchema() {
  SchemaRegistry.instance.register(const DomainSchema(
    domain: 'ai_core',
    tables: [
      't_llm_providers',
      't_llm_models',
      't_prompt_templates',
      't_prompt_versions',
      't_prompt_skill_bindings',
      't_ai_personas',
      't_ai_chat_sessions',
      't_ai_chat_messages',
      't_ai_api_calls',
      't_ai_provenance',
      't_ai_divinations',
      't_agent_invocations',
      't_ai_usage_audits',
      't_ai_tools',
    ],
    version: 3,
  ));
}
