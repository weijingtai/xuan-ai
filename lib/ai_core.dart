/// AI Core module for xuan divination application.
///
/// Provides LLM integration, prompt management, AI personas,
/// chat system, and multi-agent orchestration.
library ai_core;

// Database
export 'package:persistence_drift/ai/ai_database.dart';

// Models
export 'models/models.dart';

// Services
export 'services/services.dart';

// ViewModels
export 'viewmodels/viewmodels.dart';

// Widgets
export 'widgets/widgets.dart';

// Utils
export 'utils/ai_bootstrap.dart';

// Ports (interface + dependency bundle)
export 'ports/ai_storage_dependencies.dart';
export 'package:repository_interface_ai/repository_interface_ai.dart';
