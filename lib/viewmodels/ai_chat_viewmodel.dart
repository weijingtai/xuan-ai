import 'dart:async';
import 'package:flutter/foundation.dart';

import '../database/ai_database.dart';
import '../services/chat/chat_service.dart';
import '../services/chat/chat_persistence_service.dart';

/// ViewModel for AI chat functionality
class AiChatViewModel extends ChangeNotifier {
  final ChatService _chatService;
  final ChatPersistenceService _persistenceService;
  final AiDatabase _db;

  String? _currentSessionUuid;
  List<AiChatMessage> _messages = [];
  bool _isLoading = false;
  String? _error;
  AiPersona? _currentPersona;
  StreamSubscription<List<AiChatMessage>>? _messagesSubscription;

  AiChatViewModel({
    required ChatService chatService,
    required ChatPersistenceService persistenceService,
    required AiDatabase db,
  })  : _chatService = chatService,
        _persistenceService = persistenceService,
        _db = db;

  // Getters
  String? get currentSessionUuid => _currentSessionUuid;
  List<AiChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;
  AiPersona? get currentPersona => _currentPersona;
  bool get hasSession => _currentSessionUuid != null;

  /// Start a new chat session
  Future<void> startSession({
    required String personaUuid,
    String? divinationUuid,
    Map<String, dynamic>? context,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      // Get persona
      _currentPersona = await _db.aiPersonasDao.getByUuid(personaUuid);

      // Create session
      _currentSessionUuid = await _chatService.startSession(
        personaUuid: personaUuid,
        divinationUuid: divinationUuid,
        context: context,
      );

      // Watch messages
      _subscribeToMessages();

      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Resume an existing session
  Future<void> resumeSession(String sessionUuid) async {
    _setLoading(true);
    _clearError();

    try {
      final session = await _persistenceService.getSession(sessionUuid);
      if (session == null) {
        throw Exception('Session not found: $sessionUuid');
      }

      _currentSessionUuid = sessionUuid;
      _currentPersona = await _db.aiPersonasDao.getByUuid(session.personaUuid);

      // Load existing messages
      _messages = await _persistenceService.getMessages(sessionUuid);

      // Watch messages
      _subscribeToMessages();

      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Send a message
  Future<void> sendMessage(String content) async {
    if (_currentSessionUuid == null) {
      _setError('No active session');
      return;
    }

    _setLoading(true);
    _clearError();

    try {
      await _chatService.sendMessage(
        sessionUuid: _currentSessionUuid!,
        content: content,
        stream: true,
      );
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Subscribe to message updates
  void _subscribeToMessages() {
    _messagesSubscription?.cancel();

    if (_currentSessionUuid != null) {
      _messagesSubscription = _persistenceService
          .watchMessages(_currentSessionUuid!)
          .listen((messages) {
        _messages = messages;
        notifyListeners();
      });
    }
  }

  /// Clear current session
  Future<void> clearSession() async {
    _messagesSubscription?.cancel();
    _currentSessionUuid = null;
    _messages = [];
    _currentPersona = null;
    notifyListeners();
  }

  /// Archive current session
  Future<void> archiveSession() async {
    if (_currentSessionUuid != null) {
      await _persistenceService.archiveSession(_currentSessionUuid!);
      await clearSession();
    }
  }

  /// Delete current session
  Future<void> deleteSession() async {
    if (_currentSessionUuid != null) {
      await _persistenceService.deleteSession(_currentSessionUuid!);
      await clearSession();
    }
  }

  /// Get available personas
  Future<List<AiPersona>> getAvailablePersonas() {
    return _db.aiPersonasDao.getAllEnabled();
  }

  /// Switch persona for current session
  Future<void> switchPersona(String personaUuid) async {
    if (_currentSessionUuid == null) return;

    _currentPersona = await _db.aiPersonasDao.getByUuid(personaUuid);
    notifyListeners();
  }

  /// Regenerate last response
  Future<void> regenerateLastResponse() async {
    if (_currentSessionUuid == null || _messages.isEmpty) return;

    // Find last user message
    final lastUserMessageIndex =
        _messages.lastIndexWhere((m) => m.role == 'user');
    if (lastUserMessageIndex < 0) return;

    final lastUserMessage = _messages[lastUserMessageIndex];

    // Remove messages after the last user message
    // This is simplified - in production you'd handle this more carefully

    _setLoading(true);
    try {
      await _chatService.sendMessage(
        sessionUuid: _currentSessionUuid!,
        content: lastUserMessage.content,
        stream: true,
      );
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Private helpers
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    super.dispose();
  }
}
