import 'package:drift/drift.dart';

// ============================================================================
// Mixins
// ============================================================================

mixin AutoIncrementingPrimaryKey on Table {
  IntColumn get id => integer().autoIncrement()();
}

mixin UuidPrimaryKey on Table {
  TextColumn get uuid => text().withLength(min: 36, max: 36).named('uuid')();

  @override
  Set<Column> get primaryKey => {uuid};
}

mixin TimestampColumns on Table {
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get lastUpdatedAt =>
      dateTime().nullable().named('last_updated_at')();
  DateTimeColumn get deletedAt => dateTime().nullable().named('deleted_at')();
}

// ============================================================================
// LLM Configuration Layer
// ============================================================================

/// LLM 提供商表
/// 存储不同的 LLM 服务提供商配置
@DataClassName('LlmProvider')
class LlmProviders extends Table with UuidPrimaryKey, TimestampColumns {
  @override
  String get tableName => 't_llm_providers';

  /// 提供商名称 (如 "OpenAI", "Claude", "DeepSeek")
  TextColumn get name => text().withLength(min: 1, max: 100).named('name')();

  /// 提供商类型 (openai_compatible, anthropic, etc.)
  TextColumn get providerType =>
      text().withLength(min: 1, max: 50).named('provider_type')();

  /// API 基础 URL
  TextColumn get baseUrl => text().named('base_url')();

  /// 加密存储的 API Key
  TextColumn get encryptedApiKey =>
      text().nullable().named('encrypted_api_key')();

  /// 是否为默认提供商
  BoolColumn get isDefault =>
      boolean().withDefault(const Constant(false)).named('is_default')();

  /// 是否启用
  BoolColumn get isEnabled =>
      boolean().withDefault(const Constant(true)).named('is_enabled')();

  /// 额外配置 (JSON)
  TextColumn get configJson => text().nullable().named('config_json')();
}

/// LLM 模型版本表
/// 存储每个提供商下的具体模型配置
@DataClassName('LlmModel')
class LlmModels extends Table with UuidPrimaryKey, TimestampColumns {
  @override
  String get tableName => 't_llm_models';

  /// 关联的提供商 UUID
  TextColumn get providerUuid =>
      text().named('provider_uuid').references(LlmProviders, #uuid)();

  /// 模型标识符 (如 "gpt-4", "claude-3-opus")
  TextColumn get modelId =>
      text().withLength(min: 1, max: 100).named('model_id')();

  /// 模型显示名称
  TextColumn get displayName =>
      text().withLength(min: 1, max: 200).named('display_name')();

  /// 模型类型 (chat, completion, embedding)
  TextColumn get modelType =>
      text().withLength(min: 1, max: 50).named('model_type')();

  /// 最大上下文长度
  IntColumn get maxContextLength =>
      integer().withDefault(const Constant(4096)).named('max_context_length')();

  /// 最大输出 token 数
  IntColumn get maxOutputTokens =>
      integer().withDefault(const Constant(4096)).named('max_output_tokens')();

  /// 是否支持流式输出
  BoolColumn get supportsStreaming =>
      boolean().withDefault(const Constant(true)).named('supports_streaming')();

  /// 是否支持 Function Calling
  BoolColumn get supportsFunctionCalling => boolean()
      .withDefault(const Constant(false))
      .named('supports_function_calling')();

  /// 是否为默认模型
  BoolColumn get isDefault =>
      boolean().withDefault(const Constant(false)).named('is_default')();

  /// 是否启用
  BoolColumn get isEnabled =>
      boolean().withDefault(const Constant(true)).named('is_enabled')();

  /// 额外配置 (JSON)
  TextColumn get configJson => text().nullable().named('config_json')();
}

// ============================================================================
// Prompt Management Layer
// ============================================================================

/// Prompt 模板表
/// 可编辑的 Prompt 模板
@DataClassName('PromptTemplate')
class PromptTemplates extends Table with UuidPrimaryKey, TimestampColumns {
  @override
  String get tableName => 't_prompt_templates';

  /// 模板名称
  TextColumn get name => text().withLength(min: 1, max: 200).named('name')();

  /// 模板描述
  TextColumn get description => text().nullable().named('description')();

  /// 模板类型 (system, user, assistant, function)
  TextColumn get templateType =>
      text().withLength(min: 1, max: 50).named('template_type')();

  /// 当前内容 (可编辑)
  TextColumn get content => text().named('content')();

  /// 变量列表 (JSON 数组)
  TextColumn get variablesJson => text().nullable().named('variables_json')();

  /// 当前版本号
  IntColumn get currentVersion =>
      integer().withDefault(const Constant(1)).named('current_version')();

  /// 是否为系统内置
  BoolColumn get isBuiltin =>
      boolean().withDefault(const Constant(false)).named('is_builtin')();

  /// 是否启用
  BoolColumn get isEnabled =>
      boolean().withDefault(const Constant(true)).named('is_enabled')();
}

/// Prompt 版本历史表
/// 不可变的版本记录
@DataClassName('PromptVersion')
class PromptVersions extends Table with UuidPrimaryKey {
  @override
  String get tableName => 't_prompt_versions';

  /// 关联的模板 UUID
  TextColumn get templateUuid =>
      text().named('template_uuid').references(PromptTemplates, #uuid)();

  /// 版本号
  IntColumn get version => integer().named('version')();

  /// 版本内容 (不可变)
  TextColumn get content => text().named('content')();

  /// 变量列表 (JSON 数组，不可变)
  TextColumn get variablesJson => text().nullable().named('variables_json')();

  /// 内容哈希 (用于完整性校验)
  TextColumn get contentHash =>
      text().withLength(min: 64, max: 64).named('content_hash')();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().named('created_at')();

  /// 创建说明
  TextColumn get changeNote => text().nullable().named('change_note')();
}

/// Prompt 技法绑定表
/// 将 Prompt 模板与占测技法关联
@DataClassName('PromptSkillBinding')
class PromptSkillBindings extends Table
    with AutoIncrementingPrimaryKey, TimestampColumns {
  @override
  String get tableName => 't_prompt_skill_bindings';

  /// 关联的 Prompt 模板 UUID
  TextColumn get promptTemplateUuid =>
      text().named('prompt_template_uuid').references(PromptTemplates, #uuid)();

  /// 关联的技法 ID (来自 common 模块的 Skills 表)
  IntColumn get skillId => integer().named('skill_id')();

  /// 绑定类型 (system_prompt, user_guide, analysis_template)
  TextColumn get bindingType =>
      text().withLength(min: 1, max: 50).named('binding_type')();

  /// 优先级 (数字越小优先级越高)
  IntColumn get priority =>
      integer().withDefault(const Constant(0)).named('priority')();

  /// 是否启用
  BoolColumn get isEnabled =>
      boolean().withDefault(const Constant(true)).named('is_enabled')();
}

// ============================================================================
// AI Persona Layer
// ============================================================================

/// AI 人设表
/// 拟人化 AI 配置
@DataClassName('AiPersona')
class AiPersonas extends Table with UuidPrimaryKey, TimestampColumns {
  @override
  String get tableName => 't_ai_personas';

  /// 人设名称
  TextColumn get name => text().withLength(min: 1, max: 100).named('name')();

  /// 人设头像 URL 或 base64
  TextColumn get avatarUrl => text().nullable().named('avatar_url')();

  /// 人设描述
  TextColumn get description => text().nullable().named('description')();

  /// 关联的 LLM 模型 UUID
  TextColumn get modelUuid =>
      text().named('model_uuid').references(LlmModels, #uuid)();

  /// 关联的系统 Prompt 模板 UUID
  TextColumn get systemPromptUuid => text()
      .nullable()
      .named('system_prompt_uuid')
      .references(PromptTemplates, #uuid)();

  /// 温度参数 (0.0-2.0)
  RealColumn get temperature =>
      real().withDefault(const Constant(0.7)).named('temperature')();

  /// Top P 参数
  RealColumn get topP => real().withDefault(const Constant(1.0)).named('top_p')();

  /// 最大输出 token
  IntColumn get maxTokens =>
      integer().withDefault(const Constant(2048)).named('max_tokens')();

  /// 人设性格特征 (JSON)
  TextColumn get personalityJson => text().nullable().named('personality_json')();

  /// 专业领域 (JSON 数组)
  TextColumn get expertiseJson => text().nullable().named('expertise_json')();

  /// 是否为默认人设
  BoolColumn get isDefault =>
      boolean().withDefault(const Constant(false)).named('is_default')();

  /// 是否启用
  BoolColumn get isEnabled =>
      boolean().withDefault(const Constant(true)).named('is_enabled')();
}

// ============================================================================
// Chat Management Layer
// ============================================================================

/// AI 对话会话表
@DataClassName('AiChatSession')
class AiChatSessions extends Table with UuidPrimaryKey, TimestampColumns {
  @override
  String get tableName => 't_ai_chat_sessions';

  /// 会话标题
  TextColumn get title => text().nullable().named('title')();

  /// 关联的 AI 人设 UUID
  TextColumn get personaUuid =>
      text().named('persona_uuid').references(AiPersonas, #uuid)();

  /// 关联的占测 UUID (来自 common 模块)
  TextColumn get divinationUuid => text().nullable().named('divination_uuid')();

  /// 会话状态 (active, archived, deleted)
  TextColumn get status =>
      text().withDefault(const Constant('active')).named('status')();

  /// 会话上下文 (JSON，存储占测数据快照)
  TextColumn get contextJson => text().nullable().named('context_json')();

  /// 消息计数
  IntColumn get messageCount =>
      integer().withDefault(const Constant(0)).named('message_count')();

  /// 最后消息时间
  DateTimeColumn get lastMessageAt =>
      dateTime().nullable().named('last_message_at')();
}

/// AI 对话消息表
@DataClassName('AiChatMessage')
class AiChatMessages extends Table with UuidPrimaryKey {
  @override
  String get tableName => 't_ai_chat_messages';

  /// 关联的会话 UUID
  TextColumn get sessionUuid =>
      text().named('session_uuid').references(AiChatSessions, #uuid)();

  /// 消息角色 (system, user, assistant, function, tool)
  TextColumn get role =>
      text().withLength(min: 1, max: 20).named('role')();

  /// 消息内容
  TextColumn get content => text().named('content')();

  /// 消息序号
  IntColumn get sequence => integer().named('sequence')();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().named('created_at')();

  /// 是否为流式消息（正在生成中）
  BoolColumn get isStreaming =>
      boolean().withDefault(const Constant(false)).named('is_streaming')();

  /// 流式消息完成时间
  DateTimeColumn get streamCompletedAt =>
      dateTime().nullable().named('stream_completed_at')();

  /// 关联的工具调用 ID
  TextColumn get toolCallId => text().nullable().named('tool_call_id')();

  /// 工具调用详情 (JSON)
  TextColumn get toolCallsJson => text().nullable().named('tool_calls_json')();

  /// token 使用统计 (JSON)
  TextColumn get usageJson => text().nullable().named('usage_json')();

  /// 关联的 API 调用 UUID
  TextColumn get apiCallUuid =>
      text().nullable().named('api_call_uuid').references(AiApiCalls, #uuid)();
}

/// AI API 调用记录表
@DataClassName('AiApiCall')
class AiApiCalls extends Table with UuidPrimaryKey {
  @override
  String get tableName => 't_ai_api_calls';

  /// 关联的会话 UUID
  TextColumn get sessionUuid =>
      text().nullable().named('session_uuid').references(AiChatSessions, #uuid)();

  /// 关联的模型 UUID
  TextColumn get modelUuid =>
      text().named('model_uuid').references(LlmModels, #uuid)();

  /// 请求时间
  DateTimeColumn get requestedAt => dateTime().named('requested_at')();

  /// 响应时间
  DateTimeColumn get respondedAt =>
      dateTime().nullable().named('responded_at')();

  /// 请求体 (JSON)
  TextColumn get requestJson => text().named('request_json')();

  /// 响应体 (JSON)
  TextColumn get responseJson => text().nullable().named('response_json')();

  /// 请求状态 (pending, success, error, timeout)
  TextColumn get status =>
      text().withDefault(const Constant('pending')).named('status')();

  /// 错误信息
  TextColumn get errorMessage => text().nullable().named('error_message')();

  /// 输入 token 数
  IntColumn get inputTokens =>
      integer().nullable().named('input_tokens')();

  /// 输出 token 数
  IntColumn get outputTokens =>
      integer().nullable().named('output_tokens')();

  /// 总 token 数
  IntColumn get totalTokens =>
      integer().nullable().named('total_tokens')();

  /// 延迟 (毫秒)
  IntColumn get latencyMs => integer().nullable().named('latency_ms')();

  /// 是否为流式请求
  BoolColumn get isStreaming =>
      boolean().withDefault(const Constant(false)).named('is_streaming')();
}

// ============================================================================
// Provenance Layer
// ============================================================================

/// AI 溯源记录表
/// 不可变的完整溯源链
@DataClassName('AiProvenance')
class AiProvenances extends Table with UuidPrimaryKey {
  @override
  String get tableName => 't_ai_provenance';

  /// 溯源类型 (api_call, tool_invocation, agent_call, message)
  TextColumn get provenanceType =>
      text().withLength(min: 1, max: 50).named('provenance_type')();

  /// 关联的实体 UUID (可以是消息、API调用、Agent调用等)
  TextColumn get entityUuid => text().named('entity_uuid')();

  /// 关联的实体类型
  TextColumn get entityType =>
      text().withLength(min: 1, max: 50).named('entity_type')();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().named('created_at')();

  /// 完整上下文快照 (JSON)
  TextColumn get contextSnapshotJson => text().named('context_snapshot_json')();

  /// 输入数据快照 (JSON)
  TextColumn get inputSnapshotJson => text().named('input_snapshot_json')();

  /// 输出数据快照 (JSON)
  TextColumn get outputSnapshotJson =>
      text().nullable().named('output_snapshot_json')();

  /// Prompt 版本 UUID (如果适用)
  TextColumn get promptVersionUuid =>
      text().nullable().named('prompt_version_uuid')();

  /// 模型 UUID
  TextColumn get modelUuid => text().nullable().named('model_uuid')();

  /// 溯源链前一条记录 UUID (形成链式结构)
  TextColumn get previousProvenanceUuid =>
      text().nullable().named('previous_provenance_uuid')();

  /// 整体哈希 (用于完整性校验)
  TextColumn get integrityHash =>
      text().withLength(min: 64, max: 64).named('integrity_hash')();
}

// ============================================================================
// AI Divination Result Layer
// ============================================================================

/// AI 占测结果表
/// 使用双索引关联占测和人设
@DataClassName('AiDivination')
class AiDivinations extends Table with UuidPrimaryKey, TimestampColumns {
  @override
  String get tableName => 't_ai_divinations';

  /// 关联的占测 UUID (来自 common 模块)
  TextColumn get divinationUuid => text().named('divination_uuid')();

  /// 关联的 AI 人设 UUID
  TextColumn get personaUuid =>
      text().named('persona_uuid').references(AiPersonas, #uuid)();

  /// 关联的对话会话 UUID
  TextColumn get sessionUuid =>
      text().nullable().named('session_uuid').references(AiChatSessions, #uuid)();

  /// AI 解读结果
  TextColumn get interpretation => text().named('interpretation')();

  /// AI 给出的吉凶判断
  TextColumn get fortuneLevel => text().nullable().named('fortune_level')();

  /// AI 建议
  TextColumn get advice => text().nullable().named('advice')();

  /// 结果类型 (summary, detailed, teaching)
  TextColumn get resultType =>
      text().withDefault(const Constant('summary')).named('result_type')();

  /// 用户评分 (1-5)
  IntColumn get userRating => integer().nullable().named('user_rating')();

  /// 用户反馈
  TextColumn get userFeedback => text().nullable().named('user_feedback')();

  /// 溯源记录 UUID
  TextColumn get provenanceUuid =>
      text().nullable().named('provenance_uuid').references(AiProvenances, #uuid)();

  @override
  List<Index> get indexes => [
        Index(
          'idx_ai_divinations_divination_uuid',
          'CREATE INDEX idx_ai_divinations_divination_uuid ON t_ai_divinations (divination_uuid)',
        ),
        Index(
          'idx_ai_divinations_persona_uuid',
          'CREATE INDEX idx_ai_divinations_persona_uuid ON t_ai_divinations (persona_uuid)',
        ),
      ];
}

// ============================================================================
// Agent Invocation Layer
// ============================================================================

/// Agent 调用记录表
@DataClassName('AgentInvocation')
class AgentInvocations extends Table with UuidPrimaryKey {
  @override
  String get tableName => 't_agent_invocations';

  /// 调用者 Agent 人设 UUID
  TextColumn get callerPersonaUuid =>
      text().named('caller_persona_uuid').references(AiPersonas, #uuid)();

  /// 被调用者 Agent 人设 UUID
  TextColumn get calleePersonaUuid =>
      text().named('callee_persona_uuid').references(AiPersonas, #uuid)();

  /// 关联的会话 UUID
  TextColumn get sessionUuid =>
      text().nullable().named('session_uuid').references(AiChatSessions, #uuid)();

  /// 调用时间
  DateTimeColumn get invokedAt => dateTime().named('invoked_at')();

  /// 完成时间
  DateTimeColumn get completedAt =>
      dateTime().nullable().named('completed_at')();

  /// 调用目的/任务描述
  TextColumn get purpose => text().named('purpose')();

  /// 共享上下文 (JSON)
  TextColumn get sharedContextJson => text().nullable().named('shared_context_json')();

  /// 调用结果 (JSON)
  TextColumn get resultJson => text().nullable().named('result_json')();

  /// 调用状态 (pending, running, completed, failed, timeout)
  TextColumn get status =>
      text().withDefault(const Constant('pending')).named('status')();

  /// 错误信息
  TextColumn get errorMessage => text().nullable().named('error_message')();

  /// 调用链父级 UUID (用于追踪嵌套调用)
  TextColumn get parentInvocationUuid =>
      text().nullable().named('parent_invocation_uuid')();

  /// 调用深度
  IntColumn get depth => integer().withDefault(const Constant(0)).named('depth')();
}

// ============================================================================
// Audit Layer
// ============================================================================

/// AI 使用审计表
@DataClassName('AiUsageAudit')
class AiUsageAudits extends Table with AutoIncrementingPrimaryKey {
  @override
  String get tableName => 't_ai_usage_audits';

  /// 审计时间
  DateTimeColumn get auditedAt => dateTime().named('audited_at')();

  /// 审计类型 (api_call, token_usage, error, security)
  TextColumn get auditType =>
      text().withLength(min: 1, max: 50).named('audit_type')();

  /// 关联的实体 UUID
  TextColumn get entityUuid => text().nullable().named('entity_uuid')();

  /// 关联的实体类型
  TextColumn get entityType => text().nullable().named('entity_type')();

  /// 关联的用户/会话标识
  TextColumn get userIdentifier => text().nullable().named('user_identifier')();

  /// 操作描述
  TextColumn get action => text().named('action')();

  /// 详细信息 (JSON)
  TextColumn get detailsJson => text().nullable().named('details_json')();

  /// token 消耗
  IntColumn get tokensUsed => integer().nullable().named('tokens_used')();

  /// 费用估算
  RealColumn get estimatedCost =>
      real().nullable().named('estimated_cost')();

  /// IP 地址
  TextColumn get ipAddress => text().nullable().named('ip_address')();

  /// 设备信息
  TextColumn get deviceInfo => text().nullable().named('device_info')();

  @override
  List<Index> get indexes => [
        Index(
          'idx_ai_usage_audits_audited_at',
          'CREATE INDEX idx_ai_usage_audits_audited_at ON t_ai_usage_audits (audited_at)',
        ),
        Index(
          'idx_ai_usage_audits_audit_type',
          'CREATE INDEX idx_ai_usage_audits_audit_type ON t_ai_usage_audits (audit_type)',
        ),
      ];
}

// ============================================================================
// Tool Registry Layer
// ============================================================================

/// AI 工具注册表
@DataClassName('AiTool')
class AiTools extends Table with UuidPrimaryKey, TimestampColumns {
  @override
  String get tableName => 't_ai_tools';

  /// 工具名称
  TextColumn get name => text().withLength(min: 1, max: 100).named('name')();

  /// 工具描述
  TextColumn get description => text().named('description')();

  /// 工具类型 (divination, analysis, calculation, query)
  TextColumn get toolType =>
      text().withLength(min: 1, max: 50).named('tool_type')();

  /// 关联的技法 ID (如果是占测工具)
  IntColumn get skillId => integer().nullable().named('skill_id')();

  /// 工具参数 Schema (JSON Schema 格式)
  TextColumn get parametersSchemaJson => text().named('parameters_schema_json')();

  /// 工具返回值 Schema (JSON Schema 格式)
  TextColumn get returnSchemaJson =>
      text().nullable().named('return_schema_json')();

  /// 是否需要确认才能执行
  BoolColumn get requiresConfirmation =>
      boolean().withDefault(const Constant(false)).named('requires_confirmation')();

  /// 是否启用
  BoolColumn get isEnabled =>
      boolean().withDefault(const Constant(true)).named('is_enabled')();

  /// 执行器类型 (native, external, agent)
  TextColumn get executorType =>
      text().withDefault(const Constant('native')).named('executor_type')();

  /// 执行器配置 (JSON)
  TextColumn get executorConfigJson =>
      text().nullable().named('executor_config_json')();
}
