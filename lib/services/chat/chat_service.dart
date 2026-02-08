import 'dart:async';
import 'dart:convert';

import '../../database/ai_database.dart';
import '../../models/models.dart';
import '../llm/llm_service.dart';
import '../prompt/prompt_service.dart';
import '../tool/tool_registry.dart';
import 'chat_persistence_service.dart';

/// Main chat service for AI conversations
class ChatService {
  final AiDatabase _db;
  final LlmService _llmService;
  final PromptService _promptService;
  final ChatPersistenceService _persistenceService;
  final ToolRegistry _toolRegistry;

  ChatService({
    required AiDatabase db,
    required LlmService llmService,
    required PromptService promptService,
    required ChatPersistenceService persistenceService,
    required ToolRegistry toolRegistry,
  })  : _db = db,
        _llmService = llmService,
        _promptService = promptService,
        _persistenceService = persistenceService,
        _toolRegistry = toolRegistry;

  /// Start a new chat session
  Future<String> startSession({
    required String personaUuid,
    String? divinationUuid,
    Map<String, dynamic>? context,
  }) async {
    final sessionUuid = await _persistenceService.createSession(
      personaUuid: personaUuid,
      divinationUuid: divinationUuid,
      contextJson: context != null ? jsonEncode(context) : null,
    );

    // Add system message from persona's prompt
    final persona = await _db.aiPersonasDao.getByUuid(personaUuid);
    if (persona?.systemPromptUuid != null) {
      final template = await _promptService.getTemplate(persona!.systemPromptUuid!);
      if (template != null) {
        String systemPrompt = template.content;
        if (context != null) {
          systemPrompt = _promptService.substituteVariables(
            systemPrompt,
            context,
          ) as String;
        }

        await _persistenceService.addMessage(
          sessionUuid: sessionUuid,
          role: 'system',
          content: systemPrompt,
        );
      }
    }

    return sessionUuid;
  }

  /// Send a message and get a response
  Future<String> sendMessage({
    required String sessionUuid,
    required String content,
    bool stream = true,
  }) async {
    // Add user message
    await _persistenceService.addMessage(
      sessionUuid: sessionUuid,
      role: 'user',
      content: content,
    );

    // Get session and persona
    final session = await _persistenceService.getSession(sessionUuid);
    if (session == null) {
      throw Exception('Session not found: $sessionUuid');
    }

    final persona = await _db.aiPersonasDao.getByUuid(session.personaUuid);
    if (persona == null) {
      throw Exception('Persona not found: ${session.personaUuid}');
    }

    // Build messages for API
    final dbMessages = await _persistenceService.getMessages(sessionUuid);
    final apiMessages = dbMessages
        .map((m) => ChatMessageModel(role: m.role, content: m.content))
        .toList();

    // Get tools for function calling
    final tools = await _toolRegistry.getToolDefinitions();

    if (stream) {
      return await _streamResponse(
        sessionUuid: sessionUuid,
        persona: persona,
        messages: apiMessages,
        tools: tools,
      );
    } else {
      return await _nonStreamResponse(
        sessionUuid: sessionUuid,
        persona: persona,
        messages: apiMessages,
        tools: tools,
      );
    }
  }

  /// Handle streaming response
  Future<String> _streamResponse({
    required String sessionUuid,
    required AiPersona persona,
    required List<ChatMessageModel> messages,
    required List<ToolDefinition>? tools,
  }) async {
    // Create placeholder message
    final messageUuid = await _persistenceService.addMessage(
      sessionUuid: sessionUuid,
      role: 'assistant',
      content: '',
      isStreaming: true,
    );

    final contentBuffer = StringBuffer();

    try {
      await for (final chunk in _llmService.streamChatCompletion(
        modelUuid: persona.modelUuid,
        messages: messages,
        temperature: persona.temperature,
        topP: persona.topP,
        maxTokens: persona.maxTokens,
        tools: tools,
        sessionUuid: sessionUuid,
      )) {
        if (chunk.deltaContent != null) {
          contentBuffer.write(chunk.deltaContent);
          await _persistenceService.updateMessageContent(
            messageUuid,
            contentBuffer.toString(),
          );
        }
      }

      await _persistenceService.completeStreamingMessage(messageUuid);

      return contentBuffer.toString();
    } catch (e) {
      // Update message with error indicator
      await _persistenceService.updateMessageContent(
        messageUuid,
        '[Error: ${e.toString()}]',
      );
      await _persistenceService.completeStreamingMessage(messageUuid);
      rethrow;
    }
  }

  /// Handle non-streaming response
  Future<String> _nonStreamResponse({
    required String sessionUuid,
    required AiPersona persona,
    required List<ChatMessageModel> messages,
    required List<ToolDefinition>? tools,
  }) async {
    final response = await _llmService.chatCompletion(
      modelUuid: persona.modelUuid,
      messages: messages,
      temperature: persona.temperature,
      topP: persona.topP,
      maxTokens: persona.maxTokens,
      tools: tools,
      sessionUuid: sessionUuid,
    );

    final content = response.content ?? '';

    // Handle tool calls
    if (response.hasToolCalls) {
      await _handleToolCalls(
        sessionUuid: sessionUuid,
        persona: persona,
        toolCalls: response.toolCalls!,
        messages: messages,
      );
    } else {
      // Add assistant message
      await _persistenceService.addMessage(
        sessionUuid: sessionUuid,
        role: 'assistant',
        content: content,
      );
    }

    return content;
  }

  /// Handle tool calls from LLM
  Future<void> _handleToolCalls({
    required String sessionUuid,
    required AiPersona persona,
    required List<ToolCallModel> toolCalls,
    required List<ChatMessageModel> messages,
  }) async {
    // Add assistant message with tool calls
    await _persistenceService.addMessage(
      sessionUuid: sessionUuid,
      role: 'assistant',
      content: '',
      toolCallsJson: jsonEncode(toolCalls.map((t) => t.toJson()).toList()),
    );

    // Execute each tool call
    for (final toolCall in toolCalls) {
      final result = await _toolRegistry.executeTool(
        toolCall.function.name,
        jsonDecode(toolCall.function.arguments),
      );

      // Add tool result message
      await _persistenceService.addMessage(
        sessionUuid: sessionUuid,
        role: 'tool',
        content: jsonEncode(result.result ?? result.error),
        toolCallId: toolCall.id,
      );
    }

    // Continue conversation with tool results
    final updatedMessages = await _persistenceService.getMessages(sessionUuid);
    final apiMessages = updatedMessages
        .map((m) => ChatMessageModel(
              role: m.role,
              content: m.content,
              toolCallId: m.toolCallId,
            ))
        .toList();

    // Get next response
    await _nonStreamResponse(
      sessionUuid: sessionUuid,
      persona: persona,
      messages: apiMessages,
      tools: await _toolRegistry.getToolDefinitions(),
    );
  }

  /// Get session history
  Future<List<AiChatMessage>> getHistory(String sessionUuid) {
    return _persistenceService.getMessages(sessionUuid);
  }

  /// Watch session messages
  Stream<List<AiChatMessage>> watchMessages(String sessionUuid) {
    return _persistenceService.watchMessages(sessionUuid);
  }
}
