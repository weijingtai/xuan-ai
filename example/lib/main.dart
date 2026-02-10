import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_core/ai_core.dart';
import 'package:common/database/app_database.dart' as common_db;

import 'service_locator.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final services = await ServiceLocator.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider<AiDatabase>.value(value: services.db),
        Provider<common_db.AppDatabase>.value(value: services.appDb),
        Provider<LlmService>.value(value: services.llmService),
        Provider<PromptService>.value(value: services.promptService),
        Provider<ChatService>.value(value: services.chatService),
        Provider<ChatPersistenceService>.value(
            value: services.persistenceService),
        Provider<ToolRegistry>.value(value: services.toolRegistry),
        ChangeNotifierProvider(
          create: (_) => AiChatViewModel(
            chatService: services.chatService,
            persistenceService: services.persistenceService,
            db: services.db,
          ),
        ),
      ],
      child: const AiCoreExampleApp(),
    ),
  );
}

class AiCoreExampleApp extends StatelessWidget {
  const AiCoreExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Core Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF6750A4),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color(0xFF6750A4),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const HomeScreen(),
    );
  }
}
