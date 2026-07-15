// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_database.dart';

// ignore_for_file: type=lint
class $LlmProvidersTable extends LlmProviders
    with TableInfo<$LlmProvidersTable, LlmProvider> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LlmProvidersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdatedAtMeta = const VerificationMeta(
    'lastUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedAt =
      GeneratedColumn<DateTime>(
        'last_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseUrlMeta = const VerificationMeta(
    'baseUrl',
  );
  @override
  late final GeneratedColumn<String> baseUrl = GeneratedColumn<String>(
    'base_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _encryptedApiKeyMeta = const VerificationMeta(
    'encryptedApiKey',
  );
  @override
  late final GeneratedColumn<String> encryptedApiKey = GeneratedColumn<String>(
    'encrypted_api_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _configJsonMeta = const VerificationMeta(
    'configJson',
  );
  @override
  late final GeneratedColumn<String> configJson = GeneratedColumn<String>(
    'config_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    uuid,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    name,
    baseUrl,
    encryptedApiKey,
    isDefault,
    isEnabled,
    configJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_llm_providers';
  @override
  VerificationContext validateIntegrity(
    Insertable<LlmProvider> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
        _lastUpdatedAtMeta,
        lastUpdatedAt.isAcceptableOrUnknown(
          data['last_updated_at']!,
          _lastUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('base_url')) {
      context.handle(
        _baseUrlMeta,
        baseUrl.isAcceptableOrUnknown(data['base_url']!, _baseUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_baseUrlMeta);
    }
    if (data.containsKey('encrypted_api_key')) {
      context.handle(
        _encryptedApiKeyMeta,
        encryptedApiKey.isAcceptableOrUnknown(
          data['encrypted_api_key']!,
          _encryptedApiKeyMeta,
        ),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('config_json')) {
      context.handle(
        _configJsonMeta,
        configJson.isAcceptableOrUnknown(data['config_json']!, _configJsonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  LlmProvider map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LlmProvider(
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      baseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_url'],
      )!,
      encryptedApiKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}encrypted_api_key'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      configJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}config_json'],
      ),
    );
  }

  @override
  $LlmProvidersTable createAlias(String alias) {
    return $LlmProvidersTable(attachedDatabase, alias);
  }
}

class LlmProvider extends DataClass implements Insertable<LlmProvider> {
  final String uuid;
  final DateTime createdAt;
  final DateTime? lastUpdatedAt;
  final DateTime? deletedAt;

  /// 提供商名称 (如 "Default", "DeepSeek", "Claude")
  final String name;

  /// API 基础 URL
  final String baseUrl;

  /// 加密存储的 API Key
  final String? encryptedApiKey;

  /// 是否为默认提供商
  final bool isDefault;

  /// 是否启用
  final bool isEnabled;

  /// 额外配置 (JSON)
  final String? configJson;
  const LlmProvider({
    required this.uuid,
    required this.createdAt,
    this.lastUpdatedAt,
    this.deletedAt,
    required this.name,
    required this.baseUrl,
    this.encryptedApiKey,
    required this.isDefault,
    required this.isEnabled,
    this.configJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastUpdatedAt != null) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['name'] = Variable<String>(name);
    map['base_url'] = Variable<String>(baseUrl);
    if (!nullToAbsent || encryptedApiKey != null) {
      map['encrypted_api_key'] = Variable<String>(encryptedApiKey);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['is_enabled'] = Variable<bool>(isEnabled);
    if (!nullToAbsent || configJson != null) {
      map['config_json'] = Variable<String>(configJson);
    }
    return map;
  }

  LlmProvidersCompanion toCompanion(bool nullToAbsent) {
    return LlmProvidersCompanion(
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      lastUpdatedAt: lastUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      name: Value(name),
      baseUrl: Value(baseUrl),
      encryptedApiKey: encryptedApiKey == null && nullToAbsent
          ? const Value.absent()
          : Value(encryptedApiKey),
      isDefault: Value(isDefault),
      isEnabled: Value(isEnabled),
      configJson: configJson == null && nullToAbsent
          ? const Value.absent()
          : Value(configJson),
    );
  }

  factory LlmProvider.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LlmProvider(
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdatedAt: serializer.fromJson<DateTime?>(json['lastUpdatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      name: serializer.fromJson<String>(json['name']),
      baseUrl: serializer.fromJson<String>(json['baseUrl']),
      encryptedApiKey: serializer.fromJson<String?>(json['encryptedApiKey']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      configJson: serializer.fromJson<String?>(json['configJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdatedAt': serializer.toJson<DateTime?>(lastUpdatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'name': serializer.toJson<String>(name),
      'baseUrl': serializer.toJson<String>(baseUrl),
      'encryptedApiKey': serializer.toJson<String?>(encryptedApiKey),
      'isDefault': serializer.toJson<bool>(isDefault),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'configJson': serializer.toJson<String?>(configJson),
    };
  }

  LlmProvider copyWith({
    String? uuid,
    DateTime? createdAt,
    Value<DateTime?> lastUpdatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? name,
    String? baseUrl,
    Value<String?> encryptedApiKey = const Value.absent(),
    bool? isDefault,
    bool? isEnabled,
    Value<String?> configJson = const Value.absent(),
  }) => LlmProvider(
    uuid: uuid ?? this.uuid,
    createdAt: createdAt ?? this.createdAt,
    lastUpdatedAt: lastUpdatedAt.present
        ? lastUpdatedAt.value
        : this.lastUpdatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    name: name ?? this.name,
    baseUrl: baseUrl ?? this.baseUrl,
    encryptedApiKey: encryptedApiKey.present
        ? encryptedApiKey.value
        : this.encryptedApiKey,
    isDefault: isDefault ?? this.isDefault,
    isEnabled: isEnabled ?? this.isEnabled,
    configJson: configJson.present ? configJson.value : this.configJson,
  );
  LlmProvider copyWithCompanion(LlmProvidersCompanion data) {
    return LlmProvider(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      name: data.name.present ? data.name.value : this.name,
      baseUrl: data.baseUrl.present ? data.baseUrl.value : this.baseUrl,
      encryptedApiKey: data.encryptedApiKey.present
          ? data.encryptedApiKey.value
          : this.encryptedApiKey,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      configJson: data.configJson.present
          ? data.configJson.value
          : this.configJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LlmProvider(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('encryptedApiKey: $encryptedApiKey, ')
          ..write('isDefault: $isDefault, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('configJson: $configJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uuid,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    name,
    baseUrl,
    encryptedApiKey,
    isDefault,
    isEnabled,
    configJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LlmProvider &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.deletedAt == this.deletedAt &&
          other.name == this.name &&
          other.baseUrl == this.baseUrl &&
          other.encryptedApiKey == this.encryptedApiKey &&
          other.isDefault == this.isDefault &&
          other.isEnabled == this.isEnabled &&
          other.configJson == this.configJson);
}

class LlmProvidersCompanion extends UpdateCompanion<LlmProvider> {
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastUpdatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> name;
  final Value<String> baseUrl;
  final Value<String?> encryptedApiKey;
  final Value<bool> isDefault;
  final Value<bool> isEnabled;
  final Value<String?> configJson;
  final Value<int> rowid;
  const LlmProvidersCompanion({
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.encryptedApiKey = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.configJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LlmProvidersCompanion.insert({
    required String uuid,
    required DateTime createdAt,
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String name,
    required String baseUrl,
    this.encryptedApiKey = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.configJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid),
       createdAt = Value(createdAt),
       name = Value(name),
       baseUrl = Value(baseUrl);
  static Insertable<LlmProvider> custom({
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? name,
    Expression<String>? baseUrl,
    Expression<String>? encryptedApiKey,
    Expression<bool>? isDefault,
    Expression<bool>? isEnabled,
    Expression<String>? configJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (name != null) 'name': name,
      if (baseUrl != null) 'base_url': baseUrl,
      if (encryptedApiKey != null) 'encrypted_api_key': encryptedApiKey,
      if (isDefault != null) 'is_default': isDefault,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (configJson != null) 'config_json': configJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LlmProvidersCompanion copyWith({
    Value<String>? uuid,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastUpdatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? name,
    Value<String>? baseUrl,
    Value<String?>? encryptedApiKey,
    Value<bool>? isDefault,
    Value<bool>? isEnabled,
    Value<String?>? configJson,
    Value<int>? rowid,
  }) {
    return LlmProvidersCompanion(
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      name: name ?? this.name,
      baseUrl: baseUrl ?? this.baseUrl,
      encryptedApiKey: encryptedApiKey ?? this.encryptedApiKey,
      isDefault: isDefault ?? this.isDefault,
      isEnabled: isEnabled ?? this.isEnabled,
      configJson: configJson ?? this.configJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (baseUrl.present) {
      map['base_url'] = Variable<String>(baseUrl.value);
    }
    if (encryptedApiKey.present) {
      map['encrypted_api_key'] = Variable<String>(encryptedApiKey.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (configJson.present) {
      map['config_json'] = Variable<String>(configJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LlmProvidersCompanion(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('encryptedApiKey: $encryptedApiKey, ')
          ..write('isDefault: $isDefault, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('configJson: $configJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LlmModelsTable extends LlmModels
    with TableInfo<$LlmModelsTable, LlmModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LlmModelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdatedAtMeta = const VerificationMeta(
    'lastUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedAt =
      GeneratedColumn<DateTime>(
        'last_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _providerUuidMeta = const VerificationMeta(
    'providerUuid',
  );
  @override
  late final GeneratedColumn<String> providerUuid = GeneratedColumn<String>(
    'provider_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES t_llm_providers (uuid)',
    ),
  );
  static const VerificationMeta _modelIdMeta = const VerificationMeta(
    'modelId',
  );
  @override
  late final GeneratedColumn<String> modelId = GeneratedColumn<String>(
    'model_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelTypeMeta = const VerificationMeta(
    'modelType',
  );
  @override
  late final GeneratedColumn<String> modelType = GeneratedColumn<String>(
    'model_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxContextLengthMeta = const VerificationMeta(
    'maxContextLength',
  );
  @override
  late final GeneratedColumn<int> maxContextLength = GeneratedColumn<int>(
    'max_context_length',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(4096),
  );
  static const VerificationMeta _maxOutputTokensMeta = const VerificationMeta(
    'maxOutputTokens',
  );
  @override
  late final GeneratedColumn<int> maxOutputTokens = GeneratedColumn<int>(
    'max_output_tokens',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(4096),
  );
  static const VerificationMeta _supportsStreamingMeta = const VerificationMeta(
    'supportsStreaming',
  );
  @override
  late final GeneratedColumn<bool> supportsStreaming = GeneratedColumn<bool>(
    'supports_streaming',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("supports_streaming" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _supportsFunctionCallingMeta =
      const VerificationMeta('supportsFunctionCalling');
  @override
  late final GeneratedColumn<bool> supportsFunctionCalling =
      GeneratedColumn<bool>(
        'supports_function_calling',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("supports_function_calling" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _configJsonMeta = const VerificationMeta(
    'configJson',
  );
  @override
  late final GeneratedColumn<String> configJson = GeneratedColumn<String>(
    'config_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    uuid,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    providerUuid,
    modelId,
    displayName,
    modelType,
    maxContextLength,
    maxOutputTokens,
    supportsStreaming,
    supportsFunctionCalling,
    isDefault,
    isEnabled,
    configJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_llm_models';
  @override
  VerificationContext validateIntegrity(
    Insertable<LlmModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
        _lastUpdatedAtMeta,
        lastUpdatedAt.isAcceptableOrUnknown(
          data['last_updated_at']!,
          _lastUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('provider_uuid')) {
      context.handle(
        _providerUuidMeta,
        providerUuid.isAcceptableOrUnknown(
          data['provider_uuid']!,
          _providerUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_providerUuidMeta);
    }
    if (data.containsKey('model_id')) {
      context.handle(
        _modelIdMeta,
        modelId.isAcceptableOrUnknown(data['model_id']!, _modelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_modelIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('model_type')) {
      context.handle(
        _modelTypeMeta,
        modelType.isAcceptableOrUnknown(data['model_type']!, _modelTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_modelTypeMeta);
    }
    if (data.containsKey('max_context_length')) {
      context.handle(
        _maxContextLengthMeta,
        maxContextLength.isAcceptableOrUnknown(
          data['max_context_length']!,
          _maxContextLengthMeta,
        ),
      );
    }
    if (data.containsKey('max_output_tokens')) {
      context.handle(
        _maxOutputTokensMeta,
        maxOutputTokens.isAcceptableOrUnknown(
          data['max_output_tokens']!,
          _maxOutputTokensMeta,
        ),
      );
    }
    if (data.containsKey('supports_streaming')) {
      context.handle(
        _supportsStreamingMeta,
        supportsStreaming.isAcceptableOrUnknown(
          data['supports_streaming']!,
          _supportsStreamingMeta,
        ),
      );
    }
    if (data.containsKey('supports_function_calling')) {
      context.handle(
        _supportsFunctionCallingMeta,
        supportsFunctionCalling.isAcceptableOrUnknown(
          data['supports_function_calling']!,
          _supportsFunctionCallingMeta,
        ),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('config_json')) {
      context.handle(
        _configJsonMeta,
        configJson.isAcceptableOrUnknown(data['config_json']!, _configJsonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  LlmModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LlmModel(
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      providerUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_uuid'],
      )!,
      modelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      modelType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_type'],
      )!,
      maxContextLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_context_length'],
      )!,
      maxOutputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_output_tokens'],
      )!,
      supportsStreaming: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}supports_streaming'],
      )!,
      supportsFunctionCalling: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}supports_function_calling'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      configJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}config_json'],
      ),
    );
  }

  @override
  $LlmModelsTable createAlias(String alias) {
    return $LlmModelsTable(attachedDatabase, alias);
  }
}

class LlmModel extends DataClass implements Insertable<LlmModel> {
  final String uuid;
  final DateTime createdAt;
  final DateTime? lastUpdatedAt;
  final DateTime? deletedAt;

  /// 关联的提供商 UUID
  final String providerUuid;

  /// 模型标识符 (如 "gpt-4", "claude-3-opus")
  final String modelId;

  /// 模型显示名称
  final String displayName;

  /// 模型类型 (chat, completion, embedding)
  final String modelType;

  /// 最大上下文长度
  final int maxContextLength;

  /// 最大输出 token 数
  final int maxOutputTokens;

  /// 是否支持流式输出
  final bool supportsStreaming;

  /// 是否支持 Function Calling
  final bool supportsFunctionCalling;

  /// 是否为默认模型
  final bool isDefault;

  /// 是否启用
  final bool isEnabled;

  /// 额外配置 (JSON)
  final String? configJson;
  const LlmModel({
    required this.uuid,
    required this.createdAt,
    this.lastUpdatedAt,
    this.deletedAt,
    required this.providerUuid,
    required this.modelId,
    required this.displayName,
    required this.modelType,
    required this.maxContextLength,
    required this.maxOutputTokens,
    required this.supportsStreaming,
    required this.supportsFunctionCalling,
    required this.isDefault,
    required this.isEnabled,
    this.configJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastUpdatedAt != null) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['provider_uuid'] = Variable<String>(providerUuid);
    map['model_id'] = Variable<String>(modelId);
    map['display_name'] = Variable<String>(displayName);
    map['model_type'] = Variable<String>(modelType);
    map['max_context_length'] = Variable<int>(maxContextLength);
    map['max_output_tokens'] = Variable<int>(maxOutputTokens);
    map['supports_streaming'] = Variable<bool>(supportsStreaming);
    map['supports_function_calling'] = Variable<bool>(supportsFunctionCalling);
    map['is_default'] = Variable<bool>(isDefault);
    map['is_enabled'] = Variable<bool>(isEnabled);
    if (!nullToAbsent || configJson != null) {
      map['config_json'] = Variable<String>(configJson);
    }
    return map;
  }

  LlmModelsCompanion toCompanion(bool nullToAbsent) {
    return LlmModelsCompanion(
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      lastUpdatedAt: lastUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      providerUuid: Value(providerUuid),
      modelId: Value(modelId),
      displayName: Value(displayName),
      modelType: Value(modelType),
      maxContextLength: Value(maxContextLength),
      maxOutputTokens: Value(maxOutputTokens),
      supportsStreaming: Value(supportsStreaming),
      supportsFunctionCalling: Value(supportsFunctionCalling),
      isDefault: Value(isDefault),
      isEnabled: Value(isEnabled),
      configJson: configJson == null && nullToAbsent
          ? const Value.absent()
          : Value(configJson),
    );
  }

  factory LlmModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LlmModel(
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdatedAt: serializer.fromJson<DateTime?>(json['lastUpdatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      providerUuid: serializer.fromJson<String>(json['providerUuid']),
      modelId: serializer.fromJson<String>(json['modelId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      modelType: serializer.fromJson<String>(json['modelType']),
      maxContextLength: serializer.fromJson<int>(json['maxContextLength']),
      maxOutputTokens: serializer.fromJson<int>(json['maxOutputTokens']),
      supportsStreaming: serializer.fromJson<bool>(json['supportsStreaming']),
      supportsFunctionCalling: serializer.fromJson<bool>(
        json['supportsFunctionCalling'],
      ),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      configJson: serializer.fromJson<String?>(json['configJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdatedAt': serializer.toJson<DateTime?>(lastUpdatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'providerUuid': serializer.toJson<String>(providerUuid),
      'modelId': serializer.toJson<String>(modelId),
      'displayName': serializer.toJson<String>(displayName),
      'modelType': serializer.toJson<String>(modelType),
      'maxContextLength': serializer.toJson<int>(maxContextLength),
      'maxOutputTokens': serializer.toJson<int>(maxOutputTokens),
      'supportsStreaming': serializer.toJson<bool>(supportsStreaming),
      'supportsFunctionCalling': serializer.toJson<bool>(
        supportsFunctionCalling,
      ),
      'isDefault': serializer.toJson<bool>(isDefault),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'configJson': serializer.toJson<String?>(configJson),
    };
  }

  LlmModel copyWith({
    String? uuid,
    DateTime? createdAt,
    Value<DateTime?> lastUpdatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? providerUuid,
    String? modelId,
    String? displayName,
    String? modelType,
    int? maxContextLength,
    int? maxOutputTokens,
    bool? supportsStreaming,
    bool? supportsFunctionCalling,
    bool? isDefault,
    bool? isEnabled,
    Value<String?> configJson = const Value.absent(),
  }) => LlmModel(
    uuid: uuid ?? this.uuid,
    createdAt: createdAt ?? this.createdAt,
    lastUpdatedAt: lastUpdatedAt.present
        ? lastUpdatedAt.value
        : this.lastUpdatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    providerUuid: providerUuid ?? this.providerUuid,
    modelId: modelId ?? this.modelId,
    displayName: displayName ?? this.displayName,
    modelType: modelType ?? this.modelType,
    maxContextLength: maxContextLength ?? this.maxContextLength,
    maxOutputTokens: maxOutputTokens ?? this.maxOutputTokens,
    supportsStreaming: supportsStreaming ?? this.supportsStreaming,
    supportsFunctionCalling:
        supportsFunctionCalling ?? this.supportsFunctionCalling,
    isDefault: isDefault ?? this.isDefault,
    isEnabled: isEnabled ?? this.isEnabled,
    configJson: configJson.present ? configJson.value : this.configJson,
  );
  LlmModel copyWithCompanion(LlmModelsCompanion data) {
    return LlmModel(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      providerUuid: data.providerUuid.present
          ? data.providerUuid.value
          : this.providerUuid,
      modelId: data.modelId.present ? data.modelId.value : this.modelId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      modelType: data.modelType.present ? data.modelType.value : this.modelType,
      maxContextLength: data.maxContextLength.present
          ? data.maxContextLength.value
          : this.maxContextLength,
      maxOutputTokens: data.maxOutputTokens.present
          ? data.maxOutputTokens.value
          : this.maxOutputTokens,
      supportsStreaming: data.supportsStreaming.present
          ? data.supportsStreaming.value
          : this.supportsStreaming,
      supportsFunctionCalling: data.supportsFunctionCalling.present
          ? data.supportsFunctionCalling.value
          : this.supportsFunctionCalling,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      configJson: data.configJson.present
          ? data.configJson.value
          : this.configJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LlmModel(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('providerUuid: $providerUuid, ')
          ..write('modelId: $modelId, ')
          ..write('displayName: $displayName, ')
          ..write('modelType: $modelType, ')
          ..write('maxContextLength: $maxContextLength, ')
          ..write('maxOutputTokens: $maxOutputTokens, ')
          ..write('supportsStreaming: $supportsStreaming, ')
          ..write('supportsFunctionCalling: $supportsFunctionCalling, ')
          ..write('isDefault: $isDefault, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('configJson: $configJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uuid,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    providerUuid,
    modelId,
    displayName,
    modelType,
    maxContextLength,
    maxOutputTokens,
    supportsStreaming,
    supportsFunctionCalling,
    isDefault,
    isEnabled,
    configJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LlmModel &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.deletedAt == this.deletedAt &&
          other.providerUuid == this.providerUuid &&
          other.modelId == this.modelId &&
          other.displayName == this.displayName &&
          other.modelType == this.modelType &&
          other.maxContextLength == this.maxContextLength &&
          other.maxOutputTokens == this.maxOutputTokens &&
          other.supportsStreaming == this.supportsStreaming &&
          other.supportsFunctionCalling == this.supportsFunctionCalling &&
          other.isDefault == this.isDefault &&
          other.isEnabled == this.isEnabled &&
          other.configJson == this.configJson);
}

class LlmModelsCompanion extends UpdateCompanion<LlmModel> {
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastUpdatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> providerUuid;
  final Value<String> modelId;
  final Value<String> displayName;
  final Value<String> modelType;
  final Value<int> maxContextLength;
  final Value<int> maxOutputTokens;
  final Value<bool> supportsStreaming;
  final Value<bool> supportsFunctionCalling;
  final Value<bool> isDefault;
  final Value<bool> isEnabled;
  final Value<String?> configJson;
  final Value<int> rowid;
  const LlmModelsCompanion({
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.providerUuid = const Value.absent(),
    this.modelId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.modelType = const Value.absent(),
    this.maxContextLength = const Value.absent(),
    this.maxOutputTokens = const Value.absent(),
    this.supportsStreaming = const Value.absent(),
    this.supportsFunctionCalling = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.configJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LlmModelsCompanion.insert({
    required String uuid,
    required DateTime createdAt,
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String providerUuid,
    required String modelId,
    required String displayName,
    required String modelType,
    this.maxContextLength = const Value.absent(),
    this.maxOutputTokens = const Value.absent(),
    this.supportsStreaming = const Value.absent(),
    this.supportsFunctionCalling = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.configJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid),
       createdAt = Value(createdAt),
       providerUuid = Value(providerUuid),
       modelId = Value(modelId),
       displayName = Value(displayName),
       modelType = Value(modelType);
  static Insertable<LlmModel> custom({
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? providerUuid,
    Expression<String>? modelId,
    Expression<String>? displayName,
    Expression<String>? modelType,
    Expression<int>? maxContextLength,
    Expression<int>? maxOutputTokens,
    Expression<bool>? supportsStreaming,
    Expression<bool>? supportsFunctionCalling,
    Expression<bool>? isDefault,
    Expression<bool>? isEnabled,
    Expression<String>? configJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (providerUuid != null) 'provider_uuid': providerUuid,
      if (modelId != null) 'model_id': modelId,
      if (displayName != null) 'display_name': displayName,
      if (modelType != null) 'model_type': modelType,
      if (maxContextLength != null) 'max_context_length': maxContextLength,
      if (maxOutputTokens != null) 'max_output_tokens': maxOutputTokens,
      if (supportsStreaming != null) 'supports_streaming': supportsStreaming,
      if (supportsFunctionCalling != null)
        'supports_function_calling': supportsFunctionCalling,
      if (isDefault != null) 'is_default': isDefault,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (configJson != null) 'config_json': configJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LlmModelsCompanion copyWith({
    Value<String>? uuid,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastUpdatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? providerUuid,
    Value<String>? modelId,
    Value<String>? displayName,
    Value<String>? modelType,
    Value<int>? maxContextLength,
    Value<int>? maxOutputTokens,
    Value<bool>? supportsStreaming,
    Value<bool>? supportsFunctionCalling,
    Value<bool>? isDefault,
    Value<bool>? isEnabled,
    Value<String?>? configJson,
    Value<int>? rowid,
  }) {
    return LlmModelsCompanion(
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      providerUuid: providerUuid ?? this.providerUuid,
      modelId: modelId ?? this.modelId,
      displayName: displayName ?? this.displayName,
      modelType: modelType ?? this.modelType,
      maxContextLength: maxContextLength ?? this.maxContextLength,
      maxOutputTokens: maxOutputTokens ?? this.maxOutputTokens,
      supportsStreaming: supportsStreaming ?? this.supportsStreaming,
      supportsFunctionCalling:
          supportsFunctionCalling ?? this.supportsFunctionCalling,
      isDefault: isDefault ?? this.isDefault,
      isEnabled: isEnabled ?? this.isEnabled,
      configJson: configJson ?? this.configJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (providerUuid.present) {
      map['provider_uuid'] = Variable<String>(providerUuid.value);
    }
    if (modelId.present) {
      map['model_id'] = Variable<String>(modelId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (modelType.present) {
      map['model_type'] = Variable<String>(modelType.value);
    }
    if (maxContextLength.present) {
      map['max_context_length'] = Variable<int>(maxContextLength.value);
    }
    if (maxOutputTokens.present) {
      map['max_output_tokens'] = Variable<int>(maxOutputTokens.value);
    }
    if (supportsStreaming.present) {
      map['supports_streaming'] = Variable<bool>(supportsStreaming.value);
    }
    if (supportsFunctionCalling.present) {
      map['supports_function_calling'] = Variable<bool>(
        supportsFunctionCalling.value,
      );
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (configJson.present) {
      map['config_json'] = Variable<String>(configJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LlmModelsCompanion(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('providerUuid: $providerUuid, ')
          ..write('modelId: $modelId, ')
          ..write('displayName: $displayName, ')
          ..write('modelType: $modelType, ')
          ..write('maxContextLength: $maxContextLength, ')
          ..write('maxOutputTokens: $maxOutputTokens, ')
          ..write('supportsStreaming: $supportsStreaming, ')
          ..write('supportsFunctionCalling: $supportsFunctionCalling, ')
          ..write('isDefault: $isDefault, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('configJson: $configJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PromptTemplatesTable extends PromptTemplates
    with TableInfo<$PromptTemplatesTable, PromptTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PromptTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdatedAtMeta = const VerificationMeta(
    'lastUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedAt =
      GeneratedColumn<DateTime>(
        'last_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _templateTypeMeta = const VerificationMeta(
    'templateType',
  );
  @override
  late final GeneratedColumn<String> templateType = GeneratedColumn<String>(
    'template_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variablesJsonMeta = const VerificationMeta(
    'variablesJson',
  );
  @override
  late final GeneratedColumn<String> variablesJson = GeneratedColumn<String>(
    'variables_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentVersionMeta = const VerificationMeta(
    'currentVersion',
  );
  @override
  late final GeneratedColumn<int> currentVersion = GeneratedColumn<int>(
    'current_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _isBuiltinMeta = const VerificationMeta(
    'isBuiltin',
  );
  @override
  late final GeneratedColumn<bool> isBuiltin = GeneratedColumn<bool>(
    'is_builtin',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_builtin" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    uuid,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    name,
    description,
    templateType,
    content,
    variablesJson,
    currentVersion,
    isBuiltin,
    isEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_prompt_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<PromptTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
        _lastUpdatedAtMeta,
        lastUpdatedAt.isAcceptableOrUnknown(
          data['last_updated_at']!,
          _lastUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('template_type')) {
      context.handle(
        _templateTypeMeta,
        templateType.isAcceptableOrUnknown(
          data['template_type']!,
          _templateTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_templateTypeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('variables_json')) {
      context.handle(
        _variablesJsonMeta,
        variablesJson.isAcceptableOrUnknown(
          data['variables_json']!,
          _variablesJsonMeta,
        ),
      );
    }
    if (data.containsKey('current_version')) {
      context.handle(
        _currentVersionMeta,
        currentVersion.isAcceptableOrUnknown(
          data['current_version']!,
          _currentVersionMeta,
        ),
      );
    }
    if (data.containsKey('is_builtin')) {
      context.handle(
        _isBuiltinMeta,
        isBuiltin.isAcceptableOrUnknown(data['is_builtin']!, _isBuiltinMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  PromptTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PromptTemplate(
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      templateType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_type'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      variablesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variables_json'],
      ),
      currentVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_version'],
      )!,
      isBuiltin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_builtin'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
    );
  }

  @override
  $PromptTemplatesTable createAlias(String alias) {
    return $PromptTemplatesTable(attachedDatabase, alias);
  }
}

class PromptTemplate extends DataClass implements Insertable<PromptTemplate> {
  final String uuid;
  final DateTime createdAt;
  final DateTime? lastUpdatedAt;
  final DateTime? deletedAt;

  /// 模板名称
  final String name;

  /// 模板描述
  final String? description;

  /// 模板类型 (system, user, assistant, function)
  final String templateType;

  /// 当前内容 (可编辑)
  final String content;

  /// 变量列表 (JSON 数组)
  final String? variablesJson;

  /// 当前版本号
  final int currentVersion;

  /// 是否为系统内置
  final bool isBuiltin;

  /// 是否启用
  final bool isEnabled;
  const PromptTemplate({
    required this.uuid,
    required this.createdAt,
    this.lastUpdatedAt,
    this.deletedAt,
    required this.name,
    this.description,
    required this.templateType,
    required this.content,
    this.variablesJson,
    required this.currentVersion,
    required this.isBuiltin,
    required this.isEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastUpdatedAt != null) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['template_type'] = Variable<String>(templateType);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || variablesJson != null) {
      map['variables_json'] = Variable<String>(variablesJson);
    }
    map['current_version'] = Variable<int>(currentVersion);
    map['is_builtin'] = Variable<bool>(isBuiltin);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  PromptTemplatesCompanion toCompanion(bool nullToAbsent) {
    return PromptTemplatesCompanion(
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      lastUpdatedAt: lastUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      templateType: Value(templateType),
      content: Value(content),
      variablesJson: variablesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(variablesJson),
      currentVersion: Value(currentVersion),
      isBuiltin: Value(isBuiltin),
      isEnabled: Value(isEnabled),
    );
  }

  factory PromptTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PromptTemplate(
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdatedAt: serializer.fromJson<DateTime?>(json['lastUpdatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      templateType: serializer.fromJson<String>(json['templateType']),
      content: serializer.fromJson<String>(json['content']),
      variablesJson: serializer.fromJson<String?>(json['variablesJson']),
      currentVersion: serializer.fromJson<int>(json['currentVersion']),
      isBuiltin: serializer.fromJson<bool>(json['isBuiltin']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdatedAt': serializer.toJson<DateTime?>(lastUpdatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'templateType': serializer.toJson<String>(templateType),
      'content': serializer.toJson<String>(content),
      'variablesJson': serializer.toJson<String?>(variablesJson),
      'currentVersion': serializer.toJson<int>(currentVersion),
      'isBuiltin': serializer.toJson<bool>(isBuiltin),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  PromptTemplate copyWith({
    String? uuid,
    DateTime? createdAt,
    Value<DateTime?> lastUpdatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? name,
    Value<String?> description = const Value.absent(),
    String? templateType,
    String? content,
    Value<String?> variablesJson = const Value.absent(),
    int? currentVersion,
    bool? isBuiltin,
    bool? isEnabled,
  }) => PromptTemplate(
    uuid: uuid ?? this.uuid,
    createdAt: createdAt ?? this.createdAt,
    lastUpdatedAt: lastUpdatedAt.present
        ? lastUpdatedAt.value
        : this.lastUpdatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    templateType: templateType ?? this.templateType,
    content: content ?? this.content,
    variablesJson: variablesJson.present
        ? variablesJson.value
        : this.variablesJson,
    currentVersion: currentVersion ?? this.currentVersion,
    isBuiltin: isBuiltin ?? this.isBuiltin,
    isEnabled: isEnabled ?? this.isEnabled,
  );
  PromptTemplate copyWithCompanion(PromptTemplatesCompanion data) {
    return PromptTemplate(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      templateType: data.templateType.present
          ? data.templateType.value
          : this.templateType,
      content: data.content.present ? data.content.value : this.content,
      variablesJson: data.variablesJson.present
          ? data.variablesJson.value
          : this.variablesJson,
      currentVersion: data.currentVersion.present
          ? data.currentVersion.value
          : this.currentVersion,
      isBuiltin: data.isBuiltin.present ? data.isBuiltin.value : this.isBuiltin,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PromptTemplate(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('templateType: $templateType, ')
          ..write('content: $content, ')
          ..write('variablesJson: $variablesJson, ')
          ..write('currentVersion: $currentVersion, ')
          ..write('isBuiltin: $isBuiltin, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uuid,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    name,
    description,
    templateType,
    content,
    variablesJson,
    currentVersion,
    isBuiltin,
    isEnabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PromptTemplate &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.deletedAt == this.deletedAt &&
          other.name == this.name &&
          other.description == this.description &&
          other.templateType == this.templateType &&
          other.content == this.content &&
          other.variablesJson == this.variablesJson &&
          other.currentVersion == this.currentVersion &&
          other.isBuiltin == this.isBuiltin &&
          other.isEnabled == this.isEnabled);
}

class PromptTemplatesCompanion extends UpdateCompanion<PromptTemplate> {
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastUpdatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> templateType;
  final Value<String> content;
  final Value<String?> variablesJson;
  final Value<int> currentVersion;
  final Value<bool> isBuiltin;
  final Value<bool> isEnabled;
  final Value<int> rowid;
  const PromptTemplatesCompanion({
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.templateType = const Value.absent(),
    this.content = const Value.absent(),
    this.variablesJson = const Value.absent(),
    this.currentVersion = const Value.absent(),
    this.isBuiltin = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PromptTemplatesCompanion.insert({
    required String uuid,
    required DateTime createdAt,
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required String templateType,
    required String content,
    this.variablesJson = const Value.absent(),
    this.currentVersion = const Value.absent(),
    this.isBuiltin = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid),
       createdAt = Value(createdAt),
       name = Value(name),
       templateType = Value(templateType),
       content = Value(content);
  static Insertable<PromptTemplate> custom({
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? templateType,
    Expression<String>? content,
    Expression<String>? variablesJson,
    Expression<int>? currentVersion,
    Expression<bool>? isBuiltin,
    Expression<bool>? isEnabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (templateType != null) 'template_type': templateType,
      if (content != null) 'content': content,
      if (variablesJson != null) 'variables_json': variablesJson,
      if (currentVersion != null) 'current_version': currentVersion,
      if (isBuiltin != null) 'is_builtin': isBuiltin,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PromptTemplatesCompanion copyWith({
    Value<String>? uuid,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastUpdatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? templateType,
    Value<String>? content,
    Value<String?>? variablesJson,
    Value<int>? currentVersion,
    Value<bool>? isBuiltin,
    Value<bool>? isEnabled,
    Value<int>? rowid,
  }) {
    return PromptTemplatesCompanion(
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      name: name ?? this.name,
      description: description ?? this.description,
      templateType: templateType ?? this.templateType,
      content: content ?? this.content,
      variablesJson: variablesJson ?? this.variablesJson,
      currentVersion: currentVersion ?? this.currentVersion,
      isBuiltin: isBuiltin ?? this.isBuiltin,
      isEnabled: isEnabled ?? this.isEnabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (templateType.present) {
      map['template_type'] = Variable<String>(templateType.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (variablesJson.present) {
      map['variables_json'] = Variable<String>(variablesJson.value);
    }
    if (currentVersion.present) {
      map['current_version'] = Variable<int>(currentVersion.value);
    }
    if (isBuiltin.present) {
      map['is_builtin'] = Variable<bool>(isBuiltin.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PromptTemplatesCompanion(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('templateType: $templateType, ')
          ..write('content: $content, ')
          ..write('variablesJson: $variablesJson, ')
          ..write('currentVersion: $currentVersion, ')
          ..write('isBuiltin: $isBuiltin, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PromptVersionsTable extends PromptVersions
    with TableInfo<$PromptVersionsTable, PromptVersion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PromptVersionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateUuidMeta = const VerificationMeta(
    'templateUuid',
  );
  @override
  late final GeneratedColumn<String> templateUuid = GeneratedColumn<String>(
    'template_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES t_prompt_templates (uuid)',
    ),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variablesJsonMeta = const VerificationMeta(
    'variablesJson',
  );
  @override
  late final GeneratedColumn<String> variablesJson = GeneratedColumn<String>(
    'variables_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHashMeta = const VerificationMeta(
    'contentHash',
  );
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
    'content_hash',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 64,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changeNoteMeta = const VerificationMeta(
    'changeNote',
  );
  @override
  late final GeneratedColumn<String> changeNote = GeneratedColumn<String>(
    'change_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    uuid,
    templateUuid,
    version,
    content,
    variablesJson,
    contentHash,
    createdAt,
    changeNote,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_prompt_versions';
  @override
  VerificationContext validateIntegrity(
    Insertable<PromptVersion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('template_uuid')) {
      context.handle(
        _templateUuidMeta,
        templateUuid.isAcceptableOrUnknown(
          data['template_uuid']!,
          _templateUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_templateUuidMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('variables_json')) {
      context.handle(
        _variablesJsonMeta,
        variablesJson.isAcceptableOrUnknown(
          data['variables_json']!,
          _variablesJsonMeta,
        ),
      );
    }
    if (data.containsKey('content_hash')) {
      context.handle(
        _contentHashMeta,
        contentHash.isAcceptableOrUnknown(
          data['content_hash']!,
          _contentHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentHashMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('change_note')) {
      context.handle(
        _changeNoteMeta,
        changeNote.isAcceptableOrUnknown(data['change_note']!, _changeNoteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  PromptVersion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PromptVersion(
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      templateUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_uuid'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      variablesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variables_json'],
      ),
      contentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_hash'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      changeNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}change_note'],
      ),
    );
  }

  @override
  $PromptVersionsTable createAlias(String alias) {
    return $PromptVersionsTable(attachedDatabase, alias);
  }
}

class PromptVersion extends DataClass implements Insertable<PromptVersion> {
  final String uuid;

  /// 关联的模板 UUID
  final String templateUuid;

  /// 版本号
  final int version;

  /// 版本内容 (不可变)
  final String content;

  /// 变量列表 (JSON 数组，不可变)
  final String? variablesJson;

  /// 内容哈希 (用于完整性校验)
  final String contentHash;

  /// 创建时间
  final DateTime createdAt;

  /// 创建说明
  final String? changeNote;
  const PromptVersion({
    required this.uuid,
    required this.templateUuid,
    required this.version,
    required this.content,
    this.variablesJson,
    required this.contentHash,
    required this.createdAt,
    this.changeNote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['template_uuid'] = Variable<String>(templateUuid);
    map['version'] = Variable<int>(version);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || variablesJson != null) {
      map['variables_json'] = Variable<String>(variablesJson);
    }
    map['content_hash'] = Variable<String>(contentHash);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || changeNote != null) {
      map['change_note'] = Variable<String>(changeNote);
    }
    return map;
  }

  PromptVersionsCompanion toCompanion(bool nullToAbsent) {
    return PromptVersionsCompanion(
      uuid: Value(uuid),
      templateUuid: Value(templateUuid),
      version: Value(version),
      content: Value(content),
      variablesJson: variablesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(variablesJson),
      contentHash: Value(contentHash),
      createdAt: Value(createdAt),
      changeNote: changeNote == null && nullToAbsent
          ? const Value.absent()
          : Value(changeNote),
    );
  }

  factory PromptVersion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PromptVersion(
      uuid: serializer.fromJson<String>(json['uuid']),
      templateUuid: serializer.fromJson<String>(json['templateUuid']),
      version: serializer.fromJson<int>(json['version']),
      content: serializer.fromJson<String>(json['content']),
      variablesJson: serializer.fromJson<String?>(json['variablesJson']),
      contentHash: serializer.fromJson<String>(json['contentHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      changeNote: serializer.fromJson<String?>(json['changeNote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'templateUuid': serializer.toJson<String>(templateUuid),
      'version': serializer.toJson<int>(version),
      'content': serializer.toJson<String>(content),
      'variablesJson': serializer.toJson<String?>(variablesJson),
      'contentHash': serializer.toJson<String>(contentHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'changeNote': serializer.toJson<String?>(changeNote),
    };
  }

  PromptVersion copyWith({
    String? uuid,
    String? templateUuid,
    int? version,
    String? content,
    Value<String?> variablesJson = const Value.absent(),
    String? contentHash,
    DateTime? createdAt,
    Value<String?> changeNote = const Value.absent(),
  }) => PromptVersion(
    uuid: uuid ?? this.uuid,
    templateUuid: templateUuid ?? this.templateUuid,
    version: version ?? this.version,
    content: content ?? this.content,
    variablesJson: variablesJson.present
        ? variablesJson.value
        : this.variablesJson,
    contentHash: contentHash ?? this.contentHash,
    createdAt: createdAt ?? this.createdAt,
    changeNote: changeNote.present ? changeNote.value : this.changeNote,
  );
  PromptVersion copyWithCompanion(PromptVersionsCompanion data) {
    return PromptVersion(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      templateUuid: data.templateUuid.present
          ? data.templateUuid.value
          : this.templateUuid,
      version: data.version.present ? data.version.value : this.version,
      content: data.content.present ? data.content.value : this.content,
      variablesJson: data.variablesJson.present
          ? data.variablesJson.value
          : this.variablesJson,
      contentHash: data.contentHash.present
          ? data.contentHash.value
          : this.contentHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      changeNote: data.changeNote.present
          ? data.changeNote.value
          : this.changeNote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PromptVersion(')
          ..write('uuid: $uuid, ')
          ..write('templateUuid: $templateUuid, ')
          ..write('version: $version, ')
          ..write('content: $content, ')
          ..write('variablesJson: $variablesJson, ')
          ..write('contentHash: $contentHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('changeNote: $changeNote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uuid,
    templateUuid,
    version,
    content,
    variablesJson,
    contentHash,
    createdAt,
    changeNote,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PromptVersion &&
          other.uuid == this.uuid &&
          other.templateUuid == this.templateUuid &&
          other.version == this.version &&
          other.content == this.content &&
          other.variablesJson == this.variablesJson &&
          other.contentHash == this.contentHash &&
          other.createdAt == this.createdAt &&
          other.changeNote == this.changeNote);
}

class PromptVersionsCompanion extends UpdateCompanion<PromptVersion> {
  final Value<String> uuid;
  final Value<String> templateUuid;
  final Value<int> version;
  final Value<String> content;
  final Value<String?> variablesJson;
  final Value<String> contentHash;
  final Value<DateTime> createdAt;
  final Value<String?> changeNote;
  final Value<int> rowid;
  const PromptVersionsCompanion({
    this.uuid = const Value.absent(),
    this.templateUuid = const Value.absent(),
    this.version = const Value.absent(),
    this.content = const Value.absent(),
    this.variablesJson = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.changeNote = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PromptVersionsCompanion.insert({
    required String uuid,
    required String templateUuid,
    required int version,
    required String content,
    this.variablesJson = const Value.absent(),
    required String contentHash,
    required DateTime createdAt,
    this.changeNote = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid),
       templateUuid = Value(templateUuid),
       version = Value(version),
       content = Value(content),
       contentHash = Value(contentHash),
       createdAt = Value(createdAt);
  static Insertable<PromptVersion> custom({
    Expression<String>? uuid,
    Expression<String>? templateUuid,
    Expression<int>? version,
    Expression<String>? content,
    Expression<String>? variablesJson,
    Expression<String>? contentHash,
    Expression<DateTime>? createdAt,
    Expression<String>? changeNote,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (templateUuid != null) 'template_uuid': templateUuid,
      if (version != null) 'version': version,
      if (content != null) 'content': content,
      if (variablesJson != null) 'variables_json': variablesJson,
      if (contentHash != null) 'content_hash': contentHash,
      if (createdAt != null) 'created_at': createdAt,
      if (changeNote != null) 'change_note': changeNote,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PromptVersionsCompanion copyWith({
    Value<String>? uuid,
    Value<String>? templateUuid,
    Value<int>? version,
    Value<String>? content,
    Value<String?>? variablesJson,
    Value<String>? contentHash,
    Value<DateTime>? createdAt,
    Value<String?>? changeNote,
    Value<int>? rowid,
  }) {
    return PromptVersionsCompanion(
      uuid: uuid ?? this.uuid,
      templateUuid: templateUuid ?? this.templateUuid,
      version: version ?? this.version,
      content: content ?? this.content,
      variablesJson: variablesJson ?? this.variablesJson,
      contentHash: contentHash ?? this.contentHash,
      createdAt: createdAt ?? this.createdAt,
      changeNote: changeNote ?? this.changeNote,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (templateUuid.present) {
      map['template_uuid'] = Variable<String>(templateUuid.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (variablesJson.present) {
      map['variables_json'] = Variable<String>(variablesJson.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (changeNote.present) {
      map['change_note'] = Variable<String>(changeNote.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PromptVersionsCompanion(')
          ..write('uuid: $uuid, ')
          ..write('templateUuid: $templateUuid, ')
          ..write('version: $version, ')
          ..write('content: $content, ')
          ..write('variablesJson: $variablesJson, ')
          ..write('contentHash: $contentHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('changeNote: $changeNote, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PromptSkillBindingsTable extends PromptSkillBindings
    with TableInfo<$PromptSkillBindingsTable, PromptSkillBinding> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PromptSkillBindingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdatedAtMeta = const VerificationMeta(
    'lastUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedAt =
      GeneratedColumn<DateTime>(
        'last_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _promptTemplateUuidMeta =
      const VerificationMeta('promptTemplateUuid');
  @override
  late final GeneratedColumn<String> promptTemplateUuid =
      GeneratedColumn<String>(
        'prompt_template_uuid',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES t_prompt_templates (uuid)',
        ),
      );
  static const VerificationMeta _skillIdMeta = const VerificationMeta(
    'skillId',
  );
  @override
  late final GeneratedColumn<int> skillId = GeneratedColumn<int>(
    'skill_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bindingTypeMeta = const VerificationMeta(
    'bindingType',
  );
  @override
  late final GeneratedColumn<String> bindingType = GeneratedColumn<String>(
    'binding_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    promptTemplateUuid,
    skillId,
    bindingType,
    priority,
    isEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_prompt_skill_bindings';
  @override
  VerificationContext validateIntegrity(
    Insertable<PromptSkillBinding> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
        _lastUpdatedAtMeta,
        lastUpdatedAt.isAcceptableOrUnknown(
          data['last_updated_at']!,
          _lastUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('prompt_template_uuid')) {
      context.handle(
        _promptTemplateUuidMeta,
        promptTemplateUuid.isAcceptableOrUnknown(
          data['prompt_template_uuid']!,
          _promptTemplateUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_promptTemplateUuidMeta);
    }
    if (data.containsKey('skill_id')) {
      context.handle(
        _skillIdMeta,
        skillId.isAcceptableOrUnknown(data['skill_id']!, _skillIdMeta),
      );
    } else if (isInserting) {
      context.missing(_skillIdMeta);
    }
    if (data.containsKey('binding_type')) {
      context.handle(
        _bindingTypeMeta,
        bindingType.isAcceptableOrUnknown(
          data['binding_type']!,
          _bindingTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bindingTypeMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PromptSkillBinding map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PromptSkillBinding(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      promptTemplateUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_template_uuid'],
      )!,
      skillId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skill_id'],
      )!,
      bindingType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}binding_type'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
    );
  }

  @override
  $PromptSkillBindingsTable createAlias(String alias) {
    return $PromptSkillBindingsTable(attachedDatabase, alias);
  }
}

class PromptSkillBinding extends DataClass
    implements Insertable<PromptSkillBinding> {
  final int id;
  final DateTime createdAt;
  final DateTime? lastUpdatedAt;
  final DateTime? deletedAt;

  /// 关联的 Prompt 模板 UUID
  final String promptTemplateUuid;

  /// 关联的技法 ID (来自 common 模块的 Skills 表)
  final int skillId;

  /// 绑定类型 (system_prompt, user_guide, analysis_template)
  final String bindingType;

  /// 优先级 (数字越小优先级越高)
  final int priority;

  /// 是否启用
  final bool isEnabled;
  const PromptSkillBinding({
    required this.id,
    required this.createdAt,
    this.lastUpdatedAt,
    this.deletedAt,
    required this.promptTemplateUuid,
    required this.skillId,
    required this.bindingType,
    required this.priority,
    required this.isEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastUpdatedAt != null) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['prompt_template_uuid'] = Variable<String>(promptTemplateUuid);
    map['skill_id'] = Variable<int>(skillId);
    map['binding_type'] = Variable<String>(bindingType);
    map['priority'] = Variable<int>(priority);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  PromptSkillBindingsCompanion toCompanion(bool nullToAbsent) {
    return PromptSkillBindingsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      lastUpdatedAt: lastUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      promptTemplateUuid: Value(promptTemplateUuid),
      skillId: Value(skillId),
      bindingType: Value(bindingType),
      priority: Value(priority),
      isEnabled: Value(isEnabled),
    );
  }

  factory PromptSkillBinding.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PromptSkillBinding(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdatedAt: serializer.fromJson<DateTime?>(json['lastUpdatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      promptTemplateUuid: serializer.fromJson<String>(
        json['promptTemplateUuid'],
      ),
      skillId: serializer.fromJson<int>(json['skillId']),
      bindingType: serializer.fromJson<String>(json['bindingType']),
      priority: serializer.fromJson<int>(json['priority']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdatedAt': serializer.toJson<DateTime?>(lastUpdatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'promptTemplateUuid': serializer.toJson<String>(promptTemplateUuid),
      'skillId': serializer.toJson<int>(skillId),
      'bindingType': serializer.toJson<String>(bindingType),
      'priority': serializer.toJson<int>(priority),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  PromptSkillBinding copyWith({
    int? id,
    DateTime? createdAt,
    Value<DateTime?> lastUpdatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? promptTemplateUuid,
    int? skillId,
    String? bindingType,
    int? priority,
    bool? isEnabled,
  }) => PromptSkillBinding(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    lastUpdatedAt: lastUpdatedAt.present
        ? lastUpdatedAt.value
        : this.lastUpdatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    promptTemplateUuid: promptTemplateUuid ?? this.promptTemplateUuid,
    skillId: skillId ?? this.skillId,
    bindingType: bindingType ?? this.bindingType,
    priority: priority ?? this.priority,
    isEnabled: isEnabled ?? this.isEnabled,
  );
  PromptSkillBinding copyWithCompanion(PromptSkillBindingsCompanion data) {
    return PromptSkillBinding(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      promptTemplateUuid: data.promptTemplateUuid.present
          ? data.promptTemplateUuid.value
          : this.promptTemplateUuid,
      skillId: data.skillId.present ? data.skillId.value : this.skillId,
      bindingType: data.bindingType.present
          ? data.bindingType.value
          : this.bindingType,
      priority: data.priority.present ? data.priority.value : this.priority,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PromptSkillBinding(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('promptTemplateUuid: $promptTemplateUuid, ')
          ..write('skillId: $skillId, ')
          ..write('bindingType: $bindingType, ')
          ..write('priority: $priority, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    promptTemplateUuid,
    skillId,
    bindingType,
    priority,
    isEnabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PromptSkillBinding &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.deletedAt == this.deletedAt &&
          other.promptTemplateUuid == this.promptTemplateUuid &&
          other.skillId == this.skillId &&
          other.bindingType == this.bindingType &&
          other.priority == this.priority &&
          other.isEnabled == this.isEnabled);
}

class PromptSkillBindingsCompanion extends UpdateCompanion<PromptSkillBinding> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastUpdatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> promptTemplateUuid;
  final Value<int> skillId;
  final Value<String> bindingType;
  final Value<int> priority;
  final Value<bool> isEnabled;
  const PromptSkillBindingsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.promptTemplateUuid = const Value.absent(),
    this.skillId = const Value.absent(),
    this.bindingType = const Value.absent(),
    this.priority = const Value.absent(),
    this.isEnabled = const Value.absent(),
  });
  PromptSkillBindingsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime createdAt,
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String promptTemplateUuid,
    required int skillId,
    required String bindingType,
    this.priority = const Value.absent(),
    this.isEnabled = const Value.absent(),
  }) : createdAt = Value(createdAt),
       promptTemplateUuid = Value(promptTemplateUuid),
       skillId = Value(skillId),
       bindingType = Value(bindingType);
  static Insertable<PromptSkillBinding> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? promptTemplateUuid,
    Expression<int>? skillId,
    Expression<String>? bindingType,
    Expression<int>? priority,
    Expression<bool>? isEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (promptTemplateUuid != null)
        'prompt_template_uuid': promptTemplateUuid,
      if (skillId != null) 'skill_id': skillId,
      if (bindingType != null) 'binding_type': bindingType,
      if (priority != null) 'priority': priority,
      if (isEnabled != null) 'is_enabled': isEnabled,
    });
  }

  PromptSkillBindingsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastUpdatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? promptTemplateUuid,
    Value<int>? skillId,
    Value<String>? bindingType,
    Value<int>? priority,
    Value<bool>? isEnabled,
  }) {
    return PromptSkillBindingsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      promptTemplateUuid: promptTemplateUuid ?? this.promptTemplateUuid,
      skillId: skillId ?? this.skillId,
      bindingType: bindingType ?? this.bindingType,
      priority: priority ?? this.priority,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (promptTemplateUuid.present) {
      map['prompt_template_uuid'] = Variable<String>(promptTemplateUuid.value);
    }
    if (skillId.present) {
      map['skill_id'] = Variable<int>(skillId.value);
    }
    if (bindingType.present) {
      map['binding_type'] = Variable<String>(bindingType.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PromptSkillBindingsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('promptTemplateUuid: $promptTemplateUuid, ')
          ..write('skillId: $skillId, ')
          ..write('bindingType: $bindingType, ')
          ..write('priority: $priority, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }
}

class $AiPersonasTable extends AiPersonas
    with TableInfo<$AiPersonasTable, AiPersona> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiPersonasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdatedAtMeta = const VerificationMeta(
    'lastUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedAt =
      GeneratedColumn<DateTime>(
        'last_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelUuidMeta = const VerificationMeta(
    'modelUuid',
  );
  @override
  late final GeneratedColumn<String> modelUuid = GeneratedColumn<String>(
    'model_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES t_llm_models (uuid)',
    ),
  );
  static const VerificationMeta _systemPromptUuidMeta = const VerificationMeta(
    'systemPromptUuid',
  );
  @override
  late final GeneratedColumn<String> systemPromptUuid = GeneratedColumn<String>(
    'system_prompt_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES t_prompt_templates (uuid)',
    ),
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.7),
  );
  static const VerificationMeta _topPMeta = const VerificationMeta('topP');
  @override
  late final GeneratedColumn<double> topP = GeneratedColumn<double>(
    'top_p',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _maxTokensMeta = const VerificationMeta(
    'maxTokens',
  );
  @override
  late final GeneratedColumn<int> maxTokens = GeneratedColumn<int>(
    'max_tokens',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2048),
  );
  static const VerificationMeta _personalityJsonMeta = const VerificationMeta(
    'personalityJson',
  );
  @override
  late final GeneratedColumn<String> personalityJson = GeneratedColumn<String>(
    'personality_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expertiseJsonMeta = const VerificationMeta(
    'expertiseJson',
  );
  @override
  late final GeneratedColumn<String> expertiseJson = GeneratedColumn<String>(
    'expertise_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    uuid,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    name,
    avatarUrl,
    description,
    modelUuid,
    systemPromptUuid,
    temperature,
    topP,
    maxTokens,
    personalityJson,
    expertiseJson,
    isDefault,
    isEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_ai_personas';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiPersona> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
        _lastUpdatedAtMeta,
        lastUpdatedAt.isAcceptableOrUnknown(
          data['last_updated_at']!,
          _lastUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('model_uuid')) {
      context.handle(
        _modelUuidMeta,
        modelUuid.isAcceptableOrUnknown(data['model_uuid']!, _modelUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_modelUuidMeta);
    }
    if (data.containsKey('system_prompt_uuid')) {
      context.handle(
        _systemPromptUuidMeta,
        systemPromptUuid.isAcceptableOrUnknown(
          data['system_prompt_uuid']!,
          _systemPromptUuidMeta,
        ),
      );
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    }
    if (data.containsKey('top_p')) {
      context.handle(
        _topPMeta,
        topP.isAcceptableOrUnknown(data['top_p']!, _topPMeta),
      );
    }
    if (data.containsKey('max_tokens')) {
      context.handle(
        _maxTokensMeta,
        maxTokens.isAcceptableOrUnknown(data['max_tokens']!, _maxTokensMeta),
      );
    }
    if (data.containsKey('personality_json')) {
      context.handle(
        _personalityJsonMeta,
        personalityJson.isAcceptableOrUnknown(
          data['personality_json']!,
          _personalityJsonMeta,
        ),
      );
    }
    if (data.containsKey('expertise_json')) {
      context.handle(
        _expertiseJsonMeta,
        expertiseJson.isAcceptableOrUnknown(
          data['expertise_json']!,
          _expertiseJsonMeta,
        ),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  AiPersona map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiPersona(
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      modelUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_uuid'],
      )!,
      systemPromptUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_prompt_uuid'],
      ),
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      )!,
      topP: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}top_p'],
      )!,
      maxTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_tokens'],
      )!,
      personalityJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}personality_json'],
      ),
      expertiseJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expertise_json'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
    );
  }

  @override
  $AiPersonasTable createAlias(String alias) {
    return $AiPersonasTable(attachedDatabase, alias);
  }
}

class AiPersona extends DataClass implements Insertable<AiPersona> {
  final String uuid;
  final DateTime createdAt;
  final DateTime? lastUpdatedAt;
  final DateTime? deletedAt;

  /// 人设名称
  final String name;

  /// 人设头像 URL 或 base64
  final String? avatarUrl;

  /// 人设描述
  final String? description;

  /// 关联的 LLM 模型 UUID
  final String modelUuid;

  /// 关联的系统 Prompt 模板 UUID
  final String? systemPromptUuid;

  /// 温度参数 (0.0-2.0)
  final double temperature;

  /// Top P 参数
  final double topP;

  /// 最大输出 token
  final int maxTokens;

  /// 人设性格特征 (JSON)
  final String? personalityJson;

  /// 专业领域 (JSON 数组)
  final String? expertiseJson;

  /// 是否为默认人设
  final bool isDefault;

  /// 是否启用
  final bool isEnabled;
  const AiPersona({
    required this.uuid,
    required this.createdAt,
    this.lastUpdatedAt,
    this.deletedAt,
    required this.name,
    this.avatarUrl,
    this.description,
    required this.modelUuid,
    this.systemPromptUuid,
    required this.temperature,
    required this.topP,
    required this.maxTokens,
    this.personalityJson,
    this.expertiseJson,
    required this.isDefault,
    required this.isEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastUpdatedAt != null) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['model_uuid'] = Variable<String>(modelUuid);
    if (!nullToAbsent || systemPromptUuid != null) {
      map['system_prompt_uuid'] = Variable<String>(systemPromptUuid);
    }
    map['temperature'] = Variable<double>(temperature);
    map['top_p'] = Variable<double>(topP);
    map['max_tokens'] = Variable<int>(maxTokens);
    if (!nullToAbsent || personalityJson != null) {
      map['personality_json'] = Variable<String>(personalityJson);
    }
    if (!nullToAbsent || expertiseJson != null) {
      map['expertise_json'] = Variable<String>(expertiseJson);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  AiPersonasCompanion toCompanion(bool nullToAbsent) {
    return AiPersonasCompanion(
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      lastUpdatedAt: lastUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      name: Value(name),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      modelUuid: Value(modelUuid),
      systemPromptUuid: systemPromptUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(systemPromptUuid),
      temperature: Value(temperature),
      topP: Value(topP),
      maxTokens: Value(maxTokens),
      personalityJson: personalityJson == null && nullToAbsent
          ? const Value.absent()
          : Value(personalityJson),
      expertiseJson: expertiseJson == null && nullToAbsent
          ? const Value.absent()
          : Value(expertiseJson),
      isDefault: Value(isDefault),
      isEnabled: Value(isEnabled),
    );
  }

  factory AiPersona.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiPersona(
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdatedAt: serializer.fromJson<DateTime?>(json['lastUpdatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      name: serializer.fromJson<String>(json['name']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      description: serializer.fromJson<String?>(json['description']),
      modelUuid: serializer.fromJson<String>(json['modelUuid']),
      systemPromptUuid: serializer.fromJson<String?>(json['systemPromptUuid']),
      temperature: serializer.fromJson<double>(json['temperature']),
      topP: serializer.fromJson<double>(json['topP']),
      maxTokens: serializer.fromJson<int>(json['maxTokens']),
      personalityJson: serializer.fromJson<String?>(json['personalityJson']),
      expertiseJson: serializer.fromJson<String?>(json['expertiseJson']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdatedAt': serializer.toJson<DateTime?>(lastUpdatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'name': serializer.toJson<String>(name),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'description': serializer.toJson<String?>(description),
      'modelUuid': serializer.toJson<String>(modelUuid),
      'systemPromptUuid': serializer.toJson<String?>(systemPromptUuid),
      'temperature': serializer.toJson<double>(temperature),
      'topP': serializer.toJson<double>(topP),
      'maxTokens': serializer.toJson<int>(maxTokens),
      'personalityJson': serializer.toJson<String?>(personalityJson),
      'expertiseJson': serializer.toJson<String?>(expertiseJson),
      'isDefault': serializer.toJson<bool>(isDefault),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  AiPersona copyWith({
    String? uuid,
    DateTime? createdAt,
    Value<DateTime?> lastUpdatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? name,
    Value<String?> avatarUrl = const Value.absent(),
    Value<String?> description = const Value.absent(),
    String? modelUuid,
    Value<String?> systemPromptUuid = const Value.absent(),
    double? temperature,
    double? topP,
    int? maxTokens,
    Value<String?> personalityJson = const Value.absent(),
    Value<String?> expertiseJson = const Value.absent(),
    bool? isDefault,
    bool? isEnabled,
  }) => AiPersona(
    uuid: uuid ?? this.uuid,
    createdAt: createdAt ?? this.createdAt,
    lastUpdatedAt: lastUpdatedAt.present
        ? lastUpdatedAt.value
        : this.lastUpdatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    name: name ?? this.name,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    description: description.present ? description.value : this.description,
    modelUuid: modelUuid ?? this.modelUuid,
    systemPromptUuid: systemPromptUuid.present
        ? systemPromptUuid.value
        : this.systemPromptUuid,
    temperature: temperature ?? this.temperature,
    topP: topP ?? this.topP,
    maxTokens: maxTokens ?? this.maxTokens,
    personalityJson: personalityJson.present
        ? personalityJson.value
        : this.personalityJson,
    expertiseJson: expertiseJson.present
        ? expertiseJson.value
        : this.expertiseJson,
    isDefault: isDefault ?? this.isDefault,
    isEnabled: isEnabled ?? this.isEnabled,
  );
  AiPersona copyWithCompanion(AiPersonasCompanion data) {
    return AiPersona(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      name: data.name.present ? data.name.value : this.name,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      description: data.description.present
          ? data.description.value
          : this.description,
      modelUuid: data.modelUuid.present ? data.modelUuid.value : this.modelUuid,
      systemPromptUuid: data.systemPromptUuid.present
          ? data.systemPromptUuid.value
          : this.systemPromptUuid,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      topP: data.topP.present ? data.topP.value : this.topP,
      maxTokens: data.maxTokens.present ? data.maxTokens.value : this.maxTokens,
      personalityJson: data.personalityJson.present
          ? data.personalityJson.value
          : this.personalityJson,
      expertiseJson: data.expertiseJson.present
          ? data.expertiseJson.value
          : this.expertiseJson,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiPersona(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('description: $description, ')
          ..write('modelUuid: $modelUuid, ')
          ..write('systemPromptUuid: $systemPromptUuid, ')
          ..write('temperature: $temperature, ')
          ..write('topP: $topP, ')
          ..write('maxTokens: $maxTokens, ')
          ..write('personalityJson: $personalityJson, ')
          ..write('expertiseJson: $expertiseJson, ')
          ..write('isDefault: $isDefault, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uuid,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    name,
    avatarUrl,
    description,
    modelUuid,
    systemPromptUuid,
    temperature,
    topP,
    maxTokens,
    personalityJson,
    expertiseJson,
    isDefault,
    isEnabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiPersona &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.deletedAt == this.deletedAt &&
          other.name == this.name &&
          other.avatarUrl == this.avatarUrl &&
          other.description == this.description &&
          other.modelUuid == this.modelUuid &&
          other.systemPromptUuid == this.systemPromptUuid &&
          other.temperature == this.temperature &&
          other.topP == this.topP &&
          other.maxTokens == this.maxTokens &&
          other.personalityJson == this.personalityJson &&
          other.expertiseJson == this.expertiseJson &&
          other.isDefault == this.isDefault &&
          other.isEnabled == this.isEnabled);
}

class AiPersonasCompanion extends UpdateCompanion<AiPersona> {
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastUpdatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> name;
  final Value<String?> avatarUrl;
  final Value<String?> description;
  final Value<String> modelUuid;
  final Value<String?> systemPromptUuid;
  final Value<double> temperature;
  final Value<double> topP;
  final Value<int> maxTokens;
  final Value<String?> personalityJson;
  final Value<String?> expertiseJson;
  final Value<bool> isDefault;
  final Value<bool> isEnabled;
  final Value<int> rowid;
  const AiPersonasCompanion({
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.modelUuid = const Value.absent(),
    this.systemPromptUuid = const Value.absent(),
    this.temperature = const Value.absent(),
    this.topP = const Value.absent(),
    this.maxTokens = const Value.absent(),
    this.personalityJson = const Value.absent(),
    this.expertiseJson = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiPersonasCompanion.insert({
    required String uuid,
    required DateTime createdAt,
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String name,
    this.avatarUrl = const Value.absent(),
    this.description = const Value.absent(),
    required String modelUuid,
    this.systemPromptUuid = const Value.absent(),
    this.temperature = const Value.absent(),
    this.topP = const Value.absent(),
    this.maxTokens = const Value.absent(),
    this.personalityJson = const Value.absent(),
    this.expertiseJson = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid),
       createdAt = Value(createdAt),
       name = Value(name),
       modelUuid = Value(modelUuid);
  static Insertable<AiPersona> custom({
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? name,
    Expression<String>? avatarUrl,
    Expression<String>? description,
    Expression<String>? modelUuid,
    Expression<String>? systemPromptUuid,
    Expression<double>? temperature,
    Expression<double>? topP,
    Expression<int>? maxTokens,
    Expression<String>? personalityJson,
    Expression<String>? expertiseJson,
    Expression<bool>? isDefault,
    Expression<bool>? isEnabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (name != null) 'name': name,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (description != null) 'description': description,
      if (modelUuid != null) 'model_uuid': modelUuid,
      if (systemPromptUuid != null) 'system_prompt_uuid': systemPromptUuid,
      if (temperature != null) 'temperature': temperature,
      if (topP != null) 'top_p': topP,
      if (maxTokens != null) 'max_tokens': maxTokens,
      if (personalityJson != null) 'personality_json': personalityJson,
      if (expertiseJson != null) 'expertise_json': expertiseJson,
      if (isDefault != null) 'is_default': isDefault,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiPersonasCompanion copyWith({
    Value<String>? uuid,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastUpdatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? name,
    Value<String?>? avatarUrl,
    Value<String?>? description,
    Value<String>? modelUuid,
    Value<String?>? systemPromptUuid,
    Value<double>? temperature,
    Value<double>? topP,
    Value<int>? maxTokens,
    Value<String?>? personalityJson,
    Value<String?>? expertiseJson,
    Value<bool>? isDefault,
    Value<bool>? isEnabled,
    Value<int>? rowid,
  }) {
    return AiPersonasCompanion(
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      description: description ?? this.description,
      modelUuid: modelUuid ?? this.modelUuid,
      systemPromptUuid: systemPromptUuid ?? this.systemPromptUuid,
      temperature: temperature ?? this.temperature,
      topP: topP ?? this.topP,
      maxTokens: maxTokens ?? this.maxTokens,
      personalityJson: personalityJson ?? this.personalityJson,
      expertiseJson: expertiseJson ?? this.expertiseJson,
      isDefault: isDefault ?? this.isDefault,
      isEnabled: isEnabled ?? this.isEnabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (modelUuid.present) {
      map['model_uuid'] = Variable<String>(modelUuid.value);
    }
    if (systemPromptUuid.present) {
      map['system_prompt_uuid'] = Variable<String>(systemPromptUuid.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (topP.present) {
      map['top_p'] = Variable<double>(topP.value);
    }
    if (maxTokens.present) {
      map['max_tokens'] = Variable<int>(maxTokens.value);
    }
    if (personalityJson.present) {
      map['personality_json'] = Variable<String>(personalityJson.value);
    }
    if (expertiseJson.present) {
      map['expertise_json'] = Variable<String>(expertiseJson.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiPersonasCompanion(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('description: $description, ')
          ..write('modelUuid: $modelUuid, ')
          ..write('systemPromptUuid: $systemPromptUuid, ')
          ..write('temperature: $temperature, ')
          ..write('topP: $topP, ')
          ..write('maxTokens: $maxTokens, ')
          ..write('personalityJson: $personalityJson, ')
          ..write('expertiseJson: $expertiseJson, ')
          ..write('isDefault: $isDefault, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiChatSessionsTable extends AiChatSessions
    with TableInfo<$AiChatSessionsTable, AiChatSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiChatSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdatedAtMeta = const VerificationMeta(
    'lastUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedAt =
      GeneratedColumn<DateTime>(
        'last_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _personaUuidMeta = const VerificationMeta(
    'personaUuid',
  );
  @override
  late final GeneratedColumn<String> personaUuid = GeneratedColumn<String>(
    'persona_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES t_ai_personas (uuid)',
    ),
  );
  static const VerificationMeta _divinationUuidMeta = const VerificationMeta(
    'divinationUuid',
  );
  @override
  late final GeneratedColumn<String> divinationUuid = GeneratedColumn<String>(
    'divination_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _contextJsonMeta = const VerificationMeta(
    'contextJson',
  );
  @override
  late final GeneratedColumn<String> contextJson = GeneratedColumn<String>(
    'context_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _messageCountMeta = const VerificationMeta(
    'messageCount',
  );
  @override
  late final GeneratedColumn<int> messageCount = GeneratedColumn<int>(
    'message_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastMessageAtMeta = const VerificationMeta(
    'lastMessageAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastMessageAt =
      GeneratedColumn<DateTime>(
        'last_message_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    uuid,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    title,
    personaUuid,
    divinationUuid,
    status,
    contextJson,
    messageCount,
    lastMessageAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_ai_chat_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiChatSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
        _lastUpdatedAtMeta,
        lastUpdatedAt.isAcceptableOrUnknown(
          data['last_updated_at']!,
          _lastUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('persona_uuid')) {
      context.handle(
        _personaUuidMeta,
        personaUuid.isAcceptableOrUnknown(
          data['persona_uuid']!,
          _personaUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_personaUuidMeta);
    }
    if (data.containsKey('divination_uuid')) {
      context.handle(
        _divinationUuidMeta,
        divinationUuid.isAcceptableOrUnknown(
          data['divination_uuid']!,
          _divinationUuidMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('context_json')) {
      context.handle(
        _contextJsonMeta,
        contextJson.isAcceptableOrUnknown(
          data['context_json']!,
          _contextJsonMeta,
        ),
      );
    }
    if (data.containsKey('message_count')) {
      context.handle(
        _messageCountMeta,
        messageCount.isAcceptableOrUnknown(
          data['message_count']!,
          _messageCountMeta,
        ),
      );
    }
    if (data.containsKey('last_message_at')) {
      context.handle(
        _lastMessageAtMeta,
        lastMessageAt.isAcceptableOrUnknown(
          data['last_message_at']!,
          _lastMessageAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  AiChatSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiChatSession(
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      personaUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}persona_uuid'],
      )!,
      divinationUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}divination_uuid'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      contextJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context_json'],
      ),
      messageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}message_count'],
      )!,
      lastMessageAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_message_at'],
      ),
    );
  }

  @override
  $AiChatSessionsTable createAlias(String alias) {
    return $AiChatSessionsTable(attachedDatabase, alias);
  }
}

class AiChatSession extends DataClass implements Insertable<AiChatSession> {
  final String uuid;
  final DateTime createdAt;
  final DateTime? lastUpdatedAt;
  final DateTime? deletedAt;

  /// 会话标题
  final String? title;

  /// 关联的 AI 人设 UUID
  final String personaUuid;

  /// 关联的占测 UUID (来自 common 模块)
  final String? divinationUuid;

  /// 会话状态 (active, archived, deleted)
  final String status;

  /// 会话上下文 (JSON，存储占测数据快照)
  final String? contextJson;

  /// 消息计数
  final int messageCount;

  /// 最后消息时间
  final DateTime? lastMessageAt;
  const AiChatSession({
    required this.uuid,
    required this.createdAt,
    this.lastUpdatedAt,
    this.deletedAt,
    this.title,
    required this.personaUuid,
    this.divinationUuid,
    required this.status,
    this.contextJson,
    required this.messageCount,
    this.lastMessageAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastUpdatedAt != null) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['persona_uuid'] = Variable<String>(personaUuid);
    if (!nullToAbsent || divinationUuid != null) {
      map['divination_uuid'] = Variable<String>(divinationUuid);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || contextJson != null) {
      map['context_json'] = Variable<String>(contextJson);
    }
    map['message_count'] = Variable<int>(messageCount);
    if (!nullToAbsent || lastMessageAt != null) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt);
    }
    return map;
  }

  AiChatSessionsCompanion toCompanion(bool nullToAbsent) {
    return AiChatSessionsCompanion(
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      lastUpdatedAt: lastUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      personaUuid: Value(personaUuid),
      divinationUuid: divinationUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(divinationUuid),
      status: Value(status),
      contextJson: contextJson == null && nullToAbsent
          ? const Value.absent()
          : Value(contextJson),
      messageCount: Value(messageCount),
      lastMessageAt: lastMessageAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageAt),
    );
  }

  factory AiChatSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiChatSession(
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdatedAt: serializer.fromJson<DateTime?>(json['lastUpdatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      title: serializer.fromJson<String?>(json['title']),
      personaUuid: serializer.fromJson<String>(json['personaUuid']),
      divinationUuid: serializer.fromJson<String?>(json['divinationUuid']),
      status: serializer.fromJson<String>(json['status']),
      contextJson: serializer.fromJson<String?>(json['contextJson']),
      messageCount: serializer.fromJson<int>(json['messageCount']),
      lastMessageAt: serializer.fromJson<DateTime?>(json['lastMessageAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdatedAt': serializer.toJson<DateTime?>(lastUpdatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'title': serializer.toJson<String?>(title),
      'personaUuid': serializer.toJson<String>(personaUuid),
      'divinationUuid': serializer.toJson<String?>(divinationUuid),
      'status': serializer.toJson<String>(status),
      'contextJson': serializer.toJson<String?>(contextJson),
      'messageCount': serializer.toJson<int>(messageCount),
      'lastMessageAt': serializer.toJson<DateTime?>(lastMessageAt),
    };
  }

  AiChatSession copyWith({
    String? uuid,
    DateTime? createdAt,
    Value<DateTime?> lastUpdatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<String?> title = const Value.absent(),
    String? personaUuid,
    Value<String?> divinationUuid = const Value.absent(),
    String? status,
    Value<String?> contextJson = const Value.absent(),
    int? messageCount,
    Value<DateTime?> lastMessageAt = const Value.absent(),
  }) => AiChatSession(
    uuid: uuid ?? this.uuid,
    createdAt: createdAt ?? this.createdAt,
    lastUpdatedAt: lastUpdatedAt.present
        ? lastUpdatedAt.value
        : this.lastUpdatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    title: title.present ? title.value : this.title,
    personaUuid: personaUuid ?? this.personaUuid,
    divinationUuid: divinationUuid.present
        ? divinationUuid.value
        : this.divinationUuid,
    status: status ?? this.status,
    contextJson: contextJson.present ? contextJson.value : this.contextJson,
    messageCount: messageCount ?? this.messageCount,
    lastMessageAt: lastMessageAt.present
        ? lastMessageAt.value
        : this.lastMessageAt,
  );
  AiChatSession copyWithCompanion(AiChatSessionsCompanion data) {
    return AiChatSession(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      title: data.title.present ? data.title.value : this.title,
      personaUuid: data.personaUuid.present
          ? data.personaUuid.value
          : this.personaUuid,
      divinationUuid: data.divinationUuid.present
          ? data.divinationUuid.value
          : this.divinationUuid,
      status: data.status.present ? data.status.value : this.status,
      contextJson: data.contextJson.present
          ? data.contextJson.value
          : this.contextJson,
      messageCount: data.messageCount.present
          ? data.messageCount.value
          : this.messageCount,
      lastMessageAt: data.lastMessageAt.present
          ? data.lastMessageAt.value
          : this.lastMessageAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiChatSession(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('title: $title, ')
          ..write('personaUuid: $personaUuid, ')
          ..write('divinationUuid: $divinationUuid, ')
          ..write('status: $status, ')
          ..write('contextJson: $contextJson, ')
          ..write('messageCount: $messageCount, ')
          ..write('lastMessageAt: $lastMessageAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uuid,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    title,
    personaUuid,
    divinationUuid,
    status,
    contextJson,
    messageCount,
    lastMessageAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiChatSession &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.deletedAt == this.deletedAt &&
          other.title == this.title &&
          other.personaUuid == this.personaUuid &&
          other.divinationUuid == this.divinationUuid &&
          other.status == this.status &&
          other.contextJson == this.contextJson &&
          other.messageCount == this.messageCount &&
          other.lastMessageAt == this.lastMessageAt);
}

class AiChatSessionsCompanion extends UpdateCompanion<AiChatSession> {
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastUpdatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String?> title;
  final Value<String> personaUuid;
  final Value<String?> divinationUuid;
  final Value<String> status;
  final Value<String?> contextJson;
  final Value<int> messageCount;
  final Value<DateTime?> lastMessageAt;
  final Value<int> rowid;
  const AiChatSessionsCompanion({
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.personaUuid = const Value.absent(),
    this.divinationUuid = const Value.absent(),
    this.status = const Value.absent(),
    this.contextJson = const Value.absent(),
    this.messageCount = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiChatSessionsCompanion.insert({
    required String uuid,
    required DateTime createdAt,
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.title = const Value.absent(),
    required String personaUuid,
    this.divinationUuid = const Value.absent(),
    this.status = const Value.absent(),
    this.contextJson = const Value.absent(),
    this.messageCount = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid),
       createdAt = Value(createdAt),
       personaUuid = Value(personaUuid);
  static Insertable<AiChatSession> custom({
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? title,
    Expression<String>? personaUuid,
    Expression<String>? divinationUuid,
    Expression<String>? status,
    Expression<String>? contextJson,
    Expression<int>? messageCount,
    Expression<DateTime>? lastMessageAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (title != null) 'title': title,
      if (personaUuid != null) 'persona_uuid': personaUuid,
      if (divinationUuid != null) 'divination_uuid': divinationUuid,
      if (status != null) 'status': status,
      if (contextJson != null) 'context_json': contextJson,
      if (messageCount != null) 'message_count': messageCount,
      if (lastMessageAt != null) 'last_message_at': lastMessageAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiChatSessionsCompanion copyWith({
    Value<String>? uuid,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastUpdatedAt,
    Value<DateTime?>? deletedAt,
    Value<String?>? title,
    Value<String>? personaUuid,
    Value<String?>? divinationUuid,
    Value<String>? status,
    Value<String?>? contextJson,
    Value<int>? messageCount,
    Value<DateTime?>? lastMessageAt,
    Value<int>? rowid,
  }) {
    return AiChatSessionsCompanion(
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      title: title ?? this.title,
      personaUuid: personaUuid ?? this.personaUuid,
      divinationUuid: divinationUuid ?? this.divinationUuid,
      status: status ?? this.status,
      contextJson: contextJson ?? this.contextJson,
      messageCount: messageCount ?? this.messageCount,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (personaUuid.present) {
      map['persona_uuid'] = Variable<String>(personaUuid.value);
    }
    if (divinationUuid.present) {
      map['divination_uuid'] = Variable<String>(divinationUuid.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (contextJson.present) {
      map['context_json'] = Variable<String>(contextJson.value);
    }
    if (messageCount.present) {
      map['message_count'] = Variable<int>(messageCount.value);
    }
    if (lastMessageAt.present) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiChatSessionsCompanion(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('title: $title, ')
          ..write('personaUuid: $personaUuid, ')
          ..write('divinationUuid: $divinationUuid, ')
          ..write('status: $status, ')
          ..write('contextJson: $contextJson, ')
          ..write('messageCount: $messageCount, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiApiCallsTable extends AiApiCalls
    with TableInfo<$AiApiCallsTable, AiApiCall> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiApiCallsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionUuidMeta = const VerificationMeta(
    'sessionUuid',
  );
  @override
  late final GeneratedColumn<String> sessionUuid = GeneratedColumn<String>(
    'session_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES t_ai_chat_sessions (uuid)',
    ),
  );
  static const VerificationMeta _modelUuidMeta = const VerificationMeta(
    'modelUuid',
  );
  @override
  late final GeneratedColumn<String> modelUuid = GeneratedColumn<String>(
    'model_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES t_llm_models (uuid)',
    ),
  );
  static const VerificationMeta _requestedAtMeta = const VerificationMeta(
    'requestedAt',
  );
  @override
  late final GeneratedColumn<DateTime> requestedAt = GeneratedColumn<DateTime>(
    'requested_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _respondedAtMeta = const VerificationMeta(
    'respondedAt',
  );
  @override
  late final GeneratedColumn<DateTime> respondedAt = GeneratedColumn<DateTime>(
    'responded_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _requestJsonMeta = const VerificationMeta(
    'requestJson',
  );
  @override
  late final GeneratedColumn<String> requestJson = GeneratedColumn<String>(
    'request_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _responseJsonMeta = const VerificationMeta(
    'responseJson',
  );
  @override
  late final GeneratedColumn<String> responseJson = GeneratedColumn<String>(
    'response_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _inputTokensMeta = const VerificationMeta(
    'inputTokens',
  );
  @override
  late final GeneratedColumn<int> inputTokens = GeneratedColumn<int>(
    'input_tokens',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outputTokensMeta = const VerificationMeta(
    'outputTokens',
  );
  @override
  late final GeneratedColumn<int> outputTokens = GeneratedColumn<int>(
    'output_tokens',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalTokensMeta = const VerificationMeta(
    'totalTokens',
  );
  @override
  late final GeneratedColumn<int> totalTokens = GeneratedColumn<int>(
    'total_tokens',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latencyMsMeta = const VerificationMeta(
    'latencyMs',
  );
  @override
  late final GeneratedColumn<int> latencyMs = GeneratedColumn<int>(
    'latency_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isStreamingMeta = const VerificationMeta(
    'isStreaming',
  );
  @override
  late final GeneratedColumn<bool> isStreaming = GeneratedColumn<bool>(
    'is_streaming',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_streaming" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    uuid,
    sessionUuid,
    modelUuid,
    requestedAt,
    respondedAt,
    requestJson,
    responseJson,
    status,
    errorMessage,
    inputTokens,
    outputTokens,
    totalTokens,
    latencyMs,
    isStreaming,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_ai_api_calls';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiApiCall> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('session_uuid')) {
      context.handle(
        _sessionUuidMeta,
        sessionUuid.isAcceptableOrUnknown(
          data['session_uuid']!,
          _sessionUuidMeta,
        ),
      );
    }
    if (data.containsKey('model_uuid')) {
      context.handle(
        _modelUuidMeta,
        modelUuid.isAcceptableOrUnknown(data['model_uuid']!, _modelUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_modelUuidMeta);
    }
    if (data.containsKey('requested_at')) {
      context.handle(
        _requestedAtMeta,
        requestedAt.isAcceptableOrUnknown(
          data['requested_at']!,
          _requestedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requestedAtMeta);
    }
    if (data.containsKey('responded_at')) {
      context.handle(
        _respondedAtMeta,
        respondedAt.isAcceptableOrUnknown(
          data['responded_at']!,
          _respondedAtMeta,
        ),
      );
    }
    if (data.containsKey('request_json')) {
      context.handle(
        _requestJsonMeta,
        requestJson.isAcceptableOrUnknown(
          data['request_json']!,
          _requestJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requestJsonMeta);
    }
    if (data.containsKey('response_json')) {
      context.handle(
        _responseJsonMeta,
        responseJson.isAcceptableOrUnknown(
          data['response_json']!,
          _responseJsonMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('input_tokens')) {
      context.handle(
        _inputTokensMeta,
        inputTokens.isAcceptableOrUnknown(
          data['input_tokens']!,
          _inputTokensMeta,
        ),
      );
    }
    if (data.containsKey('output_tokens')) {
      context.handle(
        _outputTokensMeta,
        outputTokens.isAcceptableOrUnknown(
          data['output_tokens']!,
          _outputTokensMeta,
        ),
      );
    }
    if (data.containsKey('total_tokens')) {
      context.handle(
        _totalTokensMeta,
        totalTokens.isAcceptableOrUnknown(
          data['total_tokens']!,
          _totalTokensMeta,
        ),
      );
    }
    if (data.containsKey('latency_ms')) {
      context.handle(
        _latencyMsMeta,
        latencyMs.isAcceptableOrUnknown(data['latency_ms']!, _latencyMsMeta),
      );
    }
    if (data.containsKey('is_streaming')) {
      context.handle(
        _isStreamingMeta,
        isStreaming.isAcceptableOrUnknown(
          data['is_streaming']!,
          _isStreamingMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  AiApiCall map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiApiCall(
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      sessionUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_uuid'],
      ),
      modelUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_uuid'],
      )!,
      requestedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}requested_at'],
      )!,
      respondedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}responded_at'],
      ),
      requestJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}request_json'],
      )!,
      responseJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}response_json'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      inputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}input_tokens'],
      ),
      outputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}output_tokens'],
      ),
      totalTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_tokens'],
      ),
      latencyMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}latency_ms'],
      ),
      isStreaming: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_streaming'],
      )!,
    );
  }

  @override
  $AiApiCallsTable createAlias(String alias) {
    return $AiApiCallsTable(attachedDatabase, alias);
  }
}

class AiApiCall extends DataClass implements Insertable<AiApiCall> {
  final String uuid;

  /// 关联的会话 UUID
  final String? sessionUuid;

  /// 关联的模型 UUID
  final String modelUuid;

  /// 请求时间
  final DateTime requestedAt;

  /// 响应时间
  final DateTime? respondedAt;

  /// 请求体 (JSON)
  final String requestJson;

  /// 响应体 (JSON)
  final String? responseJson;

  /// 请求状态 (pending, success, error, timeout)
  final String status;

  /// 错误信息
  final String? errorMessage;

  /// 输入 token 数
  final int? inputTokens;

  /// 输出 token 数
  final int? outputTokens;

  /// 总 token 数
  final int? totalTokens;

  /// 延迟 (毫秒)
  final int? latencyMs;

  /// 是否为流式请求
  final bool isStreaming;
  const AiApiCall({
    required this.uuid,
    this.sessionUuid,
    required this.modelUuid,
    required this.requestedAt,
    this.respondedAt,
    required this.requestJson,
    this.responseJson,
    required this.status,
    this.errorMessage,
    this.inputTokens,
    this.outputTokens,
    this.totalTokens,
    this.latencyMs,
    required this.isStreaming,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    if (!nullToAbsent || sessionUuid != null) {
      map['session_uuid'] = Variable<String>(sessionUuid);
    }
    map['model_uuid'] = Variable<String>(modelUuid);
    map['requested_at'] = Variable<DateTime>(requestedAt);
    if (!nullToAbsent || respondedAt != null) {
      map['responded_at'] = Variable<DateTime>(respondedAt);
    }
    map['request_json'] = Variable<String>(requestJson);
    if (!nullToAbsent || responseJson != null) {
      map['response_json'] = Variable<String>(responseJson);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    if (!nullToAbsent || inputTokens != null) {
      map['input_tokens'] = Variable<int>(inputTokens);
    }
    if (!nullToAbsent || outputTokens != null) {
      map['output_tokens'] = Variable<int>(outputTokens);
    }
    if (!nullToAbsent || totalTokens != null) {
      map['total_tokens'] = Variable<int>(totalTokens);
    }
    if (!nullToAbsent || latencyMs != null) {
      map['latency_ms'] = Variable<int>(latencyMs);
    }
    map['is_streaming'] = Variable<bool>(isStreaming);
    return map;
  }

  AiApiCallsCompanion toCompanion(bool nullToAbsent) {
    return AiApiCallsCompanion(
      uuid: Value(uuid),
      sessionUuid: sessionUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionUuid),
      modelUuid: Value(modelUuid),
      requestedAt: Value(requestedAt),
      respondedAt: respondedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(respondedAt),
      requestJson: Value(requestJson),
      responseJson: responseJson == null && nullToAbsent
          ? const Value.absent()
          : Value(responseJson),
      status: Value(status),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      inputTokens: inputTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(inputTokens),
      outputTokens: outputTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(outputTokens),
      totalTokens: totalTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(totalTokens),
      latencyMs: latencyMs == null && nullToAbsent
          ? const Value.absent()
          : Value(latencyMs),
      isStreaming: Value(isStreaming),
    );
  }

  factory AiApiCall.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiApiCall(
      uuid: serializer.fromJson<String>(json['uuid']),
      sessionUuid: serializer.fromJson<String?>(json['sessionUuid']),
      modelUuid: serializer.fromJson<String>(json['modelUuid']),
      requestedAt: serializer.fromJson<DateTime>(json['requestedAt']),
      respondedAt: serializer.fromJson<DateTime?>(json['respondedAt']),
      requestJson: serializer.fromJson<String>(json['requestJson']),
      responseJson: serializer.fromJson<String?>(json['responseJson']),
      status: serializer.fromJson<String>(json['status']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      inputTokens: serializer.fromJson<int?>(json['inputTokens']),
      outputTokens: serializer.fromJson<int?>(json['outputTokens']),
      totalTokens: serializer.fromJson<int?>(json['totalTokens']),
      latencyMs: serializer.fromJson<int?>(json['latencyMs']),
      isStreaming: serializer.fromJson<bool>(json['isStreaming']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'sessionUuid': serializer.toJson<String?>(sessionUuid),
      'modelUuid': serializer.toJson<String>(modelUuid),
      'requestedAt': serializer.toJson<DateTime>(requestedAt),
      'respondedAt': serializer.toJson<DateTime?>(respondedAt),
      'requestJson': serializer.toJson<String>(requestJson),
      'responseJson': serializer.toJson<String?>(responseJson),
      'status': serializer.toJson<String>(status),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'inputTokens': serializer.toJson<int?>(inputTokens),
      'outputTokens': serializer.toJson<int?>(outputTokens),
      'totalTokens': serializer.toJson<int?>(totalTokens),
      'latencyMs': serializer.toJson<int?>(latencyMs),
      'isStreaming': serializer.toJson<bool>(isStreaming),
    };
  }

  AiApiCall copyWith({
    String? uuid,
    Value<String?> sessionUuid = const Value.absent(),
    String? modelUuid,
    DateTime? requestedAt,
    Value<DateTime?> respondedAt = const Value.absent(),
    String? requestJson,
    Value<String?> responseJson = const Value.absent(),
    String? status,
    Value<String?> errorMessage = const Value.absent(),
    Value<int?> inputTokens = const Value.absent(),
    Value<int?> outputTokens = const Value.absent(),
    Value<int?> totalTokens = const Value.absent(),
    Value<int?> latencyMs = const Value.absent(),
    bool? isStreaming,
  }) => AiApiCall(
    uuid: uuid ?? this.uuid,
    sessionUuid: sessionUuid.present ? sessionUuid.value : this.sessionUuid,
    modelUuid: modelUuid ?? this.modelUuid,
    requestedAt: requestedAt ?? this.requestedAt,
    respondedAt: respondedAt.present ? respondedAt.value : this.respondedAt,
    requestJson: requestJson ?? this.requestJson,
    responseJson: responseJson.present ? responseJson.value : this.responseJson,
    status: status ?? this.status,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    inputTokens: inputTokens.present ? inputTokens.value : this.inputTokens,
    outputTokens: outputTokens.present ? outputTokens.value : this.outputTokens,
    totalTokens: totalTokens.present ? totalTokens.value : this.totalTokens,
    latencyMs: latencyMs.present ? latencyMs.value : this.latencyMs,
    isStreaming: isStreaming ?? this.isStreaming,
  );
  AiApiCall copyWithCompanion(AiApiCallsCompanion data) {
    return AiApiCall(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      sessionUuid: data.sessionUuid.present
          ? data.sessionUuid.value
          : this.sessionUuid,
      modelUuid: data.modelUuid.present ? data.modelUuid.value : this.modelUuid,
      requestedAt: data.requestedAt.present
          ? data.requestedAt.value
          : this.requestedAt,
      respondedAt: data.respondedAt.present
          ? data.respondedAt.value
          : this.respondedAt,
      requestJson: data.requestJson.present
          ? data.requestJson.value
          : this.requestJson,
      responseJson: data.responseJson.present
          ? data.responseJson.value
          : this.responseJson,
      status: data.status.present ? data.status.value : this.status,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      inputTokens: data.inputTokens.present
          ? data.inputTokens.value
          : this.inputTokens,
      outputTokens: data.outputTokens.present
          ? data.outputTokens.value
          : this.outputTokens,
      totalTokens: data.totalTokens.present
          ? data.totalTokens.value
          : this.totalTokens,
      latencyMs: data.latencyMs.present ? data.latencyMs.value : this.latencyMs,
      isStreaming: data.isStreaming.present
          ? data.isStreaming.value
          : this.isStreaming,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiApiCall(')
          ..write('uuid: $uuid, ')
          ..write('sessionUuid: $sessionUuid, ')
          ..write('modelUuid: $modelUuid, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('respondedAt: $respondedAt, ')
          ..write('requestJson: $requestJson, ')
          ..write('responseJson: $responseJson, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('inputTokens: $inputTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('totalTokens: $totalTokens, ')
          ..write('latencyMs: $latencyMs, ')
          ..write('isStreaming: $isStreaming')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uuid,
    sessionUuid,
    modelUuid,
    requestedAt,
    respondedAt,
    requestJson,
    responseJson,
    status,
    errorMessage,
    inputTokens,
    outputTokens,
    totalTokens,
    latencyMs,
    isStreaming,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiApiCall &&
          other.uuid == this.uuid &&
          other.sessionUuid == this.sessionUuid &&
          other.modelUuid == this.modelUuid &&
          other.requestedAt == this.requestedAt &&
          other.respondedAt == this.respondedAt &&
          other.requestJson == this.requestJson &&
          other.responseJson == this.responseJson &&
          other.status == this.status &&
          other.errorMessage == this.errorMessage &&
          other.inputTokens == this.inputTokens &&
          other.outputTokens == this.outputTokens &&
          other.totalTokens == this.totalTokens &&
          other.latencyMs == this.latencyMs &&
          other.isStreaming == this.isStreaming);
}

class AiApiCallsCompanion extends UpdateCompanion<AiApiCall> {
  final Value<String> uuid;
  final Value<String?> sessionUuid;
  final Value<String> modelUuid;
  final Value<DateTime> requestedAt;
  final Value<DateTime?> respondedAt;
  final Value<String> requestJson;
  final Value<String?> responseJson;
  final Value<String> status;
  final Value<String?> errorMessage;
  final Value<int?> inputTokens;
  final Value<int?> outputTokens;
  final Value<int?> totalTokens;
  final Value<int?> latencyMs;
  final Value<bool> isStreaming;
  final Value<int> rowid;
  const AiApiCallsCompanion({
    this.uuid = const Value.absent(),
    this.sessionUuid = const Value.absent(),
    this.modelUuid = const Value.absent(),
    this.requestedAt = const Value.absent(),
    this.respondedAt = const Value.absent(),
    this.requestJson = const Value.absent(),
    this.responseJson = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.inputTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    this.totalTokens = const Value.absent(),
    this.latencyMs = const Value.absent(),
    this.isStreaming = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiApiCallsCompanion.insert({
    required String uuid,
    this.sessionUuid = const Value.absent(),
    required String modelUuid,
    required DateTime requestedAt,
    this.respondedAt = const Value.absent(),
    required String requestJson,
    this.responseJson = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.inputTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    this.totalTokens = const Value.absent(),
    this.latencyMs = const Value.absent(),
    this.isStreaming = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid),
       modelUuid = Value(modelUuid),
       requestedAt = Value(requestedAt),
       requestJson = Value(requestJson);
  static Insertable<AiApiCall> custom({
    Expression<String>? uuid,
    Expression<String>? sessionUuid,
    Expression<String>? modelUuid,
    Expression<DateTime>? requestedAt,
    Expression<DateTime>? respondedAt,
    Expression<String>? requestJson,
    Expression<String>? responseJson,
    Expression<String>? status,
    Expression<String>? errorMessage,
    Expression<int>? inputTokens,
    Expression<int>? outputTokens,
    Expression<int>? totalTokens,
    Expression<int>? latencyMs,
    Expression<bool>? isStreaming,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (sessionUuid != null) 'session_uuid': sessionUuid,
      if (modelUuid != null) 'model_uuid': modelUuid,
      if (requestedAt != null) 'requested_at': requestedAt,
      if (respondedAt != null) 'responded_at': respondedAt,
      if (requestJson != null) 'request_json': requestJson,
      if (responseJson != null) 'response_json': responseJson,
      if (status != null) 'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
      if (inputTokens != null) 'input_tokens': inputTokens,
      if (outputTokens != null) 'output_tokens': outputTokens,
      if (totalTokens != null) 'total_tokens': totalTokens,
      if (latencyMs != null) 'latency_ms': latencyMs,
      if (isStreaming != null) 'is_streaming': isStreaming,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiApiCallsCompanion copyWith({
    Value<String>? uuid,
    Value<String?>? sessionUuid,
    Value<String>? modelUuid,
    Value<DateTime>? requestedAt,
    Value<DateTime?>? respondedAt,
    Value<String>? requestJson,
    Value<String?>? responseJson,
    Value<String>? status,
    Value<String?>? errorMessage,
    Value<int?>? inputTokens,
    Value<int?>? outputTokens,
    Value<int?>? totalTokens,
    Value<int?>? latencyMs,
    Value<bool>? isStreaming,
    Value<int>? rowid,
  }) {
    return AiApiCallsCompanion(
      uuid: uuid ?? this.uuid,
      sessionUuid: sessionUuid ?? this.sessionUuid,
      modelUuid: modelUuid ?? this.modelUuid,
      requestedAt: requestedAt ?? this.requestedAt,
      respondedAt: respondedAt ?? this.respondedAt,
      requestJson: requestJson ?? this.requestJson,
      responseJson: responseJson ?? this.responseJson,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      totalTokens: totalTokens ?? this.totalTokens,
      latencyMs: latencyMs ?? this.latencyMs,
      isStreaming: isStreaming ?? this.isStreaming,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (sessionUuid.present) {
      map['session_uuid'] = Variable<String>(sessionUuid.value);
    }
    if (modelUuid.present) {
      map['model_uuid'] = Variable<String>(modelUuid.value);
    }
    if (requestedAt.present) {
      map['requested_at'] = Variable<DateTime>(requestedAt.value);
    }
    if (respondedAt.present) {
      map['responded_at'] = Variable<DateTime>(respondedAt.value);
    }
    if (requestJson.present) {
      map['request_json'] = Variable<String>(requestJson.value);
    }
    if (responseJson.present) {
      map['response_json'] = Variable<String>(responseJson.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (inputTokens.present) {
      map['input_tokens'] = Variable<int>(inputTokens.value);
    }
    if (outputTokens.present) {
      map['output_tokens'] = Variable<int>(outputTokens.value);
    }
    if (totalTokens.present) {
      map['total_tokens'] = Variable<int>(totalTokens.value);
    }
    if (latencyMs.present) {
      map['latency_ms'] = Variable<int>(latencyMs.value);
    }
    if (isStreaming.present) {
      map['is_streaming'] = Variable<bool>(isStreaming.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiApiCallsCompanion(')
          ..write('uuid: $uuid, ')
          ..write('sessionUuid: $sessionUuid, ')
          ..write('modelUuid: $modelUuid, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('respondedAt: $respondedAt, ')
          ..write('requestJson: $requestJson, ')
          ..write('responseJson: $responseJson, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('inputTokens: $inputTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('totalTokens: $totalTokens, ')
          ..write('latencyMs: $latencyMs, ')
          ..write('isStreaming: $isStreaming, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiChatMessagesTable extends AiChatMessages
    with TableInfo<$AiChatMessagesTable, AiChatMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiChatMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionUuidMeta = const VerificationMeta(
    'sessionUuid',
  );
  @override
  late final GeneratedColumn<String> sessionUuid = GeneratedColumn<String>(
    'session_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES t_ai_chat_sessions (uuid)',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sequenceMeta = const VerificationMeta(
    'sequence',
  );
  @override
  late final GeneratedColumn<int> sequence = GeneratedColumn<int>(
    'sequence',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isStreamingMeta = const VerificationMeta(
    'isStreaming',
  );
  @override
  late final GeneratedColumn<bool> isStreaming = GeneratedColumn<bool>(
    'is_streaming',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_streaming" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _streamCompletedAtMeta = const VerificationMeta(
    'streamCompletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> streamCompletedAt =
      GeneratedColumn<DateTime>(
        'stream_completed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _toolCallIdMeta = const VerificationMeta(
    'toolCallId',
  );
  @override
  late final GeneratedColumn<String> toolCallId = GeneratedColumn<String>(
    'tool_call_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _toolCallsJsonMeta = const VerificationMeta(
    'toolCallsJson',
  );
  @override
  late final GeneratedColumn<String> toolCallsJson = GeneratedColumn<String>(
    'tool_calls_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usageJsonMeta = const VerificationMeta(
    'usageJson',
  );
  @override
  late final GeneratedColumn<String> usageJson = GeneratedColumn<String>(
    'usage_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _apiCallUuidMeta = const VerificationMeta(
    'apiCallUuid',
  );
  @override
  late final GeneratedColumn<String> apiCallUuid = GeneratedColumn<String>(
    'api_call_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES t_ai_api_calls (uuid)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    uuid,
    sessionUuid,
    role,
    content,
    sequence,
    createdAt,
    isStreaming,
    streamCompletedAt,
    toolCallId,
    toolCallsJson,
    usageJson,
    apiCallUuid,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_ai_chat_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiChatMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('session_uuid')) {
      context.handle(
        _sessionUuidMeta,
        sessionUuid.isAcceptableOrUnknown(
          data['session_uuid']!,
          _sessionUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionUuidMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('sequence')) {
      context.handle(
        _sequenceMeta,
        sequence.isAcceptableOrUnknown(data['sequence']!, _sequenceMeta),
      );
    } else if (isInserting) {
      context.missing(_sequenceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_streaming')) {
      context.handle(
        _isStreamingMeta,
        isStreaming.isAcceptableOrUnknown(
          data['is_streaming']!,
          _isStreamingMeta,
        ),
      );
    }
    if (data.containsKey('stream_completed_at')) {
      context.handle(
        _streamCompletedAtMeta,
        streamCompletedAt.isAcceptableOrUnknown(
          data['stream_completed_at']!,
          _streamCompletedAtMeta,
        ),
      );
    }
    if (data.containsKey('tool_call_id')) {
      context.handle(
        _toolCallIdMeta,
        toolCallId.isAcceptableOrUnknown(
          data['tool_call_id']!,
          _toolCallIdMeta,
        ),
      );
    }
    if (data.containsKey('tool_calls_json')) {
      context.handle(
        _toolCallsJsonMeta,
        toolCallsJson.isAcceptableOrUnknown(
          data['tool_calls_json']!,
          _toolCallsJsonMeta,
        ),
      );
    }
    if (data.containsKey('usage_json')) {
      context.handle(
        _usageJsonMeta,
        usageJson.isAcceptableOrUnknown(data['usage_json']!, _usageJsonMeta),
      );
    }
    if (data.containsKey('api_call_uuid')) {
      context.handle(
        _apiCallUuidMeta,
        apiCallUuid.isAcceptableOrUnknown(
          data['api_call_uuid']!,
          _apiCallUuidMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  AiChatMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiChatMessage(
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      sessionUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_uuid'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      sequence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequence'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isStreaming: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_streaming'],
      )!,
      streamCompletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}stream_completed_at'],
      ),
      toolCallId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tool_call_id'],
      ),
      toolCallsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tool_calls_json'],
      ),
      usageJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usage_json'],
      ),
      apiCallUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}api_call_uuid'],
      ),
    );
  }

  @override
  $AiChatMessagesTable createAlias(String alias) {
    return $AiChatMessagesTable(attachedDatabase, alias);
  }
}

class AiChatMessage extends DataClass implements Insertable<AiChatMessage> {
  final String uuid;

  /// 关联的会话 UUID
  final String sessionUuid;

  /// 消息角色 (system, user, assistant, function, tool)
  final String role;

  /// 消息内容
  final String content;

  /// 消息序号
  final int sequence;

  /// 创建时间
  final DateTime createdAt;

  /// 是否为流式消息（正在生成中）
  final bool isStreaming;

  /// 流式消息完成时间
  final DateTime? streamCompletedAt;

  /// 关联的工具调用 ID
  final String? toolCallId;

  /// 工具调用详情 (JSON)
  final String? toolCallsJson;

  /// token 使用统计 (JSON)
  final String? usageJson;

  /// 关联的 API 调用 UUID
  final String? apiCallUuid;
  const AiChatMessage({
    required this.uuid,
    required this.sessionUuid,
    required this.role,
    required this.content,
    required this.sequence,
    required this.createdAt,
    required this.isStreaming,
    this.streamCompletedAt,
    this.toolCallId,
    this.toolCallsJson,
    this.usageJson,
    this.apiCallUuid,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['session_uuid'] = Variable<String>(sessionUuid);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    map['sequence'] = Variable<int>(sequence);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_streaming'] = Variable<bool>(isStreaming);
    if (!nullToAbsent || streamCompletedAt != null) {
      map['stream_completed_at'] = Variable<DateTime>(streamCompletedAt);
    }
    if (!nullToAbsent || toolCallId != null) {
      map['tool_call_id'] = Variable<String>(toolCallId);
    }
    if (!nullToAbsent || toolCallsJson != null) {
      map['tool_calls_json'] = Variable<String>(toolCallsJson);
    }
    if (!nullToAbsent || usageJson != null) {
      map['usage_json'] = Variable<String>(usageJson);
    }
    if (!nullToAbsent || apiCallUuid != null) {
      map['api_call_uuid'] = Variable<String>(apiCallUuid);
    }
    return map;
  }

  AiChatMessagesCompanion toCompanion(bool nullToAbsent) {
    return AiChatMessagesCompanion(
      uuid: Value(uuid),
      sessionUuid: Value(sessionUuid),
      role: Value(role),
      content: Value(content),
      sequence: Value(sequence),
      createdAt: Value(createdAt),
      isStreaming: Value(isStreaming),
      streamCompletedAt: streamCompletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(streamCompletedAt),
      toolCallId: toolCallId == null && nullToAbsent
          ? const Value.absent()
          : Value(toolCallId),
      toolCallsJson: toolCallsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(toolCallsJson),
      usageJson: usageJson == null && nullToAbsent
          ? const Value.absent()
          : Value(usageJson),
      apiCallUuid: apiCallUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(apiCallUuid),
    );
  }

  factory AiChatMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiChatMessage(
      uuid: serializer.fromJson<String>(json['uuid']),
      sessionUuid: serializer.fromJson<String>(json['sessionUuid']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      sequence: serializer.fromJson<int>(json['sequence']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isStreaming: serializer.fromJson<bool>(json['isStreaming']),
      streamCompletedAt: serializer.fromJson<DateTime?>(
        json['streamCompletedAt'],
      ),
      toolCallId: serializer.fromJson<String?>(json['toolCallId']),
      toolCallsJson: serializer.fromJson<String?>(json['toolCallsJson']),
      usageJson: serializer.fromJson<String?>(json['usageJson']),
      apiCallUuid: serializer.fromJson<String?>(json['apiCallUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'sessionUuid': serializer.toJson<String>(sessionUuid),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'sequence': serializer.toJson<int>(sequence),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isStreaming': serializer.toJson<bool>(isStreaming),
      'streamCompletedAt': serializer.toJson<DateTime?>(streamCompletedAt),
      'toolCallId': serializer.toJson<String?>(toolCallId),
      'toolCallsJson': serializer.toJson<String?>(toolCallsJson),
      'usageJson': serializer.toJson<String?>(usageJson),
      'apiCallUuid': serializer.toJson<String?>(apiCallUuid),
    };
  }

  AiChatMessage copyWith({
    String? uuid,
    String? sessionUuid,
    String? role,
    String? content,
    int? sequence,
    DateTime? createdAt,
    bool? isStreaming,
    Value<DateTime?> streamCompletedAt = const Value.absent(),
    Value<String?> toolCallId = const Value.absent(),
    Value<String?> toolCallsJson = const Value.absent(),
    Value<String?> usageJson = const Value.absent(),
    Value<String?> apiCallUuid = const Value.absent(),
  }) => AiChatMessage(
    uuid: uuid ?? this.uuid,
    sessionUuid: sessionUuid ?? this.sessionUuid,
    role: role ?? this.role,
    content: content ?? this.content,
    sequence: sequence ?? this.sequence,
    createdAt: createdAt ?? this.createdAt,
    isStreaming: isStreaming ?? this.isStreaming,
    streamCompletedAt: streamCompletedAt.present
        ? streamCompletedAt.value
        : this.streamCompletedAt,
    toolCallId: toolCallId.present ? toolCallId.value : this.toolCallId,
    toolCallsJson: toolCallsJson.present
        ? toolCallsJson.value
        : this.toolCallsJson,
    usageJson: usageJson.present ? usageJson.value : this.usageJson,
    apiCallUuid: apiCallUuid.present ? apiCallUuid.value : this.apiCallUuid,
  );
  AiChatMessage copyWithCompanion(AiChatMessagesCompanion data) {
    return AiChatMessage(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      sessionUuid: data.sessionUuid.present
          ? data.sessionUuid.value
          : this.sessionUuid,
      role: data.role.present ? data.role.value : this.role,
      content: data.content.present ? data.content.value : this.content,
      sequence: data.sequence.present ? data.sequence.value : this.sequence,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isStreaming: data.isStreaming.present
          ? data.isStreaming.value
          : this.isStreaming,
      streamCompletedAt: data.streamCompletedAt.present
          ? data.streamCompletedAt.value
          : this.streamCompletedAt,
      toolCallId: data.toolCallId.present
          ? data.toolCallId.value
          : this.toolCallId,
      toolCallsJson: data.toolCallsJson.present
          ? data.toolCallsJson.value
          : this.toolCallsJson,
      usageJson: data.usageJson.present ? data.usageJson.value : this.usageJson,
      apiCallUuid: data.apiCallUuid.present
          ? data.apiCallUuid.value
          : this.apiCallUuid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiChatMessage(')
          ..write('uuid: $uuid, ')
          ..write('sessionUuid: $sessionUuid, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('sequence: $sequence, ')
          ..write('createdAt: $createdAt, ')
          ..write('isStreaming: $isStreaming, ')
          ..write('streamCompletedAt: $streamCompletedAt, ')
          ..write('toolCallId: $toolCallId, ')
          ..write('toolCallsJson: $toolCallsJson, ')
          ..write('usageJson: $usageJson, ')
          ..write('apiCallUuid: $apiCallUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uuid,
    sessionUuid,
    role,
    content,
    sequence,
    createdAt,
    isStreaming,
    streamCompletedAt,
    toolCallId,
    toolCallsJson,
    usageJson,
    apiCallUuid,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiChatMessage &&
          other.uuid == this.uuid &&
          other.sessionUuid == this.sessionUuid &&
          other.role == this.role &&
          other.content == this.content &&
          other.sequence == this.sequence &&
          other.createdAt == this.createdAt &&
          other.isStreaming == this.isStreaming &&
          other.streamCompletedAt == this.streamCompletedAt &&
          other.toolCallId == this.toolCallId &&
          other.toolCallsJson == this.toolCallsJson &&
          other.usageJson == this.usageJson &&
          other.apiCallUuid == this.apiCallUuid);
}

class AiChatMessagesCompanion extends UpdateCompanion<AiChatMessage> {
  final Value<String> uuid;
  final Value<String> sessionUuid;
  final Value<String> role;
  final Value<String> content;
  final Value<int> sequence;
  final Value<DateTime> createdAt;
  final Value<bool> isStreaming;
  final Value<DateTime?> streamCompletedAt;
  final Value<String?> toolCallId;
  final Value<String?> toolCallsJson;
  final Value<String?> usageJson;
  final Value<String?> apiCallUuid;
  final Value<int> rowid;
  const AiChatMessagesCompanion({
    this.uuid = const Value.absent(),
    this.sessionUuid = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.sequence = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isStreaming = const Value.absent(),
    this.streamCompletedAt = const Value.absent(),
    this.toolCallId = const Value.absent(),
    this.toolCallsJson = const Value.absent(),
    this.usageJson = const Value.absent(),
    this.apiCallUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiChatMessagesCompanion.insert({
    required String uuid,
    required String sessionUuid,
    required String role,
    required String content,
    required int sequence,
    required DateTime createdAt,
    this.isStreaming = const Value.absent(),
    this.streamCompletedAt = const Value.absent(),
    this.toolCallId = const Value.absent(),
    this.toolCallsJson = const Value.absent(),
    this.usageJson = const Value.absent(),
    this.apiCallUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid),
       sessionUuid = Value(sessionUuid),
       role = Value(role),
       content = Value(content),
       sequence = Value(sequence),
       createdAt = Value(createdAt);
  static Insertable<AiChatMessage> custom({
    Expression<String>? uuid,
    Expression<String>? sessionUuid,
    Expression<String>? role,
    Expression<String>? content,
    Expression<int>? sequence,
    Expression<DateTime>? createdAt,
    Expression<bool>? isStreaming,
    Expression<DateTime>? streamCompletedAt,
    Expression<String>? toolCallId,
    Expression<String>? toolCallsJson,
    Expression<String>? usageJson,
    Expression<String>? apiCallUuid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (sessionUuid != null) 'session_uuid': sessionUuid,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (sequence != null) 'sequence': sequence,
      if (createdAt != null) 'created_at': createdAt,
      if (isStreaming != null) 'is_streaming': isStreaming,
      if (streamCompletedAt != null) 'stream_completed_at': streamCompletedAt,
      if (toolCallId != null) 'tool_call_id': toolCallId,
      if (toolCallsJson != null) 'tool_calls_json': toolCallsJson,
      if (usageJson != null) 'usage_json': usageJson,
      if (apiCallUuid != null) 'api_call_uuid': apiCallUuid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiChatMessagesCompanion copyWith({
    Value<String>? uuid,
    Value<String>? sessionUuid,
    Value<String>? role,
    Value<String>? content,
    Value<int>? sequence,
    Value<DateTime>? createdAt,
    Value<bool>? isStreaming,
    Value<DateTime?>? streamCompletedAt,
    Value<String?>? toolCallId,
    Value<String?>? toolCallsJson,
    Value<String?>? usageJson,
    Value<String?>? apiCallUuid,
    Value<int>? rowid,
  }) {
    return AiChatMessagesCompanion(
      uuid: uuid ?? this.uuid,
      sessionUuid: sessionUuid ?? this.sessionUuid,
      role: role ?? this.role,
      content: content ?? this.content,
      sequence: sequence ?? this.sequence,
      createdAt: createdAt ?? this.createdAt,
      isStreaming: isStreaming ?? this.isStreaming,
      streamCompletedAt: streamCompletedAt ?? this.streamCompletedAt,
      toolCallId: toolCallId ?? this.toolCallId,
      toolCallsJson: toolCallsJson ?? this.toolCallsJson,
      usageJson: usageJson ?? this.usageJson,
      apiCallUuid: apiCallUuid ?? this.apiCallUuid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (sessionUuid.present) {
      map['session_uuid'] = Variable<String>(sessionUuid.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (sequence.present) {
      map['sequence'] = Variable<int>(sequence.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isStreaming.present) {
      map['is_streaming'] = Variable<bool>(isStreaming.value);
    }
    if (streamCompletedAt.present) {
      map['stream_completed_at'] = Variable<DateTime>(streamCompletedAt.value);
    }
    if (toolCallId.present) {
      map['tool_call_id'] = Variable<String>(toolCallId.value);
    }
    if (toolCallsJson.present) {
      map['tool_calls_json'] = Variable<String>(toolCallsJson.value);
    }
    if (usageJson.present) {
      map['usage_json'] = Variable<String>(usageJson.value);
    }
    if (apiCallUuid.present) {
      map['api_call_uuid'] = Variable<String>(apiCallUuid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiChatMessagesCompanion(')
          ..write('uuid: $uuid, ')
          ..write('sessionUuid: $sessionUuid, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('sequence: $sequence, ')
          ..write('createdAt: $createdAt, ')
          ..write('isStreaming: $isStreaming, ')
          ..write('streamCompletedAt: $streamCompletedAt, ')
          ..write('toolCallId: $toolCallId, ')
          ..write('toolCallsJson: $toolCallsJson, ')
          ..write('usageJson: $usageJson, ')
          ..write('apiCallUuid: $apiCallUuid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiProvenancesTable extends AiProvenances
    with TableInfo<$AiProvenancesTable, AiProvenance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiProvenancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _provenanceTypeMeta = const VerificationMeta(
    'provenanceType',
  );
  @override
  late final GeneratedColumn<String> provenanceType = GeneratedColumn<String>(
    'provenance_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityUuidMeta = const VerificationMeta(
    'entityUuid',
  );
  @override
  late final GeneratedColumn<String> entityUuid = GeneratedColumn<String>(
    'entity_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contextSnapshotJsonMeta =
      const VerificationMeta('contextSnapshotJson');
  @override
  late final GeneratedColumn<String> contextSnapshotJson =
      GeneratedColumn<String>(
        'context_snapshot_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _inputSnapshotJsonMeta = const VerificationMeta(
    'inputSnapshotJson',
  );
  @override
  late final GeneratedColumn<String> inputSnapshotJson =
      GeneratedColumn<String>(
        'input_snapshot_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _outputSnapshotJsonMeta =
      const VerificationMeta('outputSnapshotJson');
  @override
  late final GeneratedColumn<String> outputSnapshotJson =
      GeneratedColumn<String>(
        'output_snapshot_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _promptVersionUuidMeta = const VerificationMeta(
    'promptVersionUuid',
  );
  @override
  late final GeneratedColumn<String> promptVersionUuid =
      GeneratedColumn<String>(
        'prompt_version_uuid',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _modelUuidMeta = const VerificationMeta(
    'modelUuid',
  );
  @override
  late final GeneratedColumn<String> modelUuid = GeneratedColumn<String>(
    'model_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _previousProvenanceUuidMeta =
      const VerificationMeta('previousProvenanceUuid');
  @override
  late final GeneratedColumn<String> previousProvenanceUuid =
      GeneratedColumn<String>(
        'previous_provenance_uuid',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _integrityHashMeta = const VerificationMeta(
    'integrityHash',
  );
  @override
  late final GeneratedColumn<String> integrityHash = GeneratedColumn<String>(
    'integrity_hash',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 64,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    uuid,
    provenanceType,
    entityUuid,
    entityType,
    createdAt,
    contextSnapshotJson,
    inputSnapshotJson,
    outputSnapshotJson,
    promptVersionUuid,
    modelUuid,
    previousProvenanceUuid,
    integrityHash,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_ai_provenance';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiProvenance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('provenance_type')) {
      context.handle(
        _provenanceTypeMeta,
        provenanceType.isAcceptableOrUnknown(
          data['provenance_type']!,
          _provenanceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_provenanceTypeMeta);
    }
    if (data.containsKey('entity_uuid')) {
      context.handle(
        _entityUuidMeta,
        entityUuid.isAcceptableOrUnknown(data['entity_uuid']!, _entityUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_entityUuidMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('context_snapshot_json')) {
      context.handle(
        _contextSnapshotJsonMeta,
        contextSnapshotJson.isAcceptableOrUnknown(
          data['context_snapshot_json']!,
          _contextSnapshotJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contextSnapshotJsonMeta);
    }
    if (data.containsKey('input_snapshot_json')) {
      context.handle(
        _inputSnapshotJsonMeta,
        inputSnapshotJson.isAcceptableOrUnknown(
          data['input_snapshot_json']!,
          _inputSnapshotJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inputSnapshotJsonMeta);
    }
    if (data.containsKey('output_snapshot_json')) {
      context.handle(
        _outputSnapshotJsonMeta,
        outputSnapshotJson.isAcceptableOrUnknown(
          data['output_snapshot_json']!,
          _outputSnapshotJsonMeta,
        ),
      );
    }
    if (data.containsKey('prompt_version_uuid')) {
      context.handle(
        _promptVersionUuidMeta,
        promptVersionUuid.isAcceptableOrUnknown(
          data['prompt_version_uuid']!,
          _promptVersionUuidMeta,
        ),
      );
    }
    if (data.containsKey('model_uuid')) {
      context.handle(
        _modelUuidMeta,
        modelUuid.isAcceptableOrUnknown(data['model_uuid']!, _modelUuidMeta),
      );
    }
    if (data.containsKey('previous_provenance_uuid')) {
      context.handle(
        _previousProvenanceUuidMeta,
        previousProvenanceUuid.isAcceptableOrUnknown(
          data['previous_provenance_uuid']!,
          _previousProvenanceUuidMeta,
        ),
      );
    }
    if (data.containsKey('integrity_hash')) {
      context.handle(
        _integrityHashMeta,
        integrityHash.isAcceptableOrUnknown(
          data['integrity_hash']!,
          _integrityHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_integrityHashMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  AiProvenance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiProvenance(
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      provenanceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provenance_type'],
      )!,
      entityUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_uuid'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      contextSnapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context_snapshot_json'],
      )!,
      inputSnapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}input_snapshot_json'],
      )!,
      outputSnapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}output_snapshot_json'],
      ),
      promptVersionUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_version_uuid'],
      ),
      modelUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_uuid'],
      ),
      previousProvenanceUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}previous_provenance_uuid'],
      ),
      integrityHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}integrity_hash'],
      )!,
    );
  }

  @override
  $AiProvenancesTable createAlias(String alias) {
    return $AiProvenancesTable(attachedDatabase, alias);
  }
}

class AiProvenance extends DataClass implements Insertable<AiProvenance> {
  final String uuid;

  /// 溯源类型 (api_call, tool_invocation, agent_call, message)
  final String provenanceType;

  /// 关联的实体 UUID (可以是消息、API调用、Agent调用等)
  final String entityUuid;

  /// 关联的实体类型
  final String entityType;

  /// 创建时间
  final DateTime createdAt;

  /// 完整上下文快照 (JSON)
  final String contextSnapshotJson;

  /// 输入数据快照 (JSON)
  final String inputSnapshotJson;

  /// 输出数据快照 (JSON)
  final String? outputSnapshotJson;

  /// Prompt 版本 UUID (如果适用)
  final String? promptVersionUuid;

  /// 模型 UUID
  final String? modelUuid;

  /// 溯源链前一条记录 UUID (形成链式结构)
  final String? previousProvenanceUuid;

  /// 整体哈希 (用于完整性校验)
  final String integrityHash;
  const AiProvenance({
    required this.uuid,
    required this.provenanceType,
    required this.entityUuid,
    required this.entityType,
    required this.createdAt,
    required this.contextSnapshotJson,
    required this.inputSnapshotJson,
    this.outputSnapshotJson,
    this.promptVersionUuid,
    this.modelUuid,
    this.previousProvenanceUuid,
    required this.integrityHash,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['provenance_type'] = Variable<String>(provenanceType);
    map['entity_uuid'] = Variable<String>(entityUuid);
    map['entity_type'] = Variable<String>(entityType);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['context_snapshot_json'] = Variable<String>(contextSnapshotJson);
    map['input_snapshot_json'] = Variable<String>(inputSnapshotJson);
    if (!nullToAbsent || outputSnapshotJson != null) {
      map['output_snapshot_json'] = Variable<String>(outputSnapshotJson);
    }
    if (!nullToAbsent || promptVersionUuid != null) {
      map['prompt_version_uuid'] = Variable<String>(promptVersionUuid);
    }
    if (!nullToAbsent || modelUuid != null) {
      map['model_uuid'] = Variable<String>(modelUuid);
    }
    if (!nullToAbsent || previousProvenanceUuid != null) {
      map['previous_provenance_uuid'] = Variable<String>(
        previousProvenanceUuid,
      );
    }
    map['integrity_hash'] = Variable<String>(integrityHash);
    return map;
  }

  AiProvenancesCompanion toCompanion(bool nullToAbsent) {
    return AiProvenancesCompanion(
      uuid: Value(uuid),
      provenanceType: Value(provenanceType),
      entityUuid: Value(entityUuid),
      entityType: Value(entityType),
      createdAt: Value(createdAt),
      contextSnapshotJson: Value(contextSnapshotJson),
      inputSnapshotJson: Value(inputSnapshotJson),
      outputSnapshotJson: outputSnapshotJson == null && nullToAbsent
          ? const Value.absent()
          : Value(outputSnapshotJson),
      promptVersionUuid: promptVersionUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(promptVersionUuid),
      modelUuid: modelUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(modelUuid),
      previousProvenanceUuid: previousProvenanceUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(previousProvenanceUuid),
      integrityHash: Value(integrityHash),
    );
  }

  factory AiProvenance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiProvenance(
      uuid: serializer.fromJson<String>(json['uuid']),
      provenanceType: serializer.fromJson<String>(json['provenanceType']),
      entityUuid: serializer.fromJson<String>(json['entityUuid']),
      entityType: serializer.fromJson<String>(json['entityType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      contextSnapshotJson: serializer.fromJson<String>(
        json['contextSnapshotJson'],
      ),
      inputSnapshotJson: serializer.fromJson<String>(json['inputSnapshotJson']),
      outputSnapshotJson: serializer.fromJson<String?>(
        json['outputSnapshotJson'],
      ),
      promptVersionUuid: serializer.fromJson<String?>(
        json['promptVersionUuid'],
      ),
      modelUuid: serializer.fromJson<String?>(json['modelUuid']),
      previousProvenanceUuid: serializer.fromJson<String?>(
        json['previousProvenanceUuid'],
      ),
      integrityHash: serializer.fromJson<String>(json['integrityHash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'provenanceType': serializer.toJson<String>(provenanceType),
      'entityUuid': serializer.toJson<String>(entityUuid),
      'entityType': serializer.toJson<String>(entityType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'contextSnapshotJson': serializer.toJson<String>(contextSnapshotJson),
      'inputSnapshotJson': serializer.toJson<String>(inputSnapshotJson),
      'outputSnapshotJson': serializer.toJson<String?>(outputSnapshotJson),
      'promptVersionUuid': serializer.toJson<String?>(promptVersionUuid),
      'modelUuid': serializer.toJson<String?>(modelUuid),
      'previousProvenanceUuid': serializer.toJson<String?>(
        previousProvenanceUuid,
      ),
      'integrityHash': serializer.toJson<String>(integrityHash),
    };
  }

  AiProvenance copyWith({
    String? uuid,
    String? provenanceType,
    String? entityUuid,
    String? entityType,
    DateTime? createdAt,
    String? contextSnapshotJson,
    String? inputSnapshotJson,
    Value<String?> outputSnapshotJson = const Value.absent(),
    Value<String?> promptVersionUuid = const Value.absent(),
    Value<String?> modelUuid = const Value.absent(),
    Value<String?> previousProvenanceUuid = const Value.absent(),
    String? integrityHash,
  }) => AiProvenance(
    uuid: uuid ?? this.uuid,
    provenanceType: provenanceType ?? this.provenanceType,
    entityUuid: entityUuid ?? this.entityUuid,
    entityType: entityType ?? this.entityType,
    createdAt: createdAt ?? this.createdAt,
    contextSnapshotJson: contextSnapshotJson ?? this.contextSnapshotJson,
    inputSnapshotJson: inputSnapshotJson ?? this.inputSnapshotJson,
    outputSnapshotJson: outputSnapshotJson.present
        ? outputSnapshotJson.value
        : this.outputSnapshotJson,
    promptVersionUuid: promptVersionUuid.present
        ? promptVersionUuid.value
        : this.promptVersionUuid,
    modelUuid: modelUuid.present ? modelUuid.value : this.modelUuid,
    previousProvenanceUuid: previousProvenanceUuid.present
        ? previousProvenanceUuid.value
        : this.previousProvenanceUuid,
    integrityHash: integrityHash ?? this.integrityHash,
  );
  AiProvenance copyWithCompanion(AiProvenancesCompanion data) {
    return AiProvenance(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      provenanceType: data.provenanceType.present
          ? data.provenanceType.value
          : this.provenanceType,
      entityUuid: data.entityUuid.present
          ? data.entityUuid.value
          : this.entityUuid,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      contextSnapshotJson: data.contextSnapshotJson.present
          ? data.contextSnapshotJson.value
          : this.contextSnapshotJson,
      inputSnapshotJson: data.inputSnapshotJson.present
          ? data.inputSnapshotJson.value
          : this.inputSnapshotJson,
      outputSnapshotJson: data.outputSnapshotJson.present
          ? data.outputSnapshotJson.value
          : this.outputSnapshotJson,
      promptVersionUuid: data.promptVersionUuid.present
          ? data.promptVersionUuid.value
          : this.promptVersionUuid,
      modelUuid: data.modelUuid.present ? data.modelUuid.value : this.modelUuid,
      previousProvenanceUuid: data.previousProvenanceUuid.present
          ? data.previousProvenanceUuid.value
          : this.previousProvenanceUuid,
      integrityHash: data.integrityHash.present
          ? data.integrityHash.value
          : this.integrityHash,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiProvenance(')
          ..write('uuid: $uuid, ')
          ..write('provenanceType: $provenanceType, ')
          ..write('entityUuid: $entityUuid, ')
          ..write('entityType: $entityType, ')
          ..write('createdAt: $createdAt, ')
          ..write('contextSnapshotJson: $contextSnapshotJson, ')
          ..write('inputSnapshotJson: $inputSnapshotJson, ')
          ..write('outputSnapshotJson: $outputSnapshotJson, ')
          ..write('promptVersionUuid: $promptVersionUuid, ')
          ..write('modelUuid: $modelUuid, ')
          ..write('previousProvenanceUuid: $previousProvenanceUuid, ')
          ..write('integrityHash: $integrityHash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uuid,
    provenanceType,
    entityUuid,
    entityType,
    createdAt,
    contextSnapshotJson,
    inputSnapshotJson,
    outputSnapshotJson,
    promptVersionUuid,
    modelUuid,
    previousProvenanceUuid,
    integrityHash,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiProvenance &&
          other.uuid == this.uuid &&
          other.provenanceType == this.provenanceType &&
          other.entityUuid == this.entityUuid &&
          other.entityType == this.entityType &&
          other.createdAt == this.createdAt &&
          other.contextSnapshotJson == this.contextSnapshotJson &&
          other.inputSnapshotJson == this.inputSnapshotJson &&
          other.outputSnapshotJson == this.outputSnapshotJson &&
          other.promptVersionUuid == this.promptVersionUuid &&
          other.modelUuid == this.modelUuid &&
          other.previousProvenanceUuid == this.previousProvenanceUuid &&
          other.integrityHash == this.integrityHash);
}

class AiProvenancesCompanion extends UpdateCompanion<AiProvenance> {
  final Value<String> uuid;
  final Value<String> provenanceType;
  final Value<String> entityUuid;
  final Value<String> entityType;
  final Value<DateTime> createdAt;
  final Value<String> contextSnapshotJson;
  final Value<String> inputSnapshotJson;
  final Value<String?> outputSnapshotJson;
  final Value<String?> promptVersionUuid;
  final Value<String?> modelUuid;
  final Value<String?> previousProvenanceUuid;
  final Value<String> integrityHash;
  final Value<int> rowid;
  const AiProvenancesCompanion({
    this.uuid = const Value.absent(),
    this.provenanceType = const Value.absent(),
    this.entityUuid = const Value.absent(),
    this.entityType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.contextSnapshotJson = const Value.absent(),
    this.inputSnapshotJson = const Value.absent(),
    this.outputSnapshotJson = const Value.absent(),
    this.promptVersionUuid = const Value.absent(),
    this.modelUuid = const Value.absent(),
    this.previousProvenanceUuid = const Value.absent(),
    this.integrityHash = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiProvenancesCompanion.insert({
    required String uuid,
    required String provenanceType,
    required String entityUuid,
    required String entityType,
    required DateTime createdAt,
    required String contextSnapshotJson,
    required String inputSnapshotJson,
    this.outputSnapshotJson = const Value.absent(),
    this.promptVersionUuid = const Value.absent(),
    this.modelUuid = const Value.absent(),
    this.previousProvenanceUuid = const Value.absent(),
    required String integrityHash,
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid),
       provenanceType = Value(provenanceType),
       entityUuid = Value(entityUuid),
       entityType = Value(entityType),
       createdAt = Value(createdAt),
       contextSnapshotJson = Value(contextSnapshotJson),
       inputSnapshotJson = Value(inputSnapshotJson),
       integrityHash = Value(integrityHash);
  static Insertable<AiProvenance> custom({
    Expression<String>? uuid,
    Expression<String>? provenanceType,
    Expression<String>? entityUuid,
    Expression<String>? entityType,
    Expression<DateTime>? createdAt,
    Expression<String>? contextSnapshotJson,
    Expression<String>? inputSnapshotJson,
    Expression<String>? outputSnapshotJson,
    Expression<String>? promptVersionUuid,
    Expression<String>? modelUuid,
    Expression<String>? previousProvenanceUuid,
    Expression<String>? integrityHash,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (provenanceType != null) 'provenance_type': provenanceType,
      if (entityUuid != null) 'entity_uuid': entityUuid,
      if (entityType != null) 'entity_type': entityType,
      if (createdAt != null) 'created_at': createdAt,
      if (contextSnapshotJson != null)
        'context_snapshot_json': contextSnapshotJson,
      if (inputSnapshotJson != null) 'input_snapshot_json': inputSnapshotJson,
      if (outputSnapshotJson != null)
        'output_snapshot_json': outputSnapshotJson,
      if (promptVersionUuid != null) 'prompt_version_uuid': promptVersionUuid,
      if (modelUuid != null) 'model_uuid': modelUuid,
      if (previousProvenanceUuid != null)
        'previous_provenance_uuid': previousProvenanceUuid,
      if (integrityHash != null) 'integrity_hash': integrityHash,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiProvenancesCompanion copyWith({
    Value<String>? uuid,
    Value<String>? provenanceType,
    Value<String>? entityUuid,
    Value<String>? entityType,
    Value<DateTime>? createdAt,
    Value<String>? contextSnapshotJson,
    Value<String>? inputSnapshotJson,
    Value<String?>? outputSnapshotJson,
    Value<String?>? promptVersionUuid,
    Value<String?>? modelUuid,
    Value<String?>? previousProvenanceUuid,
    Value<String>? integrityHash,
    Value<int>? rowid,
  }) {
    return AiProvenancesCompanion(
      uuid: uuid ?? this.uuid,
      provenanceType: provenanceType ?? this.provenanceType,
      entityUuid: entityUuid ?? this.entityUuid,
      entityType: entityType ?? this.entityType,
      createdAt: createdAt ?? this.createdAt,
      contextSnapshotJson: contextSnapshotJson ?? this.contextSnapshotJson,
      inputSnapshotJson: inputSnapshotJson ?? this.inputSnapshotJson,
      outputSnapshotJson: outputSnapshotJson ?? this.outputSnapshotJson,
      promptVersionUuid: promptVersionUuid ?? this.promptVersionUuid,
      modelUuid: modelUuid ?? this.modelUuid,
      previousProvenanceUuid:
          previousProvenanceUuid ?? this.previousProvenanceUuid,
      integrityHash: integrityHash ?? this.integrityHash,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (provenanceType.present) {
      map['provenance_type'] = Variable<String>(provenanceType.value);
    }
    if (entityUuid.present) {
      map['entity_uuid'] = Variable<String>(entityUuid.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (contextSnapshotJson.present) {
      map['context_snapshot_json'] = Variable<String>(
        contextSnapshotJson.value,
      );
    }
    if (inputSnapshotJson.present) {
      map['input_snapshot_json'] = Variable<String>(inputSnapshotJson.value);
    }
    if (outputSnapshotJson.present) {
      map['output_snapshot_json'] = Variable<String>(outputSnapshotJson.value);
    }
    if (promptVersionUuid.present) {
      map['prompt_version_uuid'] = Variable<String>(promptVersionUuid.value);
    }
    if (modelUuid.present) {
      map['model_uuid'] = Variable<String>(modelUuid.value);
    }
    if (previousProvenanceUuid.present) {
      map['previous_provenance_uuid'] = Variable<String>(
        previousProvenanceUuid.value,
      );
    }
    if (integrityHash.present) {
      map['integrity_hash'] = Variable<String>(integrityHash.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiProvenancesCompanion(')
          ..write('uuid: $uuid, ')
          ..write('provenanceType: $provenanceType, ')
          ..write('entityUuid: $entityUuid, ')
          ..write('entityType: $entityType, ')
          ..write('createdAt: $createdAt, ')
          ..write('contextSnapshotJson: $contextSnapshotJson, ')
          ..write('inputSnapshotJson: $inputSnapshotJson, ')
          ..write('outputSnapshotJson: $outputSnapshotJson, ')
          ..write('promptVersionUuid: $promptVersionUuid, ')
          ..write('modelUuid: $modelUuid, ')
          ..write('previousProvenanceUuid: $previousProvenanceUuid, ')
          ..write('integrityHash: $integrityHash, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiDivinationsTable extends AiDivinations
    with TableInfo<$AiDivinationsTable, AiDivination> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiDivinationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdatedAtMeta = const VerificationMeta(
    'lastUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedAt =
      GeneratedColumn<DateTime>(
        'last_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _divinationUuidMeta = const VerificationMeta(
    'divinationUuid',
  );
  @override
  late final GeneratedColumn<String> divinationUuid = GeneratedColumn<String>(
    'divination_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _personaUuidMeta = const VerificationMeta(
    'personaUuid',
  );
  @override
  late final GeneratedColumn<String> personaUuid = GeneratedColumn<String>(
    'persona_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES t_ai_personas (uuid)',
    ),
  );
  static const VerificationMeta _sessionUuidMeta = const VerificationMeta(
    'sessionUuid',
  );
  @override
  late final GeneratedColumn<String> sessionUuid = GeneratedColumn<String>(
    'session_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES t_ai_chat_sessions (uuid)',
    ),
  );
  static const VerificationMeta _interpretationMeta = const VerificationMeta(
    'interpretation',
  );
  @override
  late final GeneratedColumn<String> interpretation = GeneratedColumn<String>(
    'interpretation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fortuneLevelMeta = const VerificationMeta(
    'fortuneLevel',
  );
  @override
  late final GeneratedColumn<String> fortuneLevel = GeneratedColumn<String>(
    'fortune_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _adviceMeta = const VerificationMeta('advice');
  @override
  late final GeneratedColumn<String> advice = GeneratedColumn<String>(
    'advice',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resultTypeMeta = const VerificationMeta(
    'resultType',
  );
  @override
  late final GeneratedColumn<String> resultType = GeneratedColumn<String>(
    'result_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('summary'),
  );
  static const VerificationMeta _userRatingMeta = const VerificationMeta(
    'userRating',
  );
  @override
  late final GeneratedColumn<int> userRating = GeneratedColumn<int>(
    'user_rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userFeedbackMeta = const VerificationMeta(
    'userFeedback',
  );
  @override
  late final GeneratedColumn<String> userFeedback = GeneratedColumn<String>(
    'user_feedback',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _provenanceUuidMeta = const VerificationMeta(
    'provenanceUuid',
  );
  @override
  late final GeneratedColumn<String> provenanceUuid = GeneratedColumn<String>(
    'provenance_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES t_ai_provenance (uuid)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    uuid,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    divinationUuid,
    personaUuid,
    sessionUuid,
    interpretation,
    fortuneLevel,
    advice,
    resultType,
    userRating,
    userFeedback,
    provenanceUuid,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_ai_divinations';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiDivination> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
        _lastUpdatedAtMeta,
        lastUpdatedAt.isAcceptableOrUnknown(
          data['last_updated_at']!,
          _lastUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('divination_uuid')) {
      context.handle(
        _divinationUuidMeta,
        divinationUuid.isAcceptableOrUnknown(
          data['divination_uuid']!,
          _divinationUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_divinationUuidMeta);
    }
    if (data.containsKey('persona_uuid')) {
      context.handle(
        _personaUuidMeta,
        personaUuid.isAcceptableOrUnknown(
          data['persona_uuid']!,
          _personaUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_personaUuidMeta);
    }
    if (data.containsKey('session_uuid')) {
      context.handle(
        _sessionUuidMeta,
        sessionUuid.isAcceptableOrUnknown(
          data['session_uuid']!,
          _sessionUuidMeta,
        ),
      );
    }
    if (data.containsKey('interpretation')) {
      context.handle(
        _interpretationMeta,
        interpretation.isAcceptableOrUnknown(
          data['interpretation']!,
          _interpretationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_interpretationMeta);
    }
    if (data.containsKey('fortune_level')) {
      context.handle(
        _fortuneLevelMeta,
        fortuneLevel.isAcceptableOrUnknown(
          data['fortune_level']!,
          _fortuneLevelMeta,
        ),
      );
    }
    if (data.containsKey('advice')) {
      context.handle(
        _adviceMeta,
        advice.isAcceptableOrUnknown(data['advice']!, _adviceMeta),
      );
    }
    if (data.containsKey('result_type')) {
      context.handle(
        _resultTypeMeta,
        resultType.isAcceptableOrUnknown(data['result_type']!, _resultTypeMeta),
      );
    }
    if (data.containsKey('user_rating')) {
      context.handle(
        _userRatingMeta,
        userRating.isAcceptableOrUnknown(data['user_rating']!, _userRatingMeta),
      );
    }
    if (data.containsKey('user_feedback')) {
      context.handle(
        _userFeedbackMeta,
        userFeedback.isAcceptableOrUnknown(
          data['user_feedback']!,
          _userFeedbackMeta,
        ),
      );
    }
    if (data.containsKey('provenance_uuid')) {
      context.handle(
        _provenanceUuidMeta,
        provenanceUuid.isAcceptableOrUnknown(
          data['provenance_uuid']!,
          _provenanceUuidMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  AiDivination map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiDivination(
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      divinationUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}divination_uuid'],
      )!,
      personaUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}persona_uuid'],
      )!,
      sessionUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_uuid'],
      ),
      interpretation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}interpretation'],
      )!,
      fortuneLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fortune_level'],
      ),
      advice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}advice'],
      ),
      resultType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result_type'],
      )!,
      userRating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_rating'],
      ),
      userFeedback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_feedback'],
      ),
      provenanceUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provenance_uuid'],
      ),
    );
  }

  @override
  $AiDivinationsTable createAlias(String alias) {
    return $AiDivinationsTable(attachedDatabase, alias);
  }
}

class AiDivination extends DataClass implements Insertable<AiDivination> {
  final String uuid;
  final DateTime createdAt;
  final DateTime? lastUpdatedAt;
  final DateTime? deletedAt;

  /// 关联的占测 UUID (来自 common 模块)
  final String divinationUuid;

  /// 关联的 AI 人设 UUID
  final String personaUuid;

  /// 关联的对话会话 UUID
  final String? sessionUuid;

  /// AI 解读结果
  final String interpretation;

  /// AI 给出的吉凶判断
  final String? fortuneLevel;

  /// AI 建议
  final String? advice;

  /// 结果类型 (summary, detailed, teaching)
  final String resultType;

  /// 用户评分 (1-5)
  final int? userRating;

  /// 用户反馈
  final String? userFeedback;

  /// 溯源记录 UUID
  final String? provenanceUuid;
  const AiDivination({
    required this.uuid,
    required this.createdAt,
    this.lastUpdatedAt,
    this.deletedAt,
    required this.divinationUuid,
    required this.personaUuid,
    this.sessionUuid,
    required this.interpretation,
    this.fortuneLevel,
    this.advice,
    required this.resultType,
    this.userRating,
    this.userFeedback,
    this.provenanceUuid,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastUpdatedAt != null) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['divination_uuid'] = Variable<String>(divinationUuid);
    map['persona_uuid'] = Variable<String>(personaUuid);
    if (!nullToAbsent || sessionUuid != null) {
      map['session_uuid'] = Variable<String>(sessionUuid);
    }
    map['interpretation'] = Variable<String>(interpretation);
    if (!nullToAbsent || fortuneLevel != null) {
      map['fortune_level'] = Variable<String>(fortuneLevel);
    }
    if (!nullToAbsent || advice != null) {
      map['advice'] = Variable<String>(advice);
    }
    map['result_type'] = Variable<String>(resultType);
    if (!nullToAbsent || userRating != null) {
      map['user_rating'] = Variable<int>(userRating);
    }
    if (!nullToAbsent || userFeedback != null) {
      map['user_feedback'] = Variable<String>(userFeedback);
    }
    if (!nullToAbsent || provenanceUuid != null) {
      map['provenance_uuid'] = Variable<String>(provenanceUuid);
    }
    return map;
  }

  AiDivinationsCompanion toCompanion(bool nullToAbsent) {
    return AiDivinationsCompanion(
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      lastUpdatedAt: lastUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      divinationUuid: Value(divinationUuid),
      personaUuid: Value(personaUuid),
      sessionUuid: sessionUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionUuid),
      interpretation: Value(interpretation),
      fortuneLevel: fortuneLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(fortuneLevel),
      advice: advice == null && nullToAbsent
          ? const Value.absent()
          : Value(advice),
      resultType: Value(resultType),
      userRating: userRating == null && nullToAbsent
          ? const Value.absent()
          : Value(userRating),
      userFeedback: userFeedback == null && nullToAbsent
          ? const Value.absent()
          : Value(userFeedback),
      provenanceUuid: provenanceUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(provenanceUuid),
    );
  }

  factory AiDivination.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiDivination(
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdatedAt: serializer.fromJson<DateTime?>(json['lastUpdatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      divinationUuid: serializer.fromJson<String>(json['divinationUuid']),
      personaUuid: serializer.fromJson<String>(json['personaUuid']),
      sessionUuid: serializer.fromJson<String?>(json['sessionUuid']),
      interpretation: serializer.fromJson<String>(json['interpretation']),
      fortuneLevel: serializer.fromJson<String?>(json['fortuneLevel']),
      advice: serializer.fromJson<String?>(json['advice']),
      resultType: serializer.fromJson<String>(json['resultType']),
      userRating: serializer.fromJson<int?>(json['userRating']),
      userFeedback: serializer.fromJson<String?>(json['userFeedback']),
      provenanceUuid: serializer.fromJson<String?>(json['provenanceUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdatedAt': serializer.toJson<DateTime?>(lastUpdatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'divinationUuid': serializer.toJson<String>(divinationUuid),
      'personaUuid': serializer.toJson<String>(personaUuid),
      'sessionUuid': serializer.toJson<String?>(sessionUuid),
      'interpretation': serializer.toJson<String>(interpretation),
      'fortuneLevel': serializer.toJson<String?>(fortuneLevel),
      'advice': serializer.toJson<String?>(advice),
      'resultType': serializer.toJson<String>(resultType),
      'userRating': serializer.toJson<int?>(userRating),
      'userFeedback': serializer.toJson<String?>(userFeedback),
      'provenanceUuid': serializer.toJson<String?>(provenanceUuid),
    };
  }

  AiDivination copyWith({
    String? uuid,
    DateTime? createdAt,
    Value<DateTime?> lastUpdatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? divinationUuid,
    String? personaUuid,
    Value<String?> sessionUuid = const Value.absent(),
    String? interpretation,
    Value<String?> fortuneLevel = const Value.absent(),
    Value<String?> advice = const Value.absent(),
    String? resultType,
    Value<int?> userRating = const Value.absent(),
    Value<String?> userFeedback = const Value.absent(),
    Value<String?> provenanceUuid = const Value.absent(),
  }) => AiDivination(
    uuid: uuid ?? this.uuid,
    createdAt: createdAt ?? this.createdAt,
    lastUpdatedAt: lastUpdatedAt.present
        ? lastUpdatedAt.value
        : this.lastUpdatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    divinationUuid: divinationUuid ?? this.divinationUuid,
    personaUuid: personaUuid ?? this.personaUuid,
    sessionUuid: sessionUuid.present ? sessionUuid.value : this.sessionUuid,
    interpretation: interpretation ?? this.interpretation,
    fortuneLevel: fortuneLevel.present ? fortuneLevel.value : this.fortuneLevel,
    advice: advice.present ? advice.value : this.advice,
    resultType: resultType ?? this.resultType,
    userRating: userRating.present ? userRating.value : this.userRating,
    userFeedback: userFeedback.present ? userFeedback.value : this.userFeedback,
    provenanceUuid: provenanceUuid.present
        ? provenanceUuid.value
        : this.provenanceUuid,
  );
  AiDivination copyWithCompanion(AiDivinationsCompanion data) {
    return AiDivination(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      divinationUuid: data.divinationUuid.present
          ? data.divinationUuid.value
          : this.divinationUuid,
      personaUuid: data.personaUuid.present
          ? data.personaUuid.value
          : this.personaUuid,
      sessionUuid: data.sessionUuid.present
          ? data.sessionUuid.value
          : this.sessionUuid,
      interpretation: data.interpretation.present
          ? data.interpretation.value
          : this.interpretation,
      fortuneLevel: data.fortuneLevel.present
          ? data.fortuneLevel.value
          : this.fortuneLevel,
      advice: data.advice.present ? data.advice.value : this.advice,
      resultType: data.resultType.present
          ? data.resultType.value
          : this.resultType,
      userRating: data.userRating.present
          ? data.userRating.value
          : this.userRating,
      userFeedback: data.userFeedback.present
          ? data.userFeedback.value
          : this.userFeedback,
      provenanceUuid: data.provenanceUuid.present
          ? data.provenanceUuid.value
          : this.provenanceUuid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiDivination(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('divinationUuid: $divinationUuid, ')
          ..write('personaUuid: $personaUuid, ')
          ..write('sessionUuid: $sessionUuid, ')
          ..write('interpretation: $interpretation, ')
          ..write('fortuneLevel: $fortuneLevel, ')
          ..write('advice: $advice, ')
          ..write('resultType: $resultType, ')
          ..write('userRating: $userRating, ')
          ..write('userFeedback: $userFeedback, ')
          ..write('provenanceUuid: $provenanceUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uuid,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    divinationUuid,
    personaUuid,
    sessionUuid,
    interpretation,
    fortuneLevel,
    advice,
    resultType,
    userRating,
    userFeedback,
    provenanceUuid,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiDivination &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.deletedAt == this.deletedAt &&
          other.divinationUuid == this.divinationUuid &&
          other.personaUuid == this.personaUuid &&
          other.sessionUuid == this.sessionUuid &&
          other.interpretation == this.interpretation &&
          other.fortuneLevel == this.fortuneLevel &&
          other.advice == this.advice &&
          other.resultType == this.resultType &&
          other.userRating == this.userRating &&
          other.userFeedback == this.userFeedback &&
          other.provenanceUuid == this.provenanceUuid);
}

class AiDivinationsCompanion extends UpdateCompanion<AiDivination> {
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastUpdatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> divinationUuid;
  final Value<String> personaUuid;
  final Value<String?> sessionUuid;
  final Value<String> interpretation;
  final Value<String?> fortuneLevel;
  final Value<String?> advice;
  final Value<String> resultType;
  final Value<int?> userRating;
  final Value<String?> userFeedback;
  final Value<String?> provenanceUuid;
  final Value<int> rowid;
  const AiDivinationsCompanion({
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.divinationUuid = const Value.absent(),
    this.personaUuid = const Value.absent(),
    this.sessionUuid = const Value.absent(),
    this.interpretation = const Value.absent(),
    this.fortuneLevel = const Value.absent(),
    this.advice = const Value.absent(),
    this.resultType = const Value.absent(),
    this.userRating = const Value.absent(),
    this.userFeedback = const Value.absent(),
    this.provenanceUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiDivinationsCompanion.insert({
    required String uuid,
    required DateTime createdAt,
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String divinationUuid,
    required String personaUuid,
    this.sessionUuid = const Value.absent(),
    required String interpretation,
    this.fortuneLevel = const Value.absent(),
    this.advice = const Value.absent(),
    this.resultType = const Value.absent(),
    this.userRating = const Value.absent(),
    this.userFeedback = const Value.absent(),
    this.provenanceUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid),
       createdAt = Value(createdAt),
       divinationUuid = Value(divinationUuid),
       personaUuid = Value(personaUuid),
       interpretation = Value(interpretation);
  static Insertable<AiDivination> custom({
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? divinationUuid,
    Expression<String>? personaUuid,
    Expression<String>? sessionUuid,
    Expression<String>? interpretation,
    Expression<String>? fortuneLevel,
    Expression<String>? advice,
    Expression<String>? resultType,
    Expression<int>? userRating,
    Expression<String>? userFeedback,
    Expression<String>? provenanceUuid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (divinationUuid != null) 'divination_uuid': divinationUuid,
      if (personaUuid != null) 'persona_uuid': personaUuid,
      if (sessionUuid != null) 'session_uuid': sessionUuid,
      if (interpretation != null) 'interpretation': interpretation,
      if (fortuneLevel != null) 'fortune_level': fortuneLevel,
      if (advice != null) 'advice': advice,
      if (resultType != null) 'result_type': resultType,
      if (userRating != null) 'user_rating': userRating,
      if (userFeedback != null) 'user_feedback': userFeedback,
      if (provenanceUuid != null) 'provenance_uuid': provenanceUuid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiDivinationsCompanion copyWith({
    Value<String>? uuid,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastUpdatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? divinationUuid,
    Value<String>? personaUuid,
    Value<String?>? sessionUuid,
    Value<String>? interpretation,
    Value<String?>? fortuneLevel,
    Value<String?>? advice,
    Value<String>? resultType,
    Value<int?>? userRating,
    Value<String?>? userFeedback,
    Value<String?>? provenanceUuid,
    Value<int>? rowid,
  }) {
    return AiDivinationsCompanion(
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      divinationUuid: divinationUuid ?? this.divinationUuid,
      personaUuid: personaUuid ?? this.personaUuid,
      sessionUuid: sessionUuid ?? this.sessionUuid,
      interpretation: interpretation ?? this.interpretation,
      fortuneLevel: fortuneLevel ?? this.fortuneLevel,
      advice: advice ?? this.advice,
      resultType: resultType ?? this.resultType,
      userRating: userRating ?? this.userRating,
      userFeedback: userFeedback ?? this.userFeedback,
      provenanceUuid: provenanceUuid ?? this.provenanceUuid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (divinationUuid.present) {
      map['divination_uuid'] = Variable<String>(divinationUuid.value);
    }
    if (personaUuid.present) {
      map['persona_uuid'] = Variable<String>(personaUuid.value);
    }
    if (sessionUuid.present) {
      map['session_uuid'] = Variable<String>(sessionUuid.value);
    }
    if (interpretation.present) {
      map['interpretation'] = Variable<String>(interpretation.value);
    }
    if (fortuneLevel.present) {
      map['fortune_level'] = Variable<String>(fortuneLevel.value);
    }
    if (advice.present) {
      map['advice'] = Variable<String>(advice.value);
    }
    if (resultType.present) {
      map['result_type'] = Variable<String>(resultType.value);
    }
    if (userRating.present) {
      map['user_rating'] = Variable<int>(userRating.value);
    }
    if (userFeedback.present) {
      map['user_feedback'] = Variable<String>(userFeedback.value);
    }
    if (provenanceUuid.present) {
      map['provenance_uuid'] = Variable<String>(provenanceUuid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiDivinationsCompanion(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('divinationUuid: $divinationUuid, ')
          ..write('personaUuid: $personaUuid, ')
          ..write('sessionUuid: $sessionUuid, ')
          ..write('interpretation: $interpretation, ')
          ..write('fortuneLevel: $fortuneLevel, ')
          ..write('advice: $advice, ')
          ..write('resultType: $resultType, ')
          ..write('userRating: $userRating, ')
          ..write('userFeedback: $userFeedback, ')
          ..write('provenanceUuid: $provenanceUuid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AgentInvocationsTable extends AgentInvocations
    with TableInfo<$AgentInvocationsTable, AgentInvocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgentInvocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _callerPersonaUuidMeta = const VerificationMeta(
    'callerPersonaUuid',
  );
  @override
  late final GeneratedColumn<String> callerPersonaUuid =
      GeneratedColumn<String>(
        'caller_persona_uuid',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES t_ai_personas (uuid)',
        ),
      );
  static const VerificationMeta _calleePersonaUuidMeta = const VerificationMeta(
    'calleePersonaUuid',
  );
  @override
  late final GeneratedColumn<String> calleePersonaUuid =
      GeneratedColumn<String>(
        'callee_persona_uuid',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES t_ai_personas (uuid)',
        ),
      );
  static const VerificationMeta _sessionUuidMeta = const VerificationMeta(
    'sessionUuid',
  );
  @override
  late final GeneratedColumn<String> sessionUuid = GeneratedColumn<String>(
    'session_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES t_ai_chat_sessions (uuid)',
    ),
  );
  static const VerificationMeta _invokedAtMeta = const VerificationMeta(
    'invokedAt',
  );
  @override
  late final GeneratedColumn<DateTime> invokedAt = GeneratedColumn<DateTime>(
    'invoked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purposeMeta = const VerificationMeta(
    'purpose',
  );
  @override
  late final GeneratedColumn<String> purpose = GeneratedColumn<String>(
    'purpose',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sharedContextJsonMeta = const VerificationMeta(
    'sharedContextJson',
  );
  @override
  late final GeneratedColumn<String> sharedContextJson =
      GeneratedColumn<String>(
        'shared_context_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _resultJsonMeta = const VerificationMeta(
    'resultJson',
  );
  @override
  late final GeneratedColumn<String> resultJson = GeneratedColumn<String>(
    'result_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parentInvocationUuidMeta =
      const VerificationMeta('parentInvocationUuid');
  @override
  late final GeneratedColumn<String> parentInvocationUuid =
      GeneratedColumn<String>(
        'parent_invocation_uuid',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _depthMeta = const VerificationMeta('depth');
  @override
  late final GeneratedColumn<int> depth = GeneratedColumn<int>(
    'depth',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    uuid,
    callerPersonaUuid,
    calleePersonaUuid,
    sessionUuid,
    invokedAt,
    completedAt,
    purpose,
    sharedContextJson,
    resultJson,
    status,
    errorMessage,
    parentInvocationUuid,
    depth,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_agent_invocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<AgentInvocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('caller_persona_uuid')) {
      context.handle(
        _callerPersonaUuidMeta,
        callerPersonaUuid.isAcceptableOrUnknown(
          data['caller_persona_uuid']!,
          _callerPersonaUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_callerPersonaUuidMeta);
    }
    if (data.containsKey('callee_persona_uuid')) {
      context.handle(
        _calleePersonaUuidMeta,
        calleePersonaUuid.isAcceptableOrUnknown(
          data['callee_persona_uuid']!,
          _calleePersonaUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_calleePersonaUuidMeta);
    }
    if (data.containsKey('session_uuid')) {
      context.handle(
        _sessionUuidMeta,
        sessionUuid.isAcceptableOrUnknown(
          data['session_uuid']!,
          _sessionUuidMeta,
        ),
      );
    }
    if (data.containsKey('invoked_at')) {
      context.handle(
        _invokedAtMeta,
        invokedAt.isAcceptableOrUnknown(data['invoked_at']!, _invokedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_invokedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('purpose')) {
      context.handle(
        _purposeMeta,
        purpose.isAcceptableOrUnknown(data['purpose']!, _purposeMeta),
      );
    } else if (isInserting) {
      context.missing(_purposeMeta);
    }
    if (data.containsKey('shared_context_json')) {
      context.handle(
        _sharedContextJsonMeta,
        sharedContextJson.isAcceptableOrUnknown(
          data['shared_context_json']!,
          _sharedContextJsonMeta,
        ),
      );
    }
    if (data.containsKey('result_json')) {
      context.handle(
        _resultJsonMeta,
        resultJson.isAcceptableOrUnknown(data['result_json']!, _resultJsonMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('parent_invocation_uuid')) {
      context.handle(
        _parentInvocationUuidMeta,
        parentInvocationUuid.isAcceptableOrUnknown(
          data['parent_invocation_uuid']!,
          _parentInvocationUuidMeta,
        ),
      );
    }
    if (data.containsKey('depth')) {
      context.handle(
        _depthMeta,
        depth.isAcceptableOrUnknown(data['depth']!, _depthMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  AgentInvocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AgentInvocation(
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      callerPersonaUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caller_persona_uuid'],
      )!,
      calleePersonaUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}callee_persona_uuid'],
      )!,
      sessionUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_uuid'],
      ),
      invokedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}invoked_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      purpose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purpose'],
      )!,
      sharedContextJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shared_context_json'],
      ),
      resultJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result_json'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      parentInvocationUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_invocation_uuid'],
      ),
      depth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}depth'],
      )!,
    );
  }

  @override
  $AgentInvocationsTable createAlias(String alias) {
    return $AgentInvocationsTable(attachedDatabase, alias);
  }
}

class AgentInvocation extends DataClass implements Insertable<AgentInvocation> {
  final String uuid;

  /// 调用者 Agent 人设 UUID
  final String callerPersonaUuid;

  /// 被调用者 Agent 人设 UUID
  final String calleePersonaUuid;

  /// 关联的会话 UUID
  final String? sessionUuid;

  /// 调用时间
  final DateTime invokedAt;

  /// 完成时间
  final DateTime? completedAt;

  /// 调用目的/任务描述
  final String purpose;

  /// 共享上下文 (JSON)
  final String? sharedContextJson;

  /// 调用结果 (JSON)
  final String? resultJson;

  /// 调用状态 (pending, running, completed, failed, timeout)
  final String status;

  /// 错误信息
  final String? errorMessage;

  /// 调用链父级 UUID (用于追踪嵌套调用)
  final String? parentInvocationUuid;

  /// 调用深度
  final int depth;
  const AgentInvocation({
    required this.uuid,
    required this.callerPersonaUuid,
    required this.calleePersonaUuid,
    this.sessionUuid,
    required this.invokedAt,
    this.completedAt,
    required this.purpose,
    this.sharedContextJson,
    this.resultJson,
    required this.status,
    this.errorMessage,
    this.parentInvocationUuid,
    required this.depth,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['caller_persona_uuid'] = Variable<String>(callerPersonaUuid);
    map['callee_persona_uuid'] = Variable<String>(calleePersonaUuid);
    if (!nullToAbsent || sessionUuid != null) {
      map['session_uuid'] = Variable<String>(sessionUuid);
    }
    map['invoked_at'] = Variable<DateTime>(invokedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['purpose'] = Variable<String>(purpose);
    if (!nullToAbsent || sharedContextJson != null) {
      map['shared_context_json'] = Variable<String>(sharedContextJson);
    }
    if (!nullToAbsent || resultJson != null) {
      map['result_json'] = Variable<String>(resultJson);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    if (!nullToAbsent || parentInvocationUuid != null) {
      map['parent_invocation_uuid'] = Variable<String>(parentInvocationUuid);
    }
    map['depth'] = Variable<int>(depth);
    return map;
  }

  AgentInvocationsCompanion toCompanion(bool nullToAbsent) {
    return AgentInvocationsCompanion(
      uuid: Value(uuid),
      callerPersonaUuid: Value(callerPersonaUuid),
      calleePersonaUuid: Value(calleePersonaUuid),
      sessionUuid: sessionUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionUuid),
      invokedAt: Value(invokedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      purpose: Value(purpose),
      sharedContextJson: sharedContextJson == null && nullToAbsent
          ? const Value.absent()
          : Value(sharedContextJson),
      resultJson: resultJson == null && nullToAbsent
          ? const Value.absent()
          : Value(resultJson),
      status: Value(status),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      parentInvocationUuid: parentInvocationUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(parentInvocationUuid),
      depth: Value(depth),
    );
  }

  factory AgentInvocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AgentInvocation(
      uuid: serializer.fromJson<String>(json['uuid']),
      callerPersonaUuid: serializer.fromJson<String>(json['callerPersonaUuid']),
      calleePersonaUuid: serializer.fromJson<String>(json['calleePersonaUuid']),
      sessionUuid: serializer.fromJson<String?>(json['sessionUuid']),
      invokedAt: serializer.fromJson<DateTime>(json['invokedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      purpose: serializer.fromJson<String>(json['purpose']),
      sharedContextJson: serializer.fromJson<String?>(
        json['sharedContextJson'],
      ),
      resultJson: serializer.fromJson<String?>(json['resultJson']),
      status: serializer.fromJson<String>(json['status']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      parentInvocationUuid: serializer.fromJson<String?>(
        json['parentInvocationUuid'],
      ),
      depth: serializer.fromJson<int>(json['depth']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'callerPersonaUuid': serializer.toJson<String>(callerPersonaUuid),
      'calleePersonaUuid': serializer.toJson<String>(calleePersonaUuid),
      'sessionUuid': serializer.toJson<String?>(sessionUuid),
      'invokedAt': serializer.toJson<DateTime>(invokedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'purpose': serializer.toJson<String>(purpose),
      'sharedContextJson': serializer.toJson<String?>(sharedContextJson),
      'resultJson': serializer.toJson<String?>(resultJson),
      'status': serializer.toJson<String>(status),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'parentInvocationUuid': serializer.toJson<String?>(parentInvocationUuid),
      'depth': serializer.toJson<int>(depth),
    };
  }

  AgentInvocation copyWith({
    String? uuid,
    String? callerPersonaUuid,
    String? calleePersonaUuid,
    Value<String?> sessionUuid = const Value.absent(),
    DateTime? invokedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    String? purpose,
    Value<String?> sharedContextJson = const Value.absent(),
    Value<String?> resultJson = const Value.absent(),
    String? status,
    Value<String?> errorMessage = const Value.absent(),
    Value<String?> parentInvocationUuid = const Value.absent(),
    int? depth,
  }) => AgentInvocation(
    uuid: uuid ?? this.uuid,
    callerPersonaUuid: callerPersonaUuid ?? this.callerPersonaUuid,
    calleePersonaUuid: calleePersonaUuid ?? this.calleePersonaUuid,
    sessionUuid: sessionUuid.present ? sessionUuid.value : this.sessionUuid,
    invokedAt: invokedAt ?? this.invokedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    purpose: purpose ?? this.purpose,
    sharedContextJson: sharedContextJson.present
        ? sharedContextJson.value
        : this.sharedContextJson,
    resultJson: resultJson.present ? resultJson.value : this.resultJson,
    status: status ?? this.status,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    parentInvocationUuid: parentInvocationUuid.present
        ? parentInvocationUuid.value
        : this.parentInvocationUuid,
    depth: depth ?? this.depth,
  );
  AgentInvocation copyWithCompanion(AgentInvocationsCompanion data) {
    return AgentInvocation(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      callerPersonaUuid: data.callerPersonaUuid.present
          ? data.callerPersonaUuid.value
          : this.callerPersonaUuid,
      calleePersonaUuid: data.calleePersonaUuid.present
          ? data.calleePersonaUuid.value
          : this.calleePersonaUuid,
      sessionUuid: data.sessionUuid.present
          ? data.sessionUuid.value
          : this.sessionUuid,
      invokedAt: data.invokedAt.present ? data.invokedAt.value : this.invokedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      purpose: data.purpose.present ? data.purpose.value : this.purpose,
      sharedContextJson: data.sharedContextJson.present
          ? data.sharedContextJson.value
          : this.sharedContextJson,
      resultJson: data.resultJson.present
          ? data.resultJson.value
          : this.resultJson,
      status: data.status.present ? data.status.value : this.status,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      parentInvocationUuid: data.parentInvocationUuid.present
          ? data.parentInvocationUuid.value
          : this.parentInvocationUuid,
      depth: data.depth.present ? data.depth.value : this.depth,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AgentInvocation(')
          ..write('uuid: $uuid, ')
          ..write('callerPersonaUuid: $callerPersonaUuid, ')
          ..write('calleePersonaUuid: $calleePersonaUuid, ')
          ..write('sessionUuid: $sessionUuid, ')
          ..write('invokedAt: $invokedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('purpose: $purpose, ')
          ..write('sharedContextJson: $sharedContextJson, ')
          ..write('resultJson: $resultJson, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('parentInvocationUuid: $parentInvocationUuid, ')
          ..write('depth: $depth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uuid,
    callerPersonaUuid,
    calleePersonaUuid,
    sessionUuid,
    invokedAt,
    completedAt,
    purpose,
    sharedContextJson,
    resultJson,
    status,
    errorMessage,
    parentInvocationUuid,
    depth,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AgentInvocation &&
          other.uuid == this.uuid &&
          other.callerPersonaUuid == this.callerPersonaUuid &&
          other.calleePersonaUuid == this.calleePersonaUuid &&
          other.sessionUuid == this.sessionUuid &&
          other.invokedAt == this.invokedAt &&
          other.completedAt == this.completedAt &&
          other.purpose == this.purpose &&
          other.sharedContextJson == this.sharedContextJson &&
          other.resultJson == this.resultJson &&
          other.status == this.status &&
          other.errorMessage == this.errorMessage &&
          other.parentInvocationUuid == this.parentInvocationUuid &&
          other.depth == this.depth);
}

class AgentInvocationsCompanion extends UpdateCompanion<AgentInvocation> {
  final Value<String> uuid;
  final Value<String> callerPersonaUuid;
  final Value<String> calleePersonaUuid;
  final Value<String?> sessionUuid;
  final Value<DateTime> invokedAt;
  final Value<DateTime?> completedAt;
  final Value<String> purpose;
  final Value<String?> sharedContextJson;
  final Value<String?> resultJson;
  final Value<String> status;
  final Value<String?> errorMessage;
  final Value<String?> parentInvocationUuid;
  final Value<int> depth;
  final Value<int> rowid;
  const AgentInvocationsCompanion({
    this.uuid = const Value.absent(),
    this.callerPersonaUuid = const Value.absent(),
    this.calleePersonaUuid = const Value.absent(),
    this.sessionUuid = const Value.absent(),
    this.invokedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.purpose = const Value.absent(),
    this.sharedContextJson = const Value.absent(),
    this.resultJson = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.parentInvocationUuid = const Value.absent(),
    this.depth = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AgentInvocationsCompanion.insert({
    required String uuid,
    required String callerPersonaUuid,
    required String calleePersonaUuid,
    this.sessionUuid = const Value.absent(),
    required DateTime invokedAt,
    this.completedAt = const Value.absent(),
    required String purpose,
    this.sharedContextJson = const Value.absent(),
    this.resultJson = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.parentInvocationUuid = const Value.absent(),
    this.depth = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid),
       callerPersonaUuid = Value(callerPersonaUuid),
       calleePersonaUuid = Value(calleePersonaUuid),
       invokedAt = Value(invokedAt),
       purpose = Value(purpose);
  static Insertable<AgentInvocation> custom({
    Expression<String>? uuid,
    Expression<String>? callerPersonaUuid,
    Expression<String>? calleePersonaUuid,
    Expression<String>? sessionUuid,
    Expression<DateTime>? invokedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? purpose,
    Expression<String>? sharedContextJson,
    Expression<String>? resultJson,
    Expression<String>? status,
    Expression<String>? errorMessage,
    Expression<String>? parentInvocationUuid,
    Expression<int>? depth,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (callerPersonaUuid != null) 'caller_persona_uuid': callerPersonaUuid,
      if (calleePersonaUuid != null) 'callee_persona_uuid': calleePersonaUuid,
      if (sessionUuid != null) 'session_uuid': sessionUuid,
      if (invokedAt != null) 'invoked_at': invokedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (purpose != null) 'purpose': purpose,
      if (sharedContextJson != null) 'shared_context_json': sharedContextJson,
      if (resultJson != null) 'result_json': resultJson,
      if (status != null) 'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
      if (parentInvocationUuid != null)
        'parent_invocation_uuid': parentInvocationUuid,
      if (depth != null) 'depth': depth,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AgentInvocationsCompanion copyWith({
    Value<String>? uuid,
    Value<String>? callerPersonaUuid,
    Value<String>? calleePersonaUuid,
    Value<String?>? sessionUuid,
    Value<DateTime>? invokedAt,
    Value<DateTime?>? completedAt,
    Value<String>? purpose,
    Value<String?>? sharedContextJson,
    Value<String?>? resultJson,
    Value<String>? status,
    Value<String?>? errorMessage,
    Value<String?>? parentInvocationUuid,
    Value<int>? depth,
    Value<int>? rowid,
  }) {
    return AgentInvocationsCompanion(
      uuid: uuid ?? this.uuid,
      callerPersonaUuid: callerPersonaUuid ?? this.callerPersonaUuid,
      calleePersonaUuid: calleePersonaUuid ?? this.calleePersonaUuid,
      sessionUuid: sessionUuid ?? this.sessionUuid,
      invokedAt: invokedAt ?? this.invokedAt,
      completedAt: completedAt ?? this.completedAt,
      purpose: purpose ?? this.purpose,
      sharedContextJson: sharedContextJson ?? this.sharedContextJson,
      resultJson: resultJson ?? this.resultJson,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      parentInvocationUuid: parentInvocationUuid ?? this.parentInvocationUuid,
      depth: depth ?? this.depth,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (callerPersonaUuid.present) {
      map['caller_persona_uuid'] = Variable<String>(callerPersonaUuid.value);
    }
    if (calleePersonaUuid.present) {
      map['callee_persona_uuid'] = Variable<String>(calleePersonaUuid.value);
    }
    if (sessionUuid.present) {
      map['session_uuid'] = Variable<String>(sessionUuid.value);
    }
    if (invokedAt.present) {
      map['invoked_at'] = Variable<DateTime>(invokedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (purpose.present) {
      map['purpose'] = Variable<String>(purpose.value);
    }
    if (sharedContextJson.present) {
      map['shared_context_json'] = Variable<String>(sharedContextJson.value);
    }
    if (resultJson.present) {
      map['result_json'] = Variable<String>(resultJson.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (parentInvocationUuid.present) {
      map['parent_invocation_uuid'] = Variable<String>(
        parentInvocationUuid.value,
      );
    }
    if (depth.present) {
      map['depth'] = Variable<int>(depth.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgentInvocationsCompanion(')
          ..write('uuid: $uuid, ')
          ..write('callerPersonaUuid: $callerPersonaUuid, ')
          ..write('calleePersonaUuid: $calleePersonaUuid, ')
          ..write('sessionUuid: $sessionUuid, ')
          ..write('invokedAt: $invokedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('purpose: $purpose, ')
          ..write('sharedContextJson: $sharedContextJson, ')
          ..write('resultJson: $resultJson, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('parentInvocationUuid: $parentInvocationUuid, ')
          ..write('depth: $depth, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiUsageAuditsTable extends AiUsageAudits
    with TableInfo<$AiUsageAuditsTable, AiUsageAudit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiUsageAuditsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _auditedAtMeta = const VerificationMeta(
    'auditedAt',
  );
  @override
  late final GeneratedColumn<DateTime> auditedAt = GeneratedColumn<DateTime>(
    'audited_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _auditTypeMeta = const VerificationMeta(
    'auditType',
  );
  @override
  late final GeneratedColumn<String> auditType = GeneratedColumn<String>(
    'audit_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityUuidMeta = const VerificationMeta(
    'entityUuid',
  );
  @override
  late final GeneratedColumn<String> entityUuid = GeneratedColumn<String>(
    'entity_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdentifierMeta = const VerificationMeta(
    'userIdentifier',
  );
  @override
  late final GeneratedColumn<String> userIdentifier = GeneratedColumn<String>(
    'user_identifier',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailsJsonMeta = const VerificationMeta(
    'detailsJson',
  );
  @override
  late final GeneratedColumn<String> detailsJson = GeneratedColumn<String>(
    'details_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tokensUsedMeta = const VerificationMeta(
    'tokensUsed',
  );
  @override
  late final GeneratedColumn<int> tokensUsed = GeneratedColumn<int>(
    'tokens_used',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedCostMeta = const VerificationMeta(
    'estimatedCost',
  );
  @override
  late final GeneratedColumn<double> estimatedCost = GeneratedColumn<double>(
    'estimated_cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ipAddressMeta = const VerificationMeta(
    'ipAddress',
  );
  @override
  late final GeneratedColumn<String> ipAddress = GeneratedColumn<String>(
    'ip_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceInfoMeta = const VerificationMeta(
    'deviceInfo',
  );
  @override
  late final GeneratedColumn<String> deviceInfo = GeneratedColumn<String>(
    'device_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    auditedAt,
    auditType,
    entityUuid,
    entityType,
    userIdentifier,
    action,
    detailsJson,
    tokensUsed,
    estimatedCost,
    ipAddress,
    deviceInfo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_ai_usage_audits';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiUsageAudit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('audited_at')) {
      context.handle(
        _auditedAtMeta,
        auditedAt.isAcceptableOrUnknown(data['audited_at']!, _auditedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_auditedAtMeta);
    }
    if (data.containsKey('audit_type')) {
      context.handle(
        _auditTypeMeta,
        auditType.isAcceptableOrUnknown(data['audit_type']!, _auditTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_auditTypeMeta);
    }
    if (data.containsKey('entity_uuid')) {
      context.handle(
        _entityUuidMeta,
        entityUuid.isAcceptableOrUnknown(data['entity_uuid']!, _entityUuidMeta),
      );
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    }
    if (data.containsKey('user_identifier')) {
      context.handle(
        _userIdentifierMeta,
        userIdentifier.isAcceptableOrUnknown(
          data['user_identifier']!,
          _userIdentifierMeta,
        ),
      );
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('details_json')) {
      context.handle(
        _detailsJsonMeta,
        detailsJson.isAcceptableOrUnknown(
          data['details_json']!,
          _detailsJsonMeta,
        ),
      );
    }
    if (data.containsKey('tokens_used')) {
      context.handle(
        _tokensUsedMeta,
        tokensUsed.isAcceptableOrUnknown(data['tokens_used']!, _tokensUsedMeta),
      );
    }
    if (data.containsKey('estimated_cost')) {
      context.handle(
        _estimatedCostMeta,
        estimatedCost.isAcceptableOrUnknown(
          data['estimated_cost']!,
          _estimatedCostMeta,
        ),
      );
    }
    if (data.containsKey('ip_address')) {
      context.handle(
        _ipAddressMeta,
        ipAddress.isAcceptableOrUnknown(data['ip_address']!, _ipAddressMeta),
      );
    }
    if (data.containsKey('device_info')) {
      context.handle(
        _deviceInfoMeta,
        deviceInfo.isAcceptableOrUnknown(data['device_info']!, _deviceInfoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiUsageAudit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiUsageAudit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      auditedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}audited_at'],
      )!,
      auditType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audit_type'],
      )!,
      entityUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_uuid'],
      ),
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      ),
      userIdentifier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_identifier'],
      ),
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      detailsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details_json'],
      ),
      tokensUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tokens_used'],
      ),
      estimatedCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_cost'],
      ),
      ipAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ip_address'],
      ),
      deviceInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_info'],
      ),
    );
  }

  @override
  $AiUsageAuditsTable createAlias(String alias) {
    return $AiUsageAuditsTable(attachedDatabase, alias);
  }
}

class AiUsageAudit extends DataClass implements Insertable<AiUsageAudit> {
  final int id;

  /// 审计时间
  final DateTime auditedAt;

  /// 审计类型 (api_call, token_usage, error, security)
  final String auditType;

  /// 关联的实体 UUID
  final String? entityUuid;

  /// 关联的实体类型
  final String? entityType;

  /// 关联的用户/会话标识
  final String? userIdentifier;

  /// 操作描述
  final String action;

  /// 详细信息 (JSON)
  final String? detailsJson;

  /// token 消耗
  final int? tokensUsed;

  /// 费用估算
  final double? estimatedCost;

  /// IP 地址
  final String? ipAddress;

  /// 设备信息
  final String? deviceInfo;
  const AiUsageAudit({
    required this.id,
    required this.auditedAt,
    required this.auditType,
    this.entityUuid,
    this.entityType,
    this.userIdentifier,
    required this.action,
    this.detailsJson,
    this.tokensUsed,
    this.estimatedCost,
    this.ipAddress,
    this.deviceInfo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['audited_at'] = Variable<DateTime>(auditedAt);
    map['audit_type'] = Variable<String>(auditType);
    if (!nullToAbsent || entityUuid != null) {
      map['entity_uuid'] = Variable<String>(entityUuid);
    }
    if (!nullToAbsent || entityType != null) {
      map['entity_type'] = Variable<String>(entityType);
    }
    if (!nullToAbsent || userIdentifier != null) {
      map['user_identifier'] = Variable<String>(userIdentifier);
    }
    map['action'] = Variable<String>(action);
    if (!nullToAbsent || detailsJson != null) {
      map['details_json'] = Variable<String>(detailsJson);
    }
    if (!nullToAbsent || tokensUsed != null) {
      map['tokens_used'] = Variable<int>(tokensUsed);
    }
    if (!nullToAbsent || estimatedCost != null) {
      map['estimated_cost'] = Variable<double>(estimatedCost);
    }
    if (!nullToAbsent || ipAddress != null) {
      map['ip_address'] = Variable<String>(ipAddress);
    }
    if (!nullToAbsent || deviceInfo != null) {
      map['device_info'] = Variable<String>(deviceInfo);
    }
    return map;
  }

  AiUsageAuditsCompanion toCompanion(bool nullToAbsent) {
    return AiUsageAuditsCompanion(
      id: Value(id),
      auditedAt: Value(auditedAt),
      auditType: Value(auditType),
      entityUuid: entityUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(entityUuid),
      entityType: entityType == null && nullToAbsent
          ? const Value.absent()
          : Value(entityType),
      userIdentifier: userIdentifier == null && nullToAbsent
          ? const Value.absent()
          : Value(userIdentifier),
      action: Value(action),
      detailsJson: detailsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(detailsJson),
      tokensUsed: tokensUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(tokensUsed),
      estimatedCost: estimatedCost == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedCost),
      ipAddress: ipAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(ipAddress),
      deviceInfo: deviceInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceInfo),
    );
  }

  factory AiUsageAudit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiUsageAudit(
      id: serializer.fromJson<int>(json['id']),
      auditedAt: serializer.fromJson<DateTime>(json['auditedAt']),
      auditType: serializer.fromJson<String>(json['auditType']),
      entityUuid: serializer.fromJson<String?>(json['entityUuid']),
      entityType: serializer.fromJson<String?>(json['entityType']),
      userIdentifier: serializer.fromJson<String?>(json['userIdentifier']),
      action: serializer.fromJson<String>(json['action']),
      detailsJson: serializer.fromJson<String?>(json['detailsJson']),
      tokensUsed: serializer.fromJson<int?>(json['tokensUsed']),
      estimatedCost: serializer.fromJson<double?>(json['estimatedCost']),
      ipAddress: serializer.fromJson<String?>(json['ipAddress']),
      deviceInfo: serializer.fromJson<String?>(json['deviceInfo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'auditedAt': serializer.toJson<DateTime>(auditedAt),
      'auditType': serializer.toJson<String>(auditType),
      'entityUuid': serializer.toJson<String?>(entityUuid),
      'entityType': serializer.toJson<String?>(entityType),
      'userIdentifier': serializer.toJson<String?>(userIdentifier),
      'action': serializer.toJson<String>(action),
      'detailsJson': serializer.toJson<String?>(detailsJson),
      'tokensUsed': serializer.toJson<int?>(tokensUsed),
      'estimatedCost': serializer.toJson<double?>(estimatedCost),
      'ipAddress': serializer.toJson<String?>(ipAddress),
      'deviceInfo': serializer.toJson<String?>(deviceInfo),
    };
  }

  AiUsageAudit copyWith({
    int? id,
    DateTime? auditedAt,
    String? auditType,
    Value<String?> entityUuid = const Value.absent(),
    Value<String?> entityType = const Value.absent(),
    Value<String?> userIdentifier = const Value.absent(),
    String? action,
    Value<String?> detailsJson = const Value.absent(),
    Value<int?> tokensUsed = const Value.absent(),
    Value<double?> estimatedCost = const Value.absent(),
    Value<String?> ipAddress = const Value.absent(),
    Value<String?> deviceInfo = const Value.absent(),
  }) => AiUsageAudit(
    id: id ?? this.id,
    auditedAt: auditedAt ?? this.auditedAt,
    auditType: auditType ?? this.auditType,
    entityUuid: entityUuid.present ? entityUuid.value : this.entityUuid,
    entityType: entityType.present ? entityType.value : this.entityType,
    userIdentifier: userIdentifier.present
        ? userIdentifier.value
        : this.userIdentifier,
    action: action ?? this.action,
    detailsJson: detailsJson.present ? detailsJson.value : this.detailsJson,
    tokensUsed: tokensUsed.present ? tokensUsed.value : this.tokensUsed,
    estimatedCost: estimatedCost.present
        ? estimatedCost.value
        : this.estimatedCost,
    ipAddress: ipAddress.present ? ipAddress.value : this.ipAddress,
    deviceInfo: deviceInfo.present ? deviceInfo.value : this.deviceInfo,
  );
  AiUsageAudit copyWithCompanion(AiUsageAuditsCompanion data) {
    return AiUsageAudit(
      id: data.id.present ? data.id.value : this.id,
      auditedAt: data.auditedAt.present ? data.auditedAt.value : this.auditedAt,
      auditType: data.auditType.present ? data.auditType.value : this.auditType,
      entityUuid: data.entityUuid.present
          ? data.entityUuid.value
          : this.entityUuid,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      userIdentifier: data.userIdentifier.present
          ? data.userIdentifier.value
          : this.userIdentifier,
      action: data.action.present ? data.action.value : this.action,
      detailsJson: data.detailsJson.present
          ? data.detailsJson.value
          : this.detailsJson,
      tokensUsed: data.tokensUsed.present
          ? data.tokensUsed.value
          : this.tokensUsed,
      estimatedCost: data.estimatedCost.present
          ? data.estimatedCost.value
          : this.estimatedCost,
      ipAddress: data.ipAddress.present ? data.ipAddress.value : this.ipAddress,
      deviceInfo: data.deviceInfo.present
          ? data.deviceInfo.value
          : this.deviceInfo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiUsageAudit(')
          ..write('id: $id, ')
          ..write('auditedAt: $auditedAt, ')
          ..write('auditType: $auditType, ')
          ..write('entityUuid: $entityUuid, ')
          ..write('entityType: $entityType, ')
          ..write('userIdentifier: $userIdentifier, ')
          ..write('action: $action, ')
          ..write('detailsJson: $detailsJson, ')
          ..write('tokensUsed: $tokensUsed, ')
          ..write('estimatedCost: $estimatedCost, ')
          ..write('ipAddress: $ipAddress, ')
          ..write('deviceInfo: $deviceInfo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    auditedAt,
    auditType,
    entityUuid,
    entityType,
    userIdentifier,
    action,
    detailsJson,
    tokensUsed,
    estimatedCost,
    ipAddress,
    deviceInfo,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiUsageAudit &&
          other.id == this.id &&
          other.auditedAt == this.auditedAt &&
          other.auditType == this.auditType &&
          other.entityUuid == this.entityUuid &&
          other.entityType == this.entityType &&
          other.userIdentifier == this.userIdentifier &&
          other.action == this.action &&
          other.detailsJson == this.detailsJson &&
          other.tokensUsed == this.tokensUsed &&
          other.estimatedCost == this.estimatedCost &&
          other.ipAddress == this.ipAddress &&
          other.deviceInfo == this.deviceInfo);
}

class AiUsageAuditsCompanion extends UpdateCompanion<AiUsageAudit> {
  final Value<int> id;
  final Value<DateTime> auditedAt;
  final Value<String> auditType;
  final Value<String?> entityUuid;
  final Value<String?> entityType;
  final Value<String?> userIdentifier;
  final Value<String> action;
  final Value<String?> detailsJson;
  final Value<int?> tokensUsed;
  final Value<double?> estimatedCost;
  final Value<String?> ipAddress;
  final Value<String?> deviceInfo;
  const AiUsageAuditsCompanion({
    this.id = const Value.absent(),
    this.auditedAt = const Value.absent(),
    this.auditType = const Value.absent(),
    this.entityUuid = const Value.absent(),
    this.entityType = const Value.absent(),
    this.userIdentifier = const Value.absent(),
    this.action = const Value.absent(),
    this.detailsJson = const Value.absent(),
    this.tokensUsed = const Value.absent(),
    this.estimatedCost = const Value.absent(),
    this.ipAddress = const Value.absent(),
    this.deviceInfo = const Value.absent(),
  });
  AiUsageAuditsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime auditedAt,
    required String auditType,
    this.entityUuid = const Value.absent(),
    this.entityType = const Value.absent(),
    this.userIdentifier = const Value.absent(),
    required String action,
    this.detailsJson = const Value.absent(),
    this.tokensUsed = const Value.absent(),
    this.estimatedCost = const Value.absent(),
    this.ipAddress = const Value.absent(),
    this.deviceInfo = const Value.absent(),
  }) : auditedAt = Value(auditedAt),
       auditType = Value(auditType),
       action = Value(action);
  static Insertable<AiUsageAudit> custom({
    Expression<int>? id,
    Expression<DateTime>? auditedAt,
    Expression<String>? auditType,
    Expression<String>? entityUuid,
    Expression<String>? entityType,
    Expression<String>? userIdentifier,
    Expression<String>? action,
    Expression<String>? detailsJson,
    Expression<int>? tokensUsed,
    Expression<double>? estimatedCost,
    Expression<String>? ipAddress,
    Expression<String>? deviceInfo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (auditedAt != null) 'audited_at': auditedAt,
      if (auditType != null) 'audit_type': auditType,
      if (entityUuid != null) 'entity_uuid': entityUuid,
      if (entityType != null) 'entity_type': entityType,
      if (userIdentifier != null) 'user_identifier': userIdentifier,
      if (action != null) 'action': action,
      if (detailsJson != null) 'details_json': detailsJson,
      if (tokensUsed != null) 'tokens_used': tokensUsed,
      if (estimatedCost != null) 'estimated_cost': estimatedCost,
      if (ipAddress != null) 'ip_address': ipAddress,
      if (deviceInfo != null) 'device_info': deviceInfo,
    });
  }

  AiUsageAuditsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? auditedAt,
    Value<String>? auditType,
    Value<String?>? entityUuid,
    Value<String?>? entityType,
    Value<String?>? userIdentifier,
    Value<String>? action,
    Value<String?>? detailsJson,
    Value<int?>? tokensUsed,
    Value<double?>? estimatedCost,
    Value<String?>? ipAddress,
    Value<String?>? deviceInfo,
  }) {
    return AiUsageAuditsCompanion(
      id: id ?? this.id,
      auditedAt: auditedAt ?? this.auditedAt,
      auditType: auditType ?? this.auditType,
      entityUuid: entityUuid ?? this.entityUuid,
      entityType: entityType ?? this.entityType,
      userIdentifier: userIdentifier ?? this.userIdentifier,
      action: action ?? this.action,
      detailsJson: detailsJson ?? this.detailsJson,
      tokensUsed: tokensUsed ?? this.tokensUsed,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      ipAddress: ipAddress ?? this.ipAddress,
      deviceInfo: deviceInfo ?? this.deviceInfo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (auditedAt.present) {
      map['audited_at'] = Variable<DateTime>(auditedAt.value);
    }
    if (auditType.present) {
      map['audit_type'] = Variable<String>(auditType.value);
    }
    if (entityUuid.present) {
      map['entity_uuid'] = Variable<String>(entityUuid.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (userIdentifier.present) {
      map['user_identifier'] = Variable<String>(userIdentifier.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (detailsJson.present) {
      map['details_json'] = Variable<String>(detailsJson.value);
    }
    if (tokensUsed.present) {
      map['tokens_used'] = Variable<int>(tokensUsed.value);
    }
    if (estimatedCost.present) {
      map['estimated_cost'] = Variable<double>(estimatedCost.value);
    }
    if (ipAddress.present) {
      map['ip_address'] = Variable<String>(ipAddress.value);
    }
    if (deviceInfo.present) {
      map['device_info'] = Variable<String>(deviceInfo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiUsageAuditsCompanion(')
          ..write('id: $id, ')
          ..write('auditedAt: $auditedAt, ')
          ..write('auditType: $auditType, ')
          ..write('entityUuid: $entityUuid, ')
          ..write('entityType: $entityType, ')
          ..write('userIdentifier: $userIdentifier, ')
          ..write('action: $action, ')
          ..write('detailsJson: $detailsJson, ')
          ..write('tokensUsed: $tokensUsed, ')
          ..write('estimatedCost: $estimatedCost, ')
          ..write('ipAddress: $ipAddress, ')
          ..write('deviceInfo: $deviceInfo')
          ..write(')'))
        .toString();
  }
}

class $AiToolsTable extends AiTools with TableInfo<$AiToolsTable, AiTool> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiToolsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdatedAtMeta = const VerificationMeta(
    'lastUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedAt =
      GeneratedColumn<DateTime>(
        'last_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toolTypeMeta = const VerificationMeta(
    'toolType',
  );
  @override
  late final GeneratedColumn<String> toolType = GeneratedColumn<String>(
    'tool_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skillIdMeta = const VerificationMeta(
    'skillId',
  );
  @override
  late final GeneratedColumn<int> skillId = GeneratedColumn<int>(
    'skill_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parametersSchemaJsonMeta =
      const VerificationMeta('parametersSchemaJson');
  @override
  late final GeneratedColumn<String> parametersSchemaJson =
      GeneratedColumn<String>(
        'parameters_schema_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _returnSchemaJsonMeta = const VerificationMeta(
    'returnSchemaJson',
  );
  @override
  late final GeneratedColumn<String> returnSchemaJson = GeneratedColumn<String>(
    'return_schema_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _requiresConfirmationMeta =
      const VerificationMeta('requiresConfirmation');
  @override
  late final GeneratedColumn<bool> requiresConfirmation = GeneratedColumn<bool>(
    'requires_confirmation',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("requires_confirmation" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _executorTypeMeta = const VerificationMeta(
    'executorType',
  );
  @override
  late final GeneratedColumn<String> executorType = GeneratedColumn<String>(
    'executor_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('native'),
  );
  static const VerificationMeta _executorConfigJsonMeta =
      const VerificationMeta('executorConfigJson');
  @override
  late final GeneratedColumn<String> executorConfigJson =
      GeneratedColumn<String>(
        'executor_config_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    uuid,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    name,
    description,
    toolType,
    skillId,
    parametersSchemaJson,
    returnSchemaJson,
    requiresConfirmation,
    isEnabled,
    executorType,
    executorConfigJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_ai_tools';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiTool> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
        _lastUpdatedAtMeta,
        lastUpdatedAt.isAcceptableOrUnknown(
          data['last_updated_at']!,
          _lastUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('tool_type')) {
      context.handle(
        _toolTypeMeta,
        toolType.isAcceptableOrUnknown(data['tool_type']!, _toolTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_toolTypeMeta);
    }
    if (data.containsKey('skill_id')) {
      context.handle(
        _skillIdMeta,
        skillId.isAcceptableOrUnknown(data['skill_id']!, _skillIdMeta),
      );
    }
    if (data.containsKey('parameters_schema_json')) {
      context.handle(
        _parametersSchemaJsonMeta,
        parametersSchemaJson.isAcceptableOrUnknown(
          data['parameters_schema_json']!,
          _parametersSchemaJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_parametersSchemaJsonMeta);
    }
    if (data.containsKey('return_schema_json')) {
      context.handle(
        _returnSchemaJsonMeta,
        returnSchemaJson.isAcceptableOrUnknown(
          data['return_schema_json']!,
          _returnSchemaJsonMeta,
        ),
      );
    }
    if (data.containsKey('requires_confirmation')) {
      context.handle(
        _requiresConfirmationMeta,
        requiresConfirmation.isAcceptableOrUnknown(
          data['requires_confirmation']!,
          _requiresConfirmationMeta,
        ),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('executor_type')) {
      context.handle(
        _executorTypeMeta,
        executorType.isAcceptableOrUnknown(
          data['executor_type']!,
          _executorTypeMeta,
        ),
      );
    }
    if (data.containsKey('executor_config_json')) {
      context.handle(
        _executorConfigJsonMeta,
        executorConfigJson.isAcceptableOrUnknown(
          data['executor_config_json']!,
          _executorConfigJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  AiTool map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiTool(
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      toolType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tool_type'],
      )!,
      skillId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skill_id'],
      ),
      parametersSchemaJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parameters_schema_json'],
      )!,
      returnSchemaJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_schema_json'],
      ),
      requiresConfirmation: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_confirmation'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      executorType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}executor_type'],
      )!,
      executorConfigJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}executor_config_json'],
      ),
    );
  }

  @override
  $AiToolsTable createAlias(String alias) {
    return $AiToolsTable(attachedDatabase, alias);
  }
}

class AiTool extends DataClass implements Insertable<AiTool> {
  final String uuid;
  final DateTime createdAt;
  final DateTime? lastUpdatedAt;
  final DateTime? deletedAt;

  /// 工具名称
  final String name;

  /// 工具描述
  final String description;

  /// 工具类型 (divination, analysis, calculation, query)
  final String toolType;

  /// 关联的技法 ID (如果是占测工具)
  final int? skillId;

  /// 工具参数 Schema (JSON Schema 格式)
  final String parametersSchemaJson;

  /// 工具返回值 Schema (JSON Schema 格式)
  final String? returnSchemaJson;

  /// 是否需要确认才能执行
  final bool requiresConfirmation;

  /// 是否启用
  final bool isEnabled;

  /// 执行器类型 (native, external, agent)
  final String executorType;

  /// 执行器配置 (JSON)
  final String? executorConfigJson;
  const AiTool({
    required this.uuid,
    required this.createdAt,
    this.lastUpdatedAt,
    this.deletedAt,
    required this.name,
    required this.description,
    required this.toolType,
    this.skillId,
    required this.parametersSchemaJson,
    this.returnSchemaJson,
    required this.requiresConfirmation,
    required this.isEnabled,
    required this.executorType,
    this.executorConfigJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastUpdatedAt != null) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['tool_type'] = Variable<String>(toolType);
    if (!nullToAbsent || skillId != null) {
      map['skill_id'] = Variable<int>(skillId);
    }
    map['parameters_schema_json'] = Variable<String>(parametersSchemaJson);
    if (!nullToAbsent || returnSchemaJson != null) {
      map['return_schema_json'] = Variable<String>(returnSchemaJson);
    }
    map['requires_confirmation'] = Variable<bool>(requiresConfirmation);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['executor_type'] = Variable<String>(executorType);
    if (!nullToAbsent || executorConfigJson != null) {
      map['executor_config_json'] = Variable<String>(executorConfigJson);
    }
    return map;
  }

  AiToolsCompanion toCompanion(bool nullToAbsent) {
    return AiToolsCompanion(
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      lastUpdatedAt: lastUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      name: Value(name),
      description: Value(description),
      toolType: Value(toolType),
      skillId: skillId == null && nullToAbsent
          ? const Value.absent()
          : Value(skillId),
      parametersSchemaJson: Value(parametersSchemaJson),
      returnSchemaJson: returnSchemaJson == null && nullToAbsent
          ? const Value.absent()
          : Value(returnSchemaJson),
      requiresConfirmation: Value(requiresConfirmation),
      isEnabled: Value(isEnabled),
      executorType: Value(executorType),
      executorConfigJson: executorConfigJson == null && nullToAbsent
          ? const Value.absent()
          : Value(executorConfigJson),
    );
  }

  factory AiTool.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiTool(
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdatedAt: serializer.fromJson<DateTime?>(json['lastUpdatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      toolType: serializer.fromJson<String>(json['toolType']),
      skillId: serializer.fromJson<int?>(json['skillId']),
      parametersSchemaJson: serializer.fromJson<String>(
        json['parametersSchemaJson'],
      ),
      returnSchemaJson: serializer.fromJson<String?>(json['returnSchemaJson']),
      requiresConfirmation: serializer.fromJson<bool>(
        json['requiresConfirmation'],
      ),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      executorType: serializer.fromJson<String>(json['executorType']),
      executorConfigJson: serializer.fromJson<String?>(
        json['executorConfigJson'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdatedAt': serializer.toJson<DateTime?>(lastUpdatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'toolType': serializer.toJson<String>(toolType),
      'skillId': serializer.toJson<int?>(skillId),
      'parametersSchemaJson': serializer.toJson<String>(parametersSchemaJson),
      'returnSchemaJson': serializer.toJson<String?>(returnSchemaJson),
      'requiresConfirmation': serializer.toJson<bool>(requiresConfirmation),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'executorType': serializer.toJson<String>(executorType),
      'executorConfigJson': serializer.toJson<String?>(executorConfigJson),
    };
  }

  AiTool copyWith({
    String? uuid,
    DateTime? createdAt,
    Value<DateTime?> lastUpdatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? name,
    String? description,
    String? toolType,
    Value<int?> skillId = const Value.absent(),
    String? parametersSchemaJson,
    Value<String?> returnSchemaJson = const Value.absent(),
    bool? requiresConfirmation,
    bool? isEnabled,
    String? executorType,
    Value<String?> executorConfigJson = const Value.absent(),
  }) => AiTool(
    uuid: uuid ?? this.uuid,
    createdAt: createdAt ?? this.createdAt,
    lastUpdatedAt: lastUpdatedAt.present
        ? lastUpdatedAt.value
        : this.lastUpdatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    name: name ?? this.name,
    description: description ?? this.description,
    toolType: toolType ?? this.toolType,
    skillId: skillId.present ? skillId.value : this.skillId,
    parametersSchemaJson: parametersSchemaJson ?? this.parametersSchemaJson,
    returnSchemaJson: returnSchemaJson.present
        ? returnSchemaJson.value
        : this.returnSchemaJson,
    requiresConfirmation: requiresConfirmation ?? this.requiresConfirmation,
    isEnabled: isEnabled ?? this.isEnabled,
    executorType: executorType ?? this.executorType,
    executorConfigJson: executorConfigJson.present
        ? executorConfigJson.value
        : this.executorConfigJson,
  );
  AiTool copyWithCompanion(AiToolsCompanion data) {
    return AiTool(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      toolType: data.toolType.present ? data.toolType.value : this.toolType,
      skillId: data.skillId.present ? data.skillId.value : this.skillId,
      parametersSchemaJson: data.parametersSchemaJson.present
          ? data.parametersSchemaJson.value
          : this.parametersSchemaJson,
      returnSchemaJson: data.returnSchemaJson.present
          ? data.returnSchemaJson.value
          : this.returnSchemaJson,
      requiresConfirmation: data.requiresConfirmation.present
          ? data.requiresConfirmation.value
          : this.requiresConfirmation,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      executorType: data.executorType.present
          ? data.executorType.value
          : this.executorType,
      executorConfigJson: data.executorConfigJson.present
          ? data.executorConfigJson.value
          : this.executorConfigJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiTool(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('toolType: $toolType, ')
          ..write('skillId: $skillId, ')
          ..write('parametersSchemaJson: $parametersSchemaJson, ')
          ..write('returnSchemaJson: $returnSchemaJson, ')
          ..write('requiresConfirmation: $requiresConfirmation, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('executorType: $executorType, ')
          ..write('executorConfigJson: $executorConfigJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uuid,
    createdAt,
    lastUpdatedAt,
    deletedAt,
    name,
    description,
    toolType,
    skillId,
    parametersSchemaJson,
    returnSchemaJson,
    requiresConfirmation,
    isEnabled,
    executorType,
    executorConfigJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiTool &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.deletedAt == this.deletedAt &&
          other.name == this.name &&
          other.description == this.description &&
          other.toolType == this.toolType &&
          other.skillId == this.skillId &&
          other.parametersSchemaJson == this.parametersSchemaJson &&
          other.returnSchemaJson == this.returnSchemaJson &&
          other.requiresConfirmation == this.requiresConfirmation &&
          other.isEnabled == this.isEnabled &&
          other.executorType == this.executorType &&
          other.executorConfigJson == this.executorConfigJson);
}

class AiToolsCompanion extends UpdateCompanion<AiTool> {
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastUpdatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> name;
  final Value<String> description;
  final Value<String> toolType;
  final Value<int?> skillId;
  final Value<String> parametersSchemaJson;
  final Value<String?> returnSchemaJson;
  final Value<bool> requiresConfirmation;
  final Value<bool> isEnabled;
  final Value<String> executorType;
  final Value<String?> executorConfigJson;
  final Value<int> rowid;
  const AiToolsCompanion({
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.toolType = const Value.absent(),
    this.skillId = const Value.absent(),
    this.parametersSchemaJson = const Value.absent(),
    this.returnSchemaJson = const Value.absent(),
    this.requiresConfirmation = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.executorType = const Value.absent(),
    this.executorConfigJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiToolsCompanion.insert({
    required String uuid,
    required DateTime createdAt,
    this.lastUpdatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String name,
    required String description,
    required String toolType,
    this.skillId = const Value.absent(),
    required String parametersSchemaJson,
    this.returnSchemaJson = const Value.absent(),
    this.requiresConfirmation = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.executorType = const Value.absent(),
    this.executorConfigJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid),
       createdAt = Value(createdAt),
       name = Value(name),
       description = Value(description),
       toolType = Value(toolType),
       parametersSchemaJson = Value(parametersSchemaJson);
  static Insertable<AiTool> custom({
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? toolType,
    Expression<int>? skillId,
    Expression<String>? parametersSchemaJson,
    Expression<String>? returnSchemaJson,
    Expression<bool>? requiresConfirmation,
    Expression<bool>? isEnabled,
    Expression<String>? executorType,
    Expression<String>? executorConfigJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (toolType != null) 'tool_type': toolType,
      if (skillId != null) 'skill_id': skillId,
      if (parametersSchemaJson != null)
        'parameters_schema_json': parametersSchemaJson,
      if (returnSchemaJson != null) 'return_schema_json': returnSchemaJson,
      if (requiresConfirmation != null)
        'requires_confirmation': requiresConfirmation,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (executorType != null) 'executor_type': executorType,
      if (executorConfigJson != null)
        'executor_config_json': executorConfigJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiToolsCompanion copyWith({
    Value<String>? uuid,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastUpdatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? name,
    Value<String>? description,
    Value<String>? toolType,
    Value<int?>? skillId,
    Value<String>? parametersSchemaJson,
    Value<String?>? returnSchemaJson,
    Value<bool>? requiresConfirmation,
    Value<bool>? isEnabled,
    Value<String>? executorType,
    Value<String?>? executorConfigJson,
    Value<int>? rowid,
  }) {
    return AiToolsCompanion(
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      name: name ?? this.name,
      description: description ?? this.description,
      toolType: toolType ?? this.toolType,
      skillId: skillId ?? this.skillId,
      parametersSchemaJson: parametersSchemaJson ?? this.parametersSchemaJson,
      returnSchemaJson: returnSchemaJson ?? this.returnSchemaJson,
      requiresConfirmation: requiresConfirmation ?? this.requiresConfirmation,
      isEnabled: isEnabled ?? this.isEnabled,
      executorType: executorType ?? this.executorType,
      executorConfigJson: executorConfigJson ?? this.executorConfigJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (toolType.present) {
      map['tool_type'] = Variable<String>(toolType.value);
    }
    if (skillId.present) {
      map['skill_id'] = Variable<int>(skillId.value);
    }
    if (parametersSchemaJson.present) {
      map['parameters_schema_json'] = Variable<String>(
        parametersSchemaJson.value,
      );
    }
    if (returnSchemaJson.present) {
      map['return_schema_json'] = Variable<String>(returnSchemaJson.value);
    }
    if (requiresConfirmation.present) {
      map['requires_confirmation'] = Variable<bool>(requiresConfirmation.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (executorType.present) {
      map['executor_type'] = Variable<String>(executorType.value);
    }
    if (executorConfigJson.present) {
      map['executor_config_json'] = Variable<String>(executorConfigJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiToolsCompanion(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('toolType: $toolType, ')
          ..write('skillId: $skillId, ')
          ..write('parametersSchemaJson: $parametersSchemaJson, ')
          ..write('returnSchemaJson: $returnSchemaJson, ')
          ..write('requiresConfirmation: $requiresConfirmation, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('executorType: $executorType, ')
          ..write('executorConfigJson: $executorConfigJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AiDatabase extends GeneratedDatabase {
  _$AiDatabase(QueryExecutor e) : super(e);
  $AiDatabaseManager get managers => $AiDatabaseManager(this);
  late final $LlmProvidersTable llmProviders = $LlmProvidersTable(this);
  late final $LlmModelsTable llmModels = $LlmModelsTable(this);
  late final $PromptTemplatesTable promptTemplates = $PromptTemplatesTable(
    this,
  );
  late final $PromptVersionsTable promptVersions = $PromptVersionsTable(this);
  late final $PromptSkillBindingsTable promptSkillBindings =
      $PromptSkillBindingsTable(this);
  late final $AiPersonasTable aiPersonas = $AiPersonasTable(this);
  late final $AiChatSessionsTable aiChatSessions = $AiChatSessionsTable(this);
  late final $AiApiCallsTable aiApiCalls = $AiApiCallsTable(this);
  late final $AiChatMessagesTable aiChatMessages = $AiChatMessagesTable(this);
  late final $AiProvenancesTable aiProvenances = $AiProvenancesTable(this);
  late final $AiDivinationsTable aiDivinations = $AiDivinationsTable(this);
  late final $AgentInvocationsTable agentInvocations = $AgentInvocationsTable(
    this,
  );
  late final $AiUsageAuditsTable aiUsageAudits = $AiUsageAuditsTable(this);
  late final $AiToolsTable aiTools = $AiToolsTable(this);
  late final LlmProvidersDao llmProvidersDao = LlmProvidersDao(
    this as AiDatabase,
  );
  late final LlmModelsDao llmModelsDao = LlmModelsDao(this as AiDatabase);
  late final PromptTemplatesDao promptTemplatesDao = PromptTemplatesDao(
    this as AiDatabase,
  );
  late final PromptVersionsDao promptVersionsDao = PromptVersionsDao(
    this as AiDatabase,
  );
  late final PromptSkillBindingsDao promptSkillBindingsDao =
      PromptSkillBindingsDao(this as AiDatabase);
  late final AiPersonasDao aiPersonasDao = AiPersonasDao(this as AiDatabase);
  late final AiChatSessionsDao aiChatSessionsDao = AiChatSessionsDao(
    this as AiDatabase,
  );
  late final AiChatMessagesDao aiChatMessagesDao = AiChatMessagesDao(
    this as AiDatabase,
  );
  late final AiApiCallsDao aiApiCallsDao = AiApiCallsDao(this as AiDatabase);
  late final AiProvenancesDao aiProvenancesDao = AiProvenancesDao(
    this as AiDatabase,
  );
  late final AiDivinationsDao aiDivinationsDao = AiDivinationsDao(
    this as AiDatabase,
  );
  late final AgentInvocationsDao agentInvocationsDao = AgentInvocationsDao(
    this as AiDatabase,
  );
  late final AiUsageAuditsDao aiUsageAuditsDao = AiUsageAuditsDao(
    this as AiDatabase,
  );
  late final AiToolsDao aiToolsDao = AiToolsDao(this as AiDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    llmProviders,
    llmModels,
    promptTemplates,
    promptVersions,
    promptSkillBindings,
    aiPersonas,
    aiChatSessions,
    aiApiCalls,
    aiChatMessages,
    aiProvenances,
    aiDivinations,
    agentInvocations,
    aiUsageAudits,
    aiTools,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$LlmProvidersTableCreateCompanionBuilder =
    LlmProvidersCompanion Function({
      required String uuid,
      required DateTime createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      required String name,
      required String baseUrl,
      Value<String?> encryptedApiKey,
      Value<bool> isDefault,
      Value<bool> isEnabled,
      Value<String?> configJson,
      Value<int> rowid,
    });
typedef $$LlmProvidersTableUpdateCompanionBuilder =
    LlmProvidersCompanion Function({
      Value<String> uuid,
      Value<DateTime> createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      Value<String> name,
      Value<String> baseUrl,
      Value<String?> encryptedApiKey,
      Value<bool> isDefault,
      Value<bool> isEnabled,
      Value<String?> configJson,
      Value<int> rowid,
    });

final class $$LlmProvidersTableReferences
    extends BaseReferences<_$AiDatabase, $LlmProvidersTable, LlmProvider> {
  $$LlmProvidersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LlmModelsTable, List<LlmModel>>
  _llmModelsRefsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.llmModels,
    aliasName: $_aliasNameGenerator(
      db.llmProviders.uuid,
      db.llmModels.providerUuid,
    ),
  );

  $$LlmModelsTableProcessedTableManager get llmModelsRefs {
    final manager = $$LlmModelsTableTableManager($_db, $_db.llmModels).filter(
      (f) => f.providerUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!),
    );

    final cache = $_typedResult.readTableOrNull(_llmModelsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LlmProvidersTableFilterComposer
    extends Composer<_$AiDatabase, $LlmProvidersTable> {
  $$LlmProvidersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get encryptedApiKey => $composableBuilder(
    column: $table.encryptedApiKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get configJson => $composableBuilder(
    column: $table.configJson,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> llmModelsRefs(
    Expression<bool> Function($$LlmModelsTableFilterComposer f) f,
  ) {
    final $$LlmModelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.llmModels,
      getReferencedColumn: (t) => t.providerUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LlmModelsTableFilterComposer(
            $db: $db,
            $table: $db.llmModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LlmProvidersTableOrderingComposer
    extends Composer<_$AiDatabase, $LlmProvidersTable> {
  $$LlmProvidersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get encryptedApiKey => $composableBuilder(
    column: $table.encryptedApiKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get configJson => $composableBuilder(
    column: $table.configJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LlmProvidersTableAnnotationComposer
    extends Composer<_$AiDatabase, $LlmProvidersTable> {
  $$LlmProvidersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get baseUrl =>
      $composableBuilder(column: $table.baseUrl, builder: (column) => column);

  GeneratedColumn<String> get encryptedApiKey => $composableBuilder(
    column: $table.encryptedApiKey,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get configJson => $composableBuilder(
    column: $table.configJson,
    builder: (column) => column,
  );

  Expression<T> llmModelsRefs<T extends Object>(
    Expression<T> Function($$LlmModelsTableAnnotationComposer a) f,
  ) {
    final $$LlmModelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.llmModels,
      getReferencedColumn: (t) => t.providerUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LlmModelsTableAnnotationComposer(
            $db: $db,
            $table: $db.llmModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LlmProvidersTableTableManager
    extends
        RootTableManager<
          _$AiDatabase,
          $LlmProvidersTable,
          LlmProvider,
          $$LlmProvidersTableFilterComposer,
          $$LlmProvidersTableOrderingComposer,
          $$LlmProvidersTableAnnotationComposer,
          $$LlmProvidersTableCreateCompanionBuilder,
          $$LlmProvidersTableUpdateCompanionBuilder,
          (LlmProvider, $$LlmProvidersTableReferences),
          LlmProvider,
          PrefetchHooks Function({bool llmModelsRefs})
        > {
  $$LlmProvidersTableTableManager(_$AiDatabase db, $LlmProvidersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LlmProvidersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LlmProvidersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LlmProvidersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uuid = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> baseUrl = const Value.absent(),
                Value<String?> encryptedApiKey = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String?> configJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LlmProvidersCompanion(
                uuid: uuid,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                name: name,
                baseUrl: baseUrl,
                encryptedApiKey: encryptedApiKey,
                isDefault: isDefault,
                isEnabled: isEnabled,
                configJson: configJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uuid,
                required DateTime createdAt,
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String name,
                required String baseUrl,
                Value<String?> encryptedApiKey = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String?> configJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LlmProvidersCompanion.insert(
                uuid: uuid,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                name: name,
                baseUrl: baseUrl,
                encryptedApiKey: encryptedApiKey,
                isDefault: isDefault,
                isEnabled: isEnabled,
                configJson: configJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LlmProvidersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({llmModelsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (llmModelsRefs) db.llmModels],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (llmModelsRefs)
                    await $_getPrefetchedData<
                      LlmProvider,
                      $LlmProvidersTable,
                      LlmModel
                    >(
                      currentTable: table,
                      referencedTable: $$LlmProvidersTableReferences
                          ._llmModelsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$LlmProvidersTableReferences(
                            db,
                            table,
                            p0,
                          ).llmModelsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.providerUuid == item.uuid,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$LlmProvidersTableProcessedTableManager =
    ProcessedTableManager<
      _$AiDatabase,
      $LlmProvidersTable,
      LlmProvider,
      $$LlmProvidersTableFilterComposer,
      $$LlmProvidersTableOrderingComposer,
      $$LlmProvidersTableAnnotationComposer,
      $$LlmProvidersTableCreateCompanionBuilder,
      $$LlmProvidersTableUpdateCompanionBuilder,
      (LlmProvider, $$LlmProvidersTableReferences),
      LlmProvider,
      PrefetchHooks Function({bool llmModelsRefs})
    >;
typedef $$LlmModelsTableCreateCompanionBuilder =
    LlmModelsCompanion Function({
      required String uuid,
      required DateTime createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      required String providerUuid,
      required String modelId,
      required String displayName,
      required String modelType,
      Value<int> maxContextLength,
      Value<int> maxOutputTokens,
      Value<bool> supportsStreaming,
      Value<bool> supportsFunctionCalling,
      Value<bool> isDefault,
      Value<bool> isEnabled,
      Value<String?> configJson,
      Value<int> rowid,
    });
typedef $$LlmModelsTableUpdateCompanionBuilder =
    LlmModelsCompanion Function({
      Value<String> uuid,
      Value<DateTime> createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      Value<String> providerUuid,
      Value<String> modelId,
      Value<String> displayName,
      Value<String> modelType,
      Value<int> maxContextLength,
      Value<int> maxOutputTokens,
      Value<bool> supportsStreaming,
      Value<bool> supportsFunctionCalling,
      Value<bool> isDefault,
      Value<bool> isEnabled,
      Value<String?> configJson,
      Value<int> rowid,
    });

final class $$LlmModelsTableReferences
    extends BaseReferences<_$AiDatabase, $LlmModelsTable, LlmModel> {
  $$LlmModelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LlmProvidersTable _providerUuidTable(_$AiDatabase db) =>
      db.llmProviders.createAlias(
        $_aliasNameGenerator(db.llmModels.providerUuid, db.llmProviders.uuid),
      );

  $$LlmProvidersTableProcessedTableManager get providerUuid {
    final $_column = $_itemColumn<String>('provider_uuid')!;

    final manager = $$LlmProvidersTableTableManager(
      $_db,
      $_db.llmProviders,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AiPersonasTable, List<AiPersona>>
  _aiPersonasRefsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.aiPersonas,
    aliasName: $_aliasNameGenerator(db.llmModels.uuid, db.aiPersonas.modelUuid),
  );

  $$AiPersonasTableProcessedTableManager get aiPersonasRefs {
    final manager = $$AiPersonasTableTableManager(
      $_db,
      $_db.aiPersonas,
    ).filter((f) => f.modelUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!));

    final cache = $_typedResult.readTableOrNull(_aiPersonasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AiApiCallsTable, List<AiApiCall>>
  _aiApiCallsRefsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.aiApiCalls,
    aliasName: $_aliasNameGenerator(db.llmModels.uuid, db.aiApiCalls.modelUuid),
  );

  $$AiApiCallsTableProcessedTableManager get aiApiCallsRefs {
    final manager = $$AiApiCallsTableTableManager(
      $_db,
      $_db.aiApiCalls,
    ).filter((f) => f.modelUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!));

    final cache = $_typedResult.readTableOrNull(_aiApiCallsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LlmModelsTableFilterComposer
    extends Composer<_$AiDatabase, $LlmModelsTable> {
  $$LlmModelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelId => $composableBuilder(
    column: $table.modelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelType => $composableBuilder(
    column: $table.modelType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxContextLength => $composableBuilder(
    column: $table.maxContextLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxOutputTokens => $composableBuilder(
    column: $table.maxOutputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get supportsStreaming => $composableBuilder(
    column: $table.supportsStreaming,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get supportsFunctionCalling => $composableBuilder(
    column: $table.supportsFunctionCalling,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get configJson => $composableBuilder(
    column: $table.configJson,
    builder: (column) => ColumnFilters(column),
  );

  $$LlmProvidersTableFilterComposer get providerUuid {
    final $$LlmProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerUuid,
      referencedTable: $db.llmProviders,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LlmProvidersTableFilterComposer(
            $db: $db,
            $table: $db.llmProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> aiPersonasRefs(
    Expression<bool> Function($$AiPersonasTableFilterComposer f) f,
  ) {
    final $$AiPersonasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.modelUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableFilterComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> aiApiCallsRefs(
    Expression<bool> Function($$AiApiCallsTableFilterComposer f) f,
  ) {
    final $$AiApiCallsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiApiCalls,
      getReferencedColumn: (t) => t.modelUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiApiCallsTableFilterComposer(
            $db: $db,
            $table: $db.aiApiCalls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LlmModelsTableOrderingComposer
    extends Composer<_$AiDatabase, $LlmModelsTable> {
  $$LlmModelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelId => $composableBuilder(
    column: $table.modelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelType => $composableBuilder(
    column: $table.modelType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxContextLength => $composableBuilder(
    column: $table.maxContextLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxOutputTokens => $composableBuilder(
    column: $table.maxOutputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get supportsStreaming => $composableBuilder(
    column: $table.supportsStreaming,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get supportsFunctionCalling => $composableBuilder(
    column: $table.supportsFunctionCalling,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get configJson => $composableBuilder(
    column: $table.configJson,
    builder: (column) => ColumnOrderings(column),
  );

  $$LlmProvidersTableOrderingComposer get providerUuid {
    final $$LlmProvidersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerUuid,
      referencedTable: $db.llmProviders,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LlmProvidersTableOrderingComposer(
            $db: $db,
            $table: $db.llmProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LlmModelsTableAnnotationComposer
    extends Composer<_$AiDatabase, $LlmModelsTable> {
  $$LlmModelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get modelId =>
      $composableBuilder(column: $table.modelId, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelType =>
      $composableBuilder(column: $table.modelType, builder: (column) => column);

  GeneratedColumn<int> get maxContextLength => $composableBuilder(
    column: $table.maxContextLength,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxOutputTokens => $composableBuilder(
    column: $table.maxOutputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get supportsStreaming => $composableBuilder(
    column: $table.supportsStreaming,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get supportsFunctionCalling => $composableBuilder(
    column: $table.supportsFunctionCalling,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get configJson => $composableBuilder(
    column: $table.configJson,
    builder: (column) => column,
  );

  $$LlmProvidersTableAnnotationComposer get providerUuid {
    final $$LlmProvidersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerUuid,
      referencedTable: $db.llmProviders,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LlmProvidersTableAnnotationComposer(
            $db: $db,
            $table: $db.llmProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> aiPersonasRefs<T extends Object>(
    Expression<T> Function($$AiPersonasTableAnnotationComposer a) f,
  ) {
    final $$AiPersonasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.modelUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableAnnotationComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> aiApiCallsRefs<T extends Object>(
    Expression<T> Function($$AiApiCallsTableAnnotationComposer a) f,
  ) {
    final $$AiApiCallsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiApiCalls,
      getReferencedColumn: (t) => t.modelUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiApiCallsTableAnnotationComposer(
            $db: $db,
            $table: $db.aiApiCalls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LlmModelsTableTableManager
    extends
        RootTableManager<
          _$AiDatabase,
          $LlmModelsTable,
          LlmModel,
          $$LlmModelsTableFilterComposer,
          $$LlmModelsTableOrderingComposer,
          $$LlmModelsTableAnnotationComposer,
          $$LlmModelsTableCreateCompanionBuilder,
          $$LlmModelsTableUpdateCompanionBuilder,
          (LlmModel, $$LlmModelsTableReferences),
          LlmModel,
          PrefetchHooks Function({
            bool providerUuid,
            bool aiPersonasRefs,
            bool aiApiCallsRefs,
          })
        > {
  $$LlmModelsTableTableManager(_$AiDatabase db, $LlmModelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LlmModelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LlmModelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LlmModelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uuid = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> providerUuid = const Value.absent(),
                Value<String> modelId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> modelType = const Value.absent(),
                Value<int> maxContextLength = const Value.absent(),
                Value<int> maxOutputTokens = const Value.absent(),
                Value<bool> supportsStreaming = const Value.absent(),
                Value<bool> supportsFunctionCalling = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String?> configJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LlmModelsCompanion(
                uuid: uuid,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                providerUuid: providerUuid,
                modelId: modelId,
                displayName: displayName,
                modelType: modelType,
                maxContextLength: maxContextLength,
                maxOutputTokens: maxOutputTokens,
                supportsStreaming: supportsStreaming,
                supportsFunctionCalling: supportsFunctionCalling,
                isDefault: isDefault,
                isEnabled: isEnabled,
                configJson: configJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uuid,
                required DateTime createdAt,
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String providerUuid,
                required String modelId,
                required String displayName,
                required String modelType,
                Value<int> maxContextLength = const Value.absent(),
                Value<int> maxOutputTokens = const Value.absent(),
                Value<bool> supportsStreaming = const Value.absent(),
                Value<bool> supportsFunctionCalling = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String?> configJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LlmModelsCompanion.insert(
                uuid: uuid,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                providerUuid: providerUuid,
                modelId: modelId,
                displayName: displayName,
                modelType: modelType,
                maxContextLength: maxContextLength,
                maxOutputTokens: maxOutputTokens,
                supportsStreaming: supportsStreaming,
                supportsFunctionCalling: supportsFunctionCalling,
                isDefault: isDefault,
                isEnabled: isEnabled,
                configJson: configJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LlmModelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                providerUuid = false,
                aiPersonasRefs = false,
                aiApiCallsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (aiPersonasRefs) db.aiPersonas,
                    if (aiApiCallsRefs) db.aiApiCalls,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (providerUuid) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.providerUuid,
                                    referencedTable: $$LlmModelsTableReferences
                                        ._providerUuidTable(db),
                                    referencedColumn: $$LlmModelsTableReferences
                                        ._providerUuidTable(db)
                                        .uuid,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (aiPersonasRefs)
                        await $_getPrefetchedData<
                          LlmModel,
                          $LlmModelsTable,
                          AiPersona
                        >(
                          currentTable: table,
                          referencedTable: $$LlmModelsTableReferences
                              ._aiPersonasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LlmModelsTableReferences(
                                db,
                                table,
                                p0,
                              ).aiPersonasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.modelUuid == item.uuid,
                              ),
                          typedResults: items,
                        ),
                      if (aiApiCallsRefs)
                        await $_getPrefetchedData<
                          LlmModel,
                          $LlmModelsTable,
                          AiApiCall
                        >(
                          currentTable: table,
                          referencedTable: $$LlmModelsTableReferences
                              ._aiApiCallsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LlmModelsTableReferences(
                                db,
                                table,
                                p0,
                              ).aiApiCallsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.modelUuid == item.uuid,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LlmModelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AiDatabase,
      $LlmModelsTable,
      LlmModel,
      $$LlmModelsTableFilterComposer,
      $$LlmModelsTableOrderingComposer,
      $$LlmModelsTableAnnotationComposer,
      $$LlmModelsTableCreateCompanionBuilder,
      $$LlmModelsTableUpdateCompanionBuilder,
      (LlmModel, $$LlmModelsTableReferences),
      LlmModel,
      PrefetchHooks Function({
        bool providerUuid,
        bool aiPersonasRefs,
        bool aiApiCallsRefs,
      })
    >;
typedef $$PromptTemplatesTableCreateCompanionBuilder =
    PromptTemplatesCompanion Function({
      required String uuid,
      required DateTime createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      required String name,
      Value<String?> description,
      required String templateType,
      required String content,
      Value<String?> variablesJson,
      Value<int> currentVersion,
      Value<bool> isBuiltin,
      Value<bool> isEnabled,
      Value<int> rowid,
    });
typedef $$PromptTemplatesTableUpdateCompanionBuilder =
    PromptTemplatesCompanion Function({
      Value<String> uuid,
      Value<DateTime> createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      Value<String> name,
      Value<String?> description,
      Value<String> templateType,
      Value<String> content,
      Value<String?> variablesJson,
      Value<int> currentVersion,
      Value<bool> isBuiltin,
      Value<bool> isEnabled,
      Value<int> rowid,
    });

final class $$PromptTemplatesTableReferences
    extends
        BaseReferences<_$AiDatabase, $PromptTemplatesTable, PromptTemplate> {
  $$PromptTemplatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$PromptVersionsTable, List<PromptVersion>>
  _promptVersionsRefsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.promptVersions,
    aliasName: $_aliasNameGenerator(
      db.promptTemplates.uuid,
      db.promptVersions.templateUuid,
    ),
  );

  $$PromptVersionsTableProcessedTableManager get promptVersionsRefs {
    final manager = $$PromptVersionsTableTableManager($_db, $_db.promptVersions)
        .filter(
          (f) => f.templateUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!),
        );

    final cache = $_typedResult.readTableOrNull(_promptVersionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PromptSkillBindingsTable,
    List<PromptSkillBinding>
  >
  _promptSkillBindingsRefsTable(_$AiDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.promptSkillBindings,
        aliasName: $_aliasNameGenerator(
          db.promptTemplates.uuid,
          db.promptSkillBindings.promptTemplateUuid,
        ),
      );

  $$PromptSkillBindingsTableProcessedTableManager get promptSkillBindingsRefs {
    final manager =
        $$PromptSkillBindingsTableTableManager(
          $_db,
          $_db.promptSkillBindings,
        ).filter(
          (f) => f.promptTemplateUuid.uuid.sqlEquals(
            $_itemColumn<String>('uuid')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _promptSkillBindingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AiPersonasTable, List<AiPersona>>
  _aiPersonasRefsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.aiPersonas,
    aliasName: $_aliasNameGenerator(
      db.promptTemplates.uuid,
      db.aiPersonas.systemPromptUuid,
    ),
  );

  $$AiPersonasTableProcessedTableManager get aiPersonasRefs {
    final manager = $$AiPersonasTableTableManager($_db, $_db.aiPersonas).filter(
      (f) => f.systemPromptUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!),
    );

    final cache = $_typedResult.readTableOrNull(_aiPersonasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PromptTemplatesTableFilterComposer
    extends Composer<_$AiDatabase, $PromptTemplatesTable> {
  $$PromptTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateType => $composableBuilder(
    column: $table.templateType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variablesJson => $composableBuilder(
    column: $table.variablesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentVersion => $composableBuilder(
    column: $table.currentVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltin => $composableBuilder(
    column: $table.isBuiltin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> promptVersionsRefs(
    Expression<bool> Function($$PromptVersionsTableFilterComposer f) f,
  ) {
    final $$PromptVersionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.promptVersions,
      getReferencedColumn: (t) => t.templateUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PromptVersionsTableFilterComposer(
            $db: $db,
            $table: $db.promptVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> promptSkillBindingsRefs(
    Expression<bool> Function($$PromptSkillBindingsTableFilterComposer f) f,
  ) {
    final $$PromptSkillBindingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.promptSkillBindings,
      getReferencedColumn: (t) => t.promptTemplateUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PromptSkillBindingsTableFilterComposer(
            $db: $db,
            $table: $db.promptSkillBindings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> aiPersonasRefs(
    Expression<bool> Function($$AiPersonasTableFilterComposer f) f,
  ) {
    final $$AiPersonasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.systemPromptUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableFilterComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PromptTemplatesTableOrderingComposer
    extends Composer<_$AiDatabase, $PromptTemplatesTable> {
  $$PromptTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateType => $composableBuilder(
    column: $table.templateType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variablesJson => $composableBuilder(
    column: $table.variablesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentVersion => $composableBuilder(
    column: $table.currentVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltin => $composableBuilder(
    column: $table.isBuiltin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PromptTemplatesTableAnnotationComposer
    extends Composer<_$AiDatabase, $PromptTemplatesTable> {
  $$PromptTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get templateType => $composableBuilder(
    column: $table.templateType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get variablesJson => $composableBuilder(
    column: $table.variablesJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentVersion => $composableBuilder(
    column: $table.currentVersion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBuiltin =>
      $composableBuilder(column: $table.isBuiltin, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  Expression<T> promptVersionsRefs<T extends Object>(
    Expression<T> Function($$PromptVersionsTableAnnotationComposer a) f,
  ) {
    final $$PromptVersionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.promptVersions,
      getReferencedColumn: (t) => t.templateUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PromptVersionsTableAnnotationComposer(
            $db: $db,
            $table: $db.promptVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> promptSkillBindingsRefs<T extends Object>(
    Expression<T> Function($$PromptSkillBindingsTableAnnotationComposer a) f,
  ) {
    final $$PromptSkillBindingsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.uuid,
          referencedTable: $db.promptSkillBindings,
          getReferencedColumn: (t) => t.promptTemplateUuid,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PromptSkillBindingsTableAnnotationComposer(
                $db: $db,
                $table: $db.promptSkillBindings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> aiPersonasRefs<T extends Object>(
    Expression<T> Function($$AiPersonasTableAnnotationComposer a) f,
  ) {
    final $$AiPersonasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.systemPromptUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableAnnotationComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PromptTemplatesTableTableManager
    extends
        RootTableManager<
          _$AiDatabase,
          $PromptTemplatesTable,
          PromptTemplate,
          $$PromptTemplatesTableFilterComposer,
          $$PromptTemplatesTableOrderingComposer,
          $$PromptTemplatesTableAnnotationComposer,
          $$PromptTemplatesTableCreateCompanionBuilder,
          $$PromptTemplatesTableUpdateCompanionBuilder,
          (PromptTemplate, $$PromptTemplatesTableReferences),
          PromptTemplate,
          PrefetchHooks Function({
            bool promptVersionsRefs,
            bool promptSkillBindingsRefs,
            bool aiPersonasRefs,
          })
        > {
  $$PromptTemplatesTableTableManager(
    _$AiDatabase db,
    $PromptTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PromptTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PromptTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PromptTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uuid = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> templateType = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> variablesJson = const Value.absent(),
                Value<int> currentVersion = const Value.absent(),
                Value<bool> isBuiltin = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PromptTemplatesCompanion(
                uuid: uuid,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                name: name,
                description: description,
                templateType: templateType,
                content: content,
                variablesJson: variablesJson,
                currentVersion: currentVersion,
                isBuiltin: isBuiltin,
                isEnabled: isEnabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uuid,
                required DateTime createdAt,
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                required String templateType,
                required String content,
                Value<String?> variablesJson = const Value.absent(),
                Value<int> currentVersion = const Value.absent(),
                Value<bool> isBuiltin = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PromptTemplatesCompanion.insert(
                uuid: uuid,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                name: name,
                description: description,
                templateType: templateType,
                content: content,
                variablesJson: variablesJson,
                currentVersion: currentVersion,
                isBuiltin: isBuiltin,
                isEnabled: isEnabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PromptTemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                promptVersionsRefs = false,
                promptSkillBindingsRefs = false,
                aiPersonasRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (promptVersionsRefs) db.promptVersions,
                    if (promptSkillBindingsRefs) db.promptSkillBindings,
                    if (aiPersonasRefs) db.aiPersonas,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (promptVersionsRefs)
                        await $_getPrefetchedData<
                          PromptTemplate,
                          $PromptTemplatesTable,
                          PromptVersion
                        >(
                          currentTable: table,
                          referencedTable: $$PromptTemplatesTableReferences
                              ._promptVersionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PromptTemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).promptVersionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.templateUuid == item.uuid,
                              ),
                          typedResults: items,
                        ),
                      if (promptSkillBindingsRefs)
                        await $_getPrefetchedData<
                          PromptTemplate,
                          $PromptTemplatesTable,
                          PromptSkillBinding
                        >(
                          currentTable: table,
                          referencedTable: $$PromptTemplatesTableReferences
                              ._promptSkillBindingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PromptTemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).promptSkillBindingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.promptTemplateUuid == item.uuid,
                              ),
                          typedResults: items,
                        ),
                      if (aiPersonasRefs)
                        await $_getPrefetchedData<
                          PromptTemplate,
                          $PromptTemplatesTable,
                          AiPersona
                        >(
                          currentTable: table,
                          referencedTable: $$PromptTemplatesTableReferences
                              ._aiPersonasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PromptTemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).aiPersonasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.systemPromptUuid == item.uuid,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PromptTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AiDatabase,
      $PromptTemplatesTable,
      PromptTemplate,
      $$PromptTemplatesTableFilterComposer,
      $$PromptTemplatesTableOrderingComposer,
      $$PromptTemplatesTableAnnotationComposer,
      $$PromptTemplatesTableCreateCompanionBuilder,
      $$PromptTemplatesTableUpdateCompanionBuilder,
      (PromptTemplate, $$PromptTemplatesTableReferences),
      PromptTemplate,
      PrefetchHooks Function({
        bool promptVersionsRefs,
        bool promptSkillBindingsRefs,
        bool aiPersonasRefs,
      })
    >;
typedef $$PromptVersionsTableCreateCompanionBuilder =
    PromptVersionsCompanion Function({
      required String uuid,
      required String templateUuid,
      required int version,
      required String content,
      Value<String?> variablesJson,
      required String contentHash,
      required DateTime createdAt,
      Value<String?> changeNote,
      Value<int> rowid,
    });
typedef $$PromptVersionsTableUpdateCompanionBuilder =
    PromptVersionsCompanion Function({
      Value<String> uuid,
      Value<String> templateUuid,
      Value<int> version,
      Value<String> content,
      Value<String?> variablesJson,
      Value<String> contentHash,
      Value<DateTime> createdAt,
      Value<String?> changeNote,
      Value<int> rowid,
    });

final class $$PromptVersionsTableReferences
    extends BaseReferences<_$AiDatabase, $PromptVersionsTable, PromptVersion> {
  $$PromptVersionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PromptTemplatesTable _templateUuidTable(_$AiDatabase db) =>
      db.promptTemplates.createAlias(
        $_aliasNameGenerator(
          db.promptVersions.templateUuid,
          db.promptTemplates.uuid,
        ),
      );

  $$PromptTemplatesTableProcessedTableManager get templateUuid {
    final $_column = $_itemColumn<String>('template_uuid')!;

    final manager = $$PromptTemplatesTableTableManager(
      $_db,
      $_db.promptTemplates,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PromptVersionsTableFilterComposer
    extends Composer<_$AiDatabase, $PromptVersionsTable> {
  $$PromptVersionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variablesJson => $composableBuilder(
    column: $table.variablesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changeNote => $composableBuilder(
    column: $table.changeNote,
    builder: (column) => ColumnFilters(column),
  );

  $$PromptTemplatesTableFilterComposer get templateUuid {
    final $$PromptTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateUuid,
      referencedTable: $db.promptTemplates,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PromptTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.promptTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PromptVersionsTableOrderingComposer
    extends Composer<_$AiDatabase, $PromptVersionsTable> {
  $$PromptVersionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variablesJson => $composableBuilder(
    column: $table.variablesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changeNote => $composableBuilder(
    column: $table.changeNote,
    builder: (column) => ColumnOrderings(column),
  );

  $$PromptTemplatesTableOrderingComposer get templateUuid {
    final $$PromptTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateUuid,
      referencedTable: $db.promptTemplates,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PromptTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.promptTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PromptVersionsTableAnnotationComposer
    extends Composer<_$AiDatabase, $PromptVersionsTable> {
  $$PromptVersionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get variablesJson => $composableBuilder(
    column: $table.variablesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get changeNote => $composableBuilder(
    column: $table.changeNote,
    builder: (column) => column,
  );

  $$PromptTemplatesTableAnnotationComposer get templateUuid {
    final $$PromptTemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateUuid,
      referencedTable: $db.promptTemplates,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PromptTemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.promptTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PromptVersionsTableTableManager
    extends
        RootTableManager<
          _$AiDatabase,
          $PromptVersionsTable,
          PromptVersion,
          $$PromptVersionsTableFilterComposer,
          $$PromptVersionsTableOrderingComposer,
          $$PromptVersionsTableAnnotationComposer,
          $$PromptVersionsTableCreateCompanionBuilder,
          $$PromptVersionsTableUpdateCompanionBuilder,
          (PromptVersion, $$PromptVersionsTableReferences),
          PromptVersion,
          PrefetchHooks Function({bool templateUuid})
        > {
  $$PromptVersionsTableTableManager(_$AiDatabase db, $PromptVersionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PromptVersionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PromptVersionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PromptVersionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uuid = const Value.absent(),
                Value<String> templateUuid = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> variablesJson = const Value.absent(),
                Value<String> contentHash = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> changeNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PromptVersionsCompanion(
                uuid: uuid,
                templateUuid: templateUuid,
                version: version,
                content: content,
                variablesJson: variablesJson,
                contentHash: contentHash,
                createdAt: createdAt,
                changeNote: changeNote,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uuid,
                required String templateUuid,
                required int version,
                required String content,
                Value<String?> variablesJson = const Value.absent(),
                required String contentHash,
                required DateTime createdAt,
                Value<String?> changeNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PromptVersionsCompanion.insert(
                uuid: uuid,
                templateUuid: templateUuid,
                version: version,
                content: content,
                variablesJson: variablesJson,
                contentHash: contentHash,
                createdAt: createdAt,
                changeNote: changeNote,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PromptVersionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({templateUuid = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (templateUuid) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.templateUuid,
                                referencedTable: $$PromptVersionsTableReferences
                                    ._templateUuidTable(db),
                                referencedColumn:
                                    $$PromptVersionsTableReferences
                                        ._templateUuidTable(db)
                                        .uuid,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PromptVersionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AiDatabase,
      $PromptVersionsTable,
      PromptVersion,
      $$PromptVersionsTableFilterComposer,
      $$PromptVersionsTableOrderingComposer,
      $$PromptVersionsTableAnnotationComposer,
      $$PromptVersionsTableCreateCompanionBuilder,
      $$PromptVersionsTableUpdateCompanionBuilder,
      (PromptVersion, $$PromptVersionsTableReferences),
      PromptVersion,
      PrefetchHooks Function({bool templateUuid})
    >;
typedef $$PromptSkillBindingsTableCreateCompanionBuilder =
    PromptSkillBindingsCompanion Function({
      Value<int> id,
      required DateTime createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      required String promptTemplateUuid,
      required int skillId,
      required String bindingType,
      Value<int> priority,
      Value<bool> isEnabled,
    });
typedef $$PromptSkillBindingsTableUpdateCompanionBuilder =
    PromptSkillBindingsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      Value<String> promptTemplateUuid,
      Value<int> skillId,
      Value<String> bindingType,
      Value<int> priority,
      Value<bool> isEnabled,
    });

final class $$PromptSkillBindingsTableReferences
    extends
        BaseReferences<
          _$AiDatabase,
          $PromptSkillBindingsTable,
          PromptSkillBinding
        > {
  $$PromptSkillBindingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PromptTemplatesTable _promptTemplateUuidTable(_$AiDatabase db) =>
      db.promptTemplates.createAlias(
        $_aliasNameGenerator(
          db.promptSkillBindings.promptTemplateUuid,
          db.promptTemplates.uuid,
        ),
      );

  $$PromptTemplatesTableProcessedTableManager get promptTemplateUuid {
    final $_column = $_itemColumn<String>('prompt_template_uuid')!;

    final manager = $$PromptTemplatesTableTableManager(
      $_db,
      $_db.promptTemplates,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_promptTemplateUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PromptSkillBindingsTableFilterComposer
    extends Composer<_$AiDatabase, $PromptSkillBindingsTable> {
  $$PromptSkillBindingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get skillId => $composableBuilder(
    column: $table.skillId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bindingType => $composableBuilder(
    column: $table.bindingType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  $$PromptTemplatesTableFilterComposer get promptTemplateUuid {
    final $$PromptTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.promptTemplateUuid,
      referencedTable: $db.promptTemplates,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PromptTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.promptTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PromptSkillBindingsTableOrderingComposer
    extends Composer<_$AiDatabase, $PromptSkillBindingsTable> {
  $$PromptSkillBindingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get skillId => $composableBuilder(
    column: $table.skillId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bindingType => $composableBuilder(
    column: $table.bindingType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  $$PromptTemplatesTableOrderingComposer get promptTemplateUuid {
    final $$PromptTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.promptTemplateUuid,
      referencedTable: $db.promptTemplates,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PromptTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.promptTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PromptSkillBindingsTableAnnotationComposer
    extends Composer<_$AiDatabase, $PromptSkillBindingsTable> {
  $$PromptSkillBindingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get skillId =>
      $composableBuilder(column: $table.skillId, builder: (column) => column);

  GeneratedColumn<String> get bindingType => $composableBuilder(
    column: $table.bindingType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  $$PromptTemplatesTableAnnotationComposer get promptTemplateUuid {
    final $$PromptTemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.promptTemplateUuid,
      referencedTable: $db.promptTemplates,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PromptTemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.promptTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PromptSkillBindingsTableTableManager
    extends
        RootTableManager<
          _$AiDatabase,
          $PromptSkillBindingsTable,
          PromptSkillBinding,
          $$PromptSkillBindingsTableFilterComposer,
          $$PromptSkillBindingsTableOrderingComposer,
          $$PromptSkillBindingsTableAnnotationComposer,
          $$PromptSkillBindingsTableCreateCompanionBuilder,
          $$PromptSkillBindingsTableUpdateCompanionBuilder,
          (PromptSkillBinding, $$PromptSkillBindingsTableReferences),
          PromptSkillBinding,
          PrefetchHooks Function({bool promptTemplateUuid})
        > {
  $$PromptSkillBindingsTableTableManager(
    _$AiDatabase db,
    $PromptSkillBindingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PromptSkillBindingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PromptSkillBindingsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PromptSkillBindingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> promptTemplateUuid = const Value.absent(),
                Value<int> skillId = const Value.absent(),
                Value<String> bindingType = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
              }) => PromptSkillBindingsCompanion(
                id: id,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                promptTemplateUuid: promptTemplateUuid,
                skillId: skillId,
                bindingType: bindingType,
                priority: priority,
                isEnabled: isEnabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String promptTemplateUuid,
                required int skillId,
                required String bindingType,
                Value<int> priority = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
              }) => PromptSkillBindingsCompanion.insert(
                id: id,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                promptTemplateUuid: promptTemplateUuid,
                skillId: skillId,
                bindingType: bindingType,
                priority: priority,
                isEnabled: isEnabled,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PromptSkillBindingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({promptTemplateUuid = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (promptTemplateUuid) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.promptTemplateUuid,
                                referencedTable:
                                    $$PromptSkillBindingsTableReferences
                                        ._promptTemplateUuidTable(db),
                                referencedColumn:
                                    $$PromptSkillBindingsTableReferences
                                        ._promptTemplateUuidTable(db)
                                        .uuid,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PromptSkillBindingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AiDatabase,
      $PromptSkillBindingsTable,
      PromptSkillBinding,
      $$PromptSkillBindingsTableFilterComposer,
      $$PromptSkillBindingsTableOrderingComposer,
      $$PromptSkillBindingsTableAnnotationComposer,
      $$PromptSkillBindingsTableCreateCompanionBuilder,
      $$PromptSkillBindingsTableUpdateCompanionBuilder,
      (PromptSkillBinding, $$PromptSkillBindingsTableReferences),
      PromptSkillBinding,
      PrefetchHooks Function({bool promptTemplateUuid})
    >;
typedef $$AiPersonasTableCreateCompanionBuilder =
    AiPersonasCompanion Function({
      required String uuid,
      required DateTime createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      required String name,
      Value<String?> avatarUrl,
      Value<String?> description,
      required String modelUuid,
      Value<String?> systemPromptUuid,
      Value<double> temperature,
      Value<double> topP,
      Value<int> maxTokens,
      Value<String?> personalityJson,
      Value<String?> expertiseJson,
      Value<bool> isDefault,
      Value<bool> isEnabled,
      Value<int> rowid,
    });
typedef $$AiPersonasTableUpdateCompanionBuilder =
    AiPersonasCompanion Function({
      Value<String> uuid,
      Value<DateTime> createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      Value<String> name,
      Value<String?> avatarUrl,
      Value<String?> description,
      Value<String> modelUuid,
      Value<String?> systemPromptUuid,
      Value<double> temperature,
      Value<double> topP,
      Value<int> maxTokens,
      Value<String?> personalityJson,
      Value<String?> expertiseJson,
      Value<bool> isDefault,
      Value<bool> isEnabled,
      Value<int> rowid,
    });

final class $$AiPersonasTableReferences
    extends BaseReferences<_$AiDatabase, $AiPersonasTable, AiPersona> {
  $$AiPersonasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LlmModelsTable _modelUuidTable(_$AiDatabase db) =>
      db.llmModels.createAlias(
        $_aliasNameGenerator(db.aiPersonas.modelUuid, db.llmModels.uuid),
      );

  $$LlmModelsTableProcessedTableManager get modelUuid {
    final $_column = $_itemColumn<String>('model_uuid')!;

    final manager = $$LlmModelsTableTableManager(
      $_db,
      $_db.llmModels,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_modelUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PromptTemplatesTable _systemPromptUuidTable(_$AiDatabase db) =>
      db.promptTemplates.createAlias(
        $_aliasNameGenerator(
          db.aiPersonas.systemPromptUuid,
          db.promptTemplates.uuid,
        ),
      );

  $$PromptTemplatesTableProcessedTableManager? get systemPromptUuid {
    final $_column = $_itemColumn<String>('system_prompt_uuid');
    if ($_column == null) return null;
    final manager = $$PromptTemplatesTableTableManager(
      $_db,
      $_db.promptTemplates,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_systemPromptUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AiChatSessionsTable, List<AiChatSession>>
  _aiChatSessionsRefsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.aiChatSessions,
    aliasName: $_aliasNameGenerator(
      db.aiPersonas.uuid,
      db.aiChatSessions.personaUuid,
    ),
  );

  $$AiChatSessionsTableProcessedTableManager get aiChatSessionsRefs {
    final manager = $$AiChatSessionsTableTableManager($_db, $_db.aiChatSessions)
        .filter(
          (f) => f.personaUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!),
        );

    final cache = $_typedResult.readTableOrNull(_aiChatSessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AiDivinationsTable, List<AiDivination>>
  _aiDivinationsRefsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.aiDivinations,
    aliasName: $_aliasNameGenerator(
      db.aiPersonas.uuid,
      db.aiDivinations.personaUuid,
    ),
  );

  $$AiDivinationsTableProcessedTableManager get aiDivinationsRefs {
    final manager = $$AiDivinationsTableTableManager($_db, $_db.aiDivinations)
        .filter(
          (f) => f.personaUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!),
        );

    final cache = $_typedResult.readTableOrNull(_aiDivinationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AgentInvocationsTable, List<AgentInvocation>>
  _callerInvocationsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.agentInvocations,
    aliasName: $_aliasNameGenerator(
      db.aiPersonas.uuid,
      db.agentInvocations.callerPersonaUuid,
    ),
  );

  $$AgentInvocationsTableProcessedTableManager get callerInvocations {
    final manager =
        $$AgentInvocationsTableTableManager($_db, $_db.agentInvocations).filter(
          (f) =>
              f.callerPersonaUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!),
        );

    final cache = $_typedResult.readTableOrNull(_callerInvocationsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AgentInvocationsTable, List<AgentInvocation>>
  _calleeInvocationsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.agentInvocations,
    aliasName: $_aliasNameGenerator(
      db.aiPersonas.uuid,
      db.agentInvocations.calleePersonaUuid,
    ),
  );

  $$AgentInvocationsTableProcessedTableManager get calleeInvocations {
    final manager =
        $$AgentInvocationsTableTableManager($_db, $_db.agentInvocations).filter(
          (f) =>
              f.calleePersonaUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!),
        );

    final cache = $_typedResult.readTableOrNull(_calleeInvocationsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AiPersonasTableFilterComposer
    extends Composer<_$AiDatabase, $AiPersonasTable> {
  $$AiPersonasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get topP => $composableBuilder(
    column: $table.topP,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxTokens => $composableBuilder(
    column: $table.maxTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get personalityJson => $composableBuilder(
    column: $table.personalityJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expertiseJson => $composableBuilder(
    column: $table.expertiseJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  $$LlmModelsTableFilterComposer get modelUuid {
    final $$LlmModelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.modelUuid,
      referencedTable: $db.llmModels,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LlmModelsTableFilterComposer(
            $db: $db,
            $table: $db.llmModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PromptTemplatesTableFilterComposer get systemPromptUuid {
    final $$PromptTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.systemPromptUuid,
      referencedTable: $db.promptTemplates,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PromptTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.promptTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> aiChatSessionsRefs(
    Expression<bool> Function($$AiChatSessionsTableFilterComposer f) f,
  ) {
    final $$AiChatSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiChatSessions,
      getReferencedColumn: (t) => t.personaUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatSessionsTableFilterComposer(
            $db: $db,
            $table: $db.aiChatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> aiDivinationsRefs(
    Expression<bool> Function($$AiDivinationsTableFilterComposer f) f,
  ) {
    final $$AiDivinationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiDivinations,
      getReferencedColumn: (t) => t.personaUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiDivinationsTableFilterComposer(
            $db: $db,
            $table: $db.aiDivinations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> callerInvocations(
    Expression<bool> Function($$AgentInvocationsTableFilterComposer f) f,
  ) {
    final $$AgentInvocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.agentInvocations,
      getReferencedColumn: (t) => t.callerPersonaUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentInvocationsTableFilterComposer(
            $db: $db,
            $table: $db.agentInvocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> calleeInvocations(
    Expression<bool> Function($$AgentInvocationsTableFilterComposer f) f,
  ) {
    final $$AgentInvocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.agentInvocations,
      getReferencedColumn: (t) => t.calleePersonaUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentInvocationsTableFilterComposer(
            $db: $db,
            $table: $db.agentInvocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AiPersonasTableOrderingComposer
    extends Composer<_$AiDatabase, $AiPersonasTable> {
  $$AiPersonasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get topP => $composableBuilder(
    column: $table.topP,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxTokens => $composableBuilder(
    column: $table.maxTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personalityJson => $composableBuilder(
    column: $table.personalityJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expertiseJson => $composableBuilder(
    column: $table.expertiseJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  $$LlmModelsTableOrderingComposer get modelUuid {
    final $$LlmModelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.modelUuid,
      referencedTable: $db.llmModels,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LlmModelsTableOrderingComposer(
            $db: $db,
            $table: $db.llmModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PromptTemplatesTableOrderingComposer get systemPromptUuid {
    final $$PromptTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.systemPromptUuid,
      referencedTable: $db.promptTemplates,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PromptTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.promptTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiPersonasTableAnnotationComposer
    extends Composer<_$AiDatabase, $AiPersonasTable> {
  $$AiPersonasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<double> get topP =>
      $composableBuilder(column: $table.topP, builder: (column) => column);

  GeneratedColumn<int> get maxTokens =>
      $composableBuilder(column: $table.maxTokens, builder: (column) => column);

  GeneratedColumn<String> get personalityJson => $composableBuilder(
    column: $table.personalityJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get expertiseJson => $composableBuilder(
    column: $table.expertiseJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  $$LlmModelsTableAnnotationComposer get modelUuid {
    final $$LlmModelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.modelUuid,
      referencedTable: $db.llmModels,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LlmModelsTableAnnotationComposer(
            $db: $db,
            $table: $db.llmModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PromptTemplatesTableAnnotationComposer get systemPromptUuid {
    final $$PromptTemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.systemPromptUuid,
      referencedTable: $db.promptTemplates,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PromptTemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.promptTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> aiChatSessionsRefs<T extends Object>(
    Expression<T> Function($$AiChatSessionsTableAnnotationComposer a) f,
  ) {
    final $$AiChatSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiChatSessions,
      getReferencedColumn: (t) => t.personaUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.aiChatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> aiDivinationsRefs<T extends Object>(
    Expression<T> Function($$AiDivinationsTableAnnotationComposer a) f,
  ) {
    final $$AiDivinationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiDivinations,
      getReferencedColumn: (t) => t.personaUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiDivinationsTableAnnotationComposer(
            $db: $db,
            $table: $db.aiDivinations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> callerInvocations<T extends Object>(
    Expression<T> Function($$AgentInvocationsTableAnnotationComposer a) f,
  ) {
    final $$AgentInvocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.agentInvocations,
      getReferencedColumn: (t) => t.callerPersonaUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentInvocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.agentInvocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> calleeInvocations<T extends Object>(
    Expression<T> Function($$AgentInvocationsTableAnnotationComposer a) f,
  ) {
    final $$AgentInvocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.agentInvocations,
      getReferencedColumn: (t) => t.calleePersonaUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentInvocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.agentInvocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AiPersonasTableTableManager
    extends
        RootTableManager<
          _$AiDatabase,
          $AiPersonasTable,
          AiPersona,
          $$AiPersonasTableFilterComposer,
          $$AiPersonasTableOrderingComposer,
          $$AiPersonasTableAnnotationComposer,
          $$AiPersonasTableCreateCompanionBuilder,
          $$AiPersonasTableUpdateCompanionBuilder,
          (AiPersona, $$AiPersonasTableReferences),
          AiPersona,
          PrefetchHooks Function({
            bool modelUuid,
            bool systemPromptUuid,
            bool aiChatSessionsRefs,
            bool aiDivinationsRefs,
            bool callerInvocations,
            bool calleeInvocations,
          })
        > {
  $$AiPersonasTableTableManager(_$AiDatabase db, $AiPersonasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiPersonasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiPersonasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiPersonasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uuid = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> modelUuid = const Value.absent(),
                Value<String?> systemPromptUuid = const Value.absent(),
                Value<double> temperature = const Value.absent(),
                Value<double> topP = const Value.absent(),
                Value<int> maxTokens = const Value.absent(),
                Value<String?> personalityJson = const Value.absent(),
                Value<String?> expertiseJson = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiPersonasCompanion(
                uuid: uuid,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                name: name,
                avatarUrl: avatarUrl,
                description: description,
                modelUuid: modelUuid,
                systemPromptUuid: systemPromptUuid,
                temperature: temperature,
                topP: topP,
                maxTokens: maxTokens,
                personalityJson: personalityJson,
                expertiseJson: expertiseJson,
                isDefault: isDefault,
                isEnabled: isEnabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uuid,
                required DateTime createdAt,
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String name,
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required String modelUuid,
                Value<String?> systemPromptUuid = const Value.absent(),
                Value<double> temperature = const Value.absent(),
                Value<double> topP = const Value.absent(),
                Value<int> maxTokens = const Value.absent(),
                Value<String?> personalityJson = const Value.absent(),
                Value<String?> expertiseJson = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiPersonasCompanion.insert(
                uuid: uuid,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                name: name,
                avatarUrl: avatarUrl,
                description: description,
                modelUuid: modelUuid,
                systemPromptUuid: systemPromptUuid,
                temperature: temperature,
                topP: topP,
                maxTokens: maxTokens,
                personalityJson: personalityJson,
                expertiseJson: expertiseJson,
                isDefault: isDefault,
                isEnabled: isEnabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AiPersonasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                modelUuid = false,
                systemPromptUuid = false,
                aiChatSessionsRefs = false,
                aiDivinationsRefs = false,
                callerInvocations = false,
                calleeInvocations = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (aiChatSessionsRefs) db.aiChatSessions,
                    if (aiDivinationsRefs) db.aiDivinations,
                    if (callerInvocations) db.agentInvocations,
                    if (calleeInvocations) db.agentInvocations,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (modelUuid) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.modelUuid,
                                    referencedTable: $$AiPersonasTableReferences
                                        ._modelUuidTable(db),
                                    referencedColumn:
                                        $$AiPersonasTableReferences
                                            ._modelUuidTable(db)
                                            .uuid,
                                  )
                                  as T;
                        }
                        if (systemPromptUuid) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.systemPromptUuid,
                                    referencedTable: $$AiPersonasTableReferences
                                        ._systemPromptUuidTable(db),
                                    referencedColumn:
                                        $$AiPersonasTableReferences
                                            ._systemPromptUuidTable(db)
                                            .uuid,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (aiChatSessionsRefs)
                        await $_getPrefetchedData<
                          AiPersona,
                          $AiPersonasTable,
                          AiChatSession
                        >(
                          currentTable: table,
                          referencedTable: $$AiPersonasTableReferences
                              ._aiChatSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AiPersonasTableReferences(
                                db,
                                table,
                                p0,
                              ).aiChatSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.personaUuid == item.uuid,
                              ),
                          typedResults: items,
                        ),
                      if (aiDivinationsRefs)
                        await $_getPrefetchedData<
                          AiPersona,
                          $AiPersonasTable,
                          AiDivination
                        >(
                          currentTable: table,
                          referencedTable: $$AiPersonasTableReferences
                              ._aiDivinationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AiPersonasTableReferences(
                                db,
                                table,
                                p0,
                              ).aiDivinationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.personaUuid == item.uuid,
                              ),
                          typedResults: items,
                        ),
                      if (callerInvocations)
                        await $_getPrefetchedData<
                          AiPersona,
                          $AiPersonasTable,
                          AgentInvocation
                        >(
                          currentTable: table,
                          referencedTable: $$AiPersonasTableReferences
                              ._callerInvocationsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AiPersonasTableReferences(
                                db,
                                table,
                                p0,
                              ).callerInvocations,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.callerPersonaUuid == item.uuid,
                              ),
                          typedResults: items,
                        ),
                      if (calleeInvocations)
                        await $_getPrefetchedData<
                          AiPersona,
                          $AiPersonasTable,
                          AgentInvocation
                        >(
                          currentTable: table,
                          referencedTable: $$AiPersonasTableReferences
                              ._calleeInvocationsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AiPersonasTableReferences(
                                db,
                                table,
                                p0,
                              ).calleeInvocations,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.calleePersonaUuid == item.uuid,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AiPersonasTableProcessedTableManager =
    ProcessedTableManager<
      _$AiDatabase,
      $AiPersonasTable,
      AiPersona,
      $$AiPersonasTableFilterComposer,
      $$AiPersonasTableOrderingComposer,
      $$AiPersonasTableAnnotationComposer,
      $$AiPersonasTableCreateCompanionBuilder,
      $$AiPersonasTableUpdateCompanionBuilder,
      (AiPersona, $$AiPersonasTableReferences),
      AiPersona,
      PrefetchHooks Function({
        bool modelUuid,
        bool systemPromptUuid,
        bool aiChatSessionsRefs,
        bool aiDivinationsRefs,
        bool callerInvocations,
        bool calleeInvocations,
      })
    >;
typedef $$AiChatSessionsTableCreateCompanionBuilder =
    AiChatSessionsCompanion Function({
      required String uuid,
      required DateTime createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      Value<String?> title,
      required String personaUuid,
      Value<String?> divinationUuid,
      Value<String> status,
      Value<String?> contextJson,
      Value<int> messageCount,
      Value<DateTime?> lastMessageAt,
      Value<int> rowid,
    });
typedef $$AiChatSessionsTableUpdateCompanionBuilder =
    AiChatSessionsCompanion Function({
      Value<String> uuid,
      Value<DateTime> createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      Value<String?> title,
      Value<String> personaUuid,
      Value<String?> divinationUuid,
      Value<String> status,
      Value<String?> contextJson,
      Value<int> messageCount,
      Value<DateTime?> lastMessageAt,
      Value<int> rowid,
    });

final class $$AiChatSessionsTableReferences
    extends BaseReferences<_$AiDatabase, $AiChatSessionsTable, AiChatSession> {
  $$AiChatSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AiPersonasTable _personaUuidTable(_$AiDatabase db) =>
      db.aiPersonas.createAlias(
        $_aliasNameGenerator(db.aiChatSessions.personaUuid, db.aiPersonas.uuid),
      );

  $$AiPersonasTableProcessedTableManager get personaUuid {
    final $_column = $_itemColumn<String>('persona_uuid')!;

    final manager = $$AiPersonasTableTableManager(
      $_db,
      $_db.aiPersonas,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personaUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AiApiCallsTable, List<AiApiCall>>
  _aiApiCallsRefsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.aiApiCalls,
    aliasName: $_aliasNameGenerator(
      db.aiChatSessions.uuid,
      db.aiApiCalls.sessionUuid,
    ),
  );

  $$AiApiCallsTableProcessedTableManager get aiApiCallsRefs {
    final manager = $$AiApiCallsTableTableManager($_db, $_db.aiApiCalls).filter(
      (f) => f.sessionUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!),
    );

    final cache = $_typedResult.readTableOrNull(_aiApiCallsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AiChatMessagesTable, List<AiChatMessage>>
  _aiChatMessagesRefsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.aiChatMessages,
    aliasName: $_aliasNameGenerator(
      db.aiChatSessions.uuid,
      db.aiChatMessages.sessionUuid,
    ),
  );

  $$AiChatMessagesTableProcessedTableManager get aiChatMessagesRefs {
    final manager = $$AiChatMessagesTableTableManager($_db, $_db.aiChatMessages)
        .filter(
          (f) => f.sessionUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!),
        );

    final cache = $_typedResult.readTableOrNull(_aiChatMessagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AiDivinationsTable, List<AiDivination>>
  _aiDivinationsRefsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.aiDivinations,
    aliasName: $_aliasNameGenerator(
      db.aiChatSessions.uuid,
      db.aiDivinations.sessionUuid,
    ),
  );

  $$AiDivinationsTableProcessedTableManager get aiDivinationsRefs {
    final manager = $$AiDivinationsTableTableManager($_db, $_db.aiDivinations)
        .filter(
          (f) => f.sessionUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!),
        );

    final cache = $_typedResult.readTableOrNull(_aiDivinationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AgentInvocationsTable, List<AgentInvocation>>
  _agentInvocationsRefsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.agentInvocations,
    aliasName: $_aliasNameGenerator(
      db.aiChatSessions.uuid,
      db.agentInvocations.sessionUuid,
    ),
  );

  $$AgentInvocationsTableProcessedTableManager get agentInvocationsRefs {
    final manager =
        $$AgentInvocationsTableTableManager($_db, $_db.agentInvocations).filter(
          (f) => f.sessionUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _agentInvocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AiChatSessionsTableFilterComposer
    extends Composer<_$AiDatabase, $AiChatSessionsTable> {
  $$AiChatSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get divinationUuid => $composableBuilder(
    column: $table.divinationUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contextJson => $composableBuilder(
    column: $table.contextJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get messageCount => $composableBuilder(
    column: $table.messageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AiPersonasTableFilterComposer get personaUuid {
    final $$AiPersonasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaUuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableFilterComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> aiApiCallsRefs(
    Expression<bool> Function($$AiApiCallsTableFilterComposer f) f,
  ) {
    final $$AiApiCallsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiApiCalls,
      getReferencedColumn: (t) => t.sessionUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiApiCallsTableFilterComposer(
            $db: $db,
            $table: $db.aiApiCalls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> aiChatMessagesRefs(
    Expression<bool> Function($$AiChatMessagesTableFilterComposer f) f,
  ) {
    final $$AiChatMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiChatMessages,
      getReferencedColumn: (t) => t.sessionUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatMessagesTableFilterComposer(
            $db: $db,
            $table: $db.aiChatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> aiDivinationsRefs(
    Expression<bool> Function($$AiDivinationsTableFilterComposer f) f,
  ) {
    final $$AiDivinationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiDivinations,
      getReferencedColumn: (t) => t.sessionUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiDivinationsTableFilterComposer(
            $db: $db,
            $table: $db.aiDivinations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> agentInvocationsRefs(
    Expression<bool> Function($$AgentInvocationsTableFilterComposer f) f,
  ) {
    final $$AgentInvocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.agentInvocations,
      getReferencedColumn: (t) => t.sessionUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentInvocationsTableFilterComposer(
            $db: $db,
            $table: $db.agentInvocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AiChatSessionsTableOrderingComposer
    extends Composer<_$AiDatabase, $AiChatSessionsTable> {
  $$AiChatSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get divinationUuid => $composableBuilder(
    column: $table.divinationUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contextJson => $composableBuilder(
    column: $table.contextJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get messageCount => $composableBuilder(
    column: $table.messageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AiPersonasTableOrderingComposer get personaUuid {
    final $$AiPersonasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaUuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableOrderingComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiChatSessionsTableAnnotationComposer
    extends Composer<_$AiDatabase, $AiChatSessionsTable> {
  $$AiChatSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get divinationUuid => $composableBuilder(
    column: $table.divinationUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get contextJson => $composableBuilder(
    column: $table.contextJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get messageCount => $composableBuilder(
    column: $table.messageCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => column,
  );

  $$AiPersonasTableAnnotationComposer get personaUuid {
    final $$AiPersonasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaUuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableAnnotationComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> aiApiCallsRefs<T extends Object>(
    Expression<T> Function($$AiApiCallsTableAnnotationComposer a) f,
  ) {
    final $$AiApiCallsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiApiCalls,
      getReferencedColumn: (t) => t.sessionUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiApiCallsTableAnnotationComposer(
            $db: $db,
            $table: $db.aiApiCalls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> aiChatMessagesRefs<T extends Object>(
    Expression<T> Function($$AiChatMessagesTableAnnotationComposer a) f,
  ) {
    final $$AiChatMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiChatMessages,
      getReferencedColumn: (t) => t.sessionUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.aiChatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> aiDivinationsRefs<T extends Object>(
    Expression<T> Function($$AiDivinationsTableAnnotationComposer a) f,
  ) {
    final $$AiDivinationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiDivinations,
      getReferencedColumn: (t) => t.sessionUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiDivinationsTableAnnotationComposer(
            $db: $db,
            $table: $db.aiDivinations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> agentInvocationsRefs<T extends Object>(
    Expression<T> Function($$AgentInvocationsTableAnnotationComposer a) f,
  ) {
    final $$AgentInvocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.agentInvocations,
      getReferencedColumn: (t) => t.sessionUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentInvocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.agentInvocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AiChatSessionsTableTableManager
    extends
        RootTableManager<
          _$AiDatabase,
          $AiChatSessionsTable,
          AiChatSession,
          $$AiChatSessionsTableFilterComposer,
          $$AiChatSessionsTableOrderingComposer,
          $$AiChatSessionsTableAnnotationComposer,
          $$AiChatSessionsTableCreateCompanionBuilder,
          $$AiChatSessionsTableUpdateCompanionBuilder,
          (AiChatSession, $$AiChatSessionsTableReferences),
          AiChatSession,
          PrefetchHooks Function({
            bool personaUuid,
            bool aiApiCallsRefs,
            bool aiChatMessagesRefs,
            bool aiDivinationsRefs,
            bool agentInvocationsRefs,
          })
        > {
  $$AiChatSessionsTableTableManager(_$AiDatabase db, $AiChatSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiChatSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiChatSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiChatSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uuid = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String> personaUuid = const Value.absent(),
                Value<String?> divinationUuid = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> contextJson = const Value.absent(),
                Value<int> messageCount = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiChatSessionsCompanion(
                uuid: uuid,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                title: title,
                personaUuid: personaUuid,
                divinationUuid: divinationUuid,
                status: status,
                contextJson: contextJson,
                messageCount: messageCount,
                lastMessageAt: lastMessageAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uuid,
                required DateTime createdAt,
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String?> title = const Value.absent(),
                required String personaUuid,
                Value<String?> divinationUuid = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> contextJson = const Value.absent(),
                Value<int> messageCount = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiChatSessionsCompanion.insert(
                uuid: uuid,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                title: title,
                personaUuid: personaUuid,
                divinationUuid: divinationUuid,
                status: status,
                contextJson: contextJson,
                messageCount: messageCount,
                lastMessageAt: lastMessageAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AiChatSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                personaUuid = false,
                aiApiCallsRefs = false,
                aiChatMessagesRefs = false,
                aiDivinationsRefs = false,
                agentInvocationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (aiApiCallsRefs) db.aiApiCalls,
                    if (aiChatMessagesRefs) db.aiChatMessages,
                    if (aiDivinationsRefs) db.aiDivinations,
                    if (agentInvocationsRefs) db.agentInvocations,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (personaUuid) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.personaUuid,
                                    referencedTable:
                                        $$AiChatSessionsTableReferences
                                            ._personaUuidTable(db),
                                    referencedColumn:
                                        $$AiChatSessionsTableReferences
                                            ._personaUuidTable(db)
                                            .uuid,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (aiApiCallsRefs)
                        await $_getPrefetchedData<
                          AiChatSession,
                          $AiChatSessionsTable,
                          AiApiCall
                        >(
                          currentTable: table,
                          referencedTable: $$AiChatSessionsTableReferences
                              ._aiApiCallsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AiChatSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).aiApiCallsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionUuid == item.uuid,
                              ),
                          typedResults: items,
                        ),
                      if (aiChatMessagesRefs)
                        await $_getPrefetchedData<
                          AiChatSession,
                          $AiChatSessionsTable,
                          AiChatMessage
                        >(
                          currentTable: table,
                          referencedTable: $$AiChatSessionsTableReferences
                              ._aiChatMessagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AiChatSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).aiChatMessagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionUuid == item.uuid,
                              ),
                          typedResults: items,
                        ),
                      if (aiDivinationsRefs)
                        await $_getPrefetchedData<
                          AiChatSession,
                          $AiChatSessionsTable,
                          AiDivination
                        >(
                          currentTable: table,
                          referencedTable: $$AiChatSessionsTableReferences
                              ._aiDivinationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AiChatSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).aiDivinationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionUuid == item.uuid,
                              ),
                          typedResults: items,
                        ),
                      if (agentInvocationsRefs)
                        await $_getPrefetchedData<
                          AiChatSession,
                          $AiChatSessionsTable,
                          AgentInvocation
                        >(
                          currentTable: table,
                          referencedTable: $$AiChatSessionsTableReferences
                              ._agentInvocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AiChatSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).agentInvocationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionUuid == item.uuid,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AiChatSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AiDatabase,
      $AiChatSessionsTable,
      AiChatSession,
      $$AiChatSessionsTableFilterComposer,
      $$AiChatSessionsTableOrderingComposer,
      $$AiChatSessionsTableAnnotationComposer,
      $$AiChatSessionsTableCreateCompanionBuilder,
      $$AiChatSessionsTableUpdateCompanionBuilder,
      (AiChatSession, $$AiChatSessionsTableReferences),
      AiChatSession,
      PrefetchHooks Function({
        bool personaUuid,
        bool aiApiCallsRefs,
        bool aiChatMessagesRefs,
        bool aiDivinationsRefs,
        bool agentInvocationsRefs,
      })
    >;
typedef $$AiApiCallsTableCreateCompanionBuilder =
    AiApiCallsCompanion Function({
      required String uuid,
      Value<String?> sessionUuid,
      required String modelUuid,
      required DateTime requestedAt,
      Value<DateTime?> respondedAt,
      required String requestJson,
      Value<String?> responseJson,
      Value<String> status,
      Value<String?> errorMessage,
      Value<int?> inputTokens,
      Value<int?> outputTokens,
      Value<int?> totalTokens,
      Value<int?> latencyMs,
      Value<bool> isStreaming,
      Value<int> rowid,
    });
typedef $$AiApiCallsTableUpdateCompanionBuilder =
    AiApiCallsCompanion Function({
      Value<String> uuid,
      Value<String?> sessionUuid,
      Value<String> modelUuid,
      Value<DateTime> requestedAt,
      Value<DateTime?> respondedAt,
      Value<String> requestJson,
      Value<String?> responseJson,
      Value<String> status,
      Value<String?> errorMessage,
      Value<int?> inputTokens,
      Value<int?> outputTokens,
      Value<int?> totalTokens,
      Value<int?> latencyMs,
      Value<bool> isStreaming,
      Value<int> rowid,
    });

final class $$AiApiCallsTableReferences
    extends BaseReferences<_$AiDatabase, $AiApiCallsTable, AiApiCall> {
  $$AiApiCallsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AiChatSessionsTable _sessionUuidTable(_$AiDatabase db) =>
      db.aiChatSessions.createAlias(
        $_aliasNameGenerator(db.aiApiCalls.sessionUuid, db.aiChatSessions.uuid),
      );

  $$AiChatSessionsTableProcessedTableManager? get sessionUuid {
    final $_column = $_itemColumn<String>('session_uuid');
    if ($_column == null) return null;
    final manager = $$AiChatSessionsTableTableManager(
      $_db,
      $_db.aiChatSessions,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LlmModelsTable _modelUuidTable(_$AiDatabase db) =>
      db.llmModels.createAlias(
        $_aliasNameGenerator(db.aiApiCalls.modelUuid, db.llmModels.uuid),
      );

  $$LlmModelsTableProcessedTableManager get modelUuid {
    final $_column = $_itemColumn<String>('model_uuid')!;

    final manager = $$LlmModelsTableTableManager(
      $_db,
      $_db.llmModels,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_modelUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AiChatMessagesTable, List<AiChatMessage>>
  _aiChatMessagesRefsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.aiChatMessages,
    aliasName: $_aliasNameGenerator(
      db.aiApiCalls.uuid,
      db.aiChatMessages.apiCallUuid,
    ),
  );

  $$AiChatMessagesTableProcessedTableManager get aiChatMessagesRefs {
    final manager = $$AiChatMessagesTableTableManager($_db, $_db.aiChatMessages)
        .filter(
          (f) => f.apiCallUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!),
        );

    final cache = $_typedResult.readTableOrNull(_aiChatMessagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AiApiCallsTableFilterComposer
    extends Composer<_$AiDatabase, $AiApiCallsTable> {
  $$AiApiCallsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get respondedAt => $composableBuilder(
    column: $table.respondedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requestJson => $composableBuilder(
    column: $table.requestJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get responseJson => $composableBuilder(
    column: $table.responseJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalTokens => $composableBuilder(
    column: $table.totalTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get latencyMs => $composableBuilder(
    column: $table.latencyMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isStreaming => $composableBuilder(
    column: $table.isStreaming,
    builder: (column) => ColumnFilters(column),
  );

  $$AiChatSessionsTableFilterComposer get sessionUuid {
    final $$AiChatSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionUuid,
      referencedTable: $db.aiChatSessions,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatSessionsTableFilterComposer(
            $db: $db,
            $table: $db.aiChatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LlmModelsTableFilterComposer get modelUuid {
    final $$LlmModelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.modelUuid,
      referencedTable: $db.llmModels,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LlmModelsTableFilterComposer(
            $db: $db,
            $table: $db.llmModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> aiChatMessagesRefs(
    Expression<bool> Function($$AiChatMessagesTableFilterComposer f) f,
  ) {
    final $$AiChatMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiChatMessages,
      getReferencedColumn: (t) => t.apiCallUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatMessagesTableFilterComposer(
            $db: $db,
            $table: $db.aiChatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AiApiCallsTableOrderingComposer
    extends Composer<_$AiDatabase, $AiApiCallsTable> {
  $$AiApiCallsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get respondedAt => $composableBuilder(
    column: $table.respondedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requestJson => $composableBuilder(
    column: $table.requestJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get responseJson => $composableBuilder(
    column: $table.responseJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalTokens => $composableBuilder(
    column: $table.totalTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get latencyMs => $composableBuilder(
    column: $table.latencyMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isStreaming => $composableBuilder(
    column: $table.isStreaming,
    builder: (column) => ColumnOrderings(column),
  );

  $$AiChatSessionsTableOrderingComposer get sessionUuid {
    final $$AiChatSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionUuid,
      referencedTable: $db.aiChatSessions,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.aiChatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LlmModelsTableOrderingComposer get modelUuid {
    final $$LlmModelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.modelUuid,
      referencedTable: $db.llmModels,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LlmModelsTableOrderingComposer(
            $db: $db,
            $table: $db.llmModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiApiCallsTableAnnotationComposer
    extends Composer<_$AiDatabase, $AiApiCallsTable> {
  $$AiApiCallsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get respondedAt => $composableBuilder(
    column: $table.respondedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get requestJson => $composableBuilder(
    column: $table.requestJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get responseJson => $composableBuilder(
    column: $table.responseJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalTokens => $composableBuilder(
    column: $table.totalTokens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get latencyMs =>
      $composableBuilder(column: $table.latencyMs, builder: (column) => column);

  GeneratedColumn<bool> get isStreaming => $composableBuilder(
    column: $table.isStreaming,
    builder: (column) => column,
  );

  $$AiChatSessionsTableAnnotationComposer get sessionUuid {
    final $$AiChatSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionUuid,
      referencedTable: $db.aiChatSessions,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.aiChatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LlmModelsTableAnnotationComposer get modelUuid {
    final $$LlmModelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.modelUuid,
      referencedTable: $db.llmModels,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LlmModelsTableAnnotationComposer(
            $db: $db,
            $table: $db.llmModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> aiChatMessagesRefs<T extends Object>(
    Expression<T> Function($$AiChatMessagesTableAnnotationComposer a) f,
  ) {
    final $$AiChatMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiChatMessages,
      getReferencedColumn: (t) => t.apiCallUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.aiChatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AiApiCallsTableTableManager
    extends
        RootTableManager<
          _$AiDatabase,
          $AiApiCallsTable,
          AiApiCall,
          $$AiApiCallsTableFilterComposer,
          $$AiApiCallsTableOrderingComposer,
          $$AiApiCallsTableAnnotationComposer,
          $$AiApiCallsTableCreateCompanionBuilder,
          $$AiApiCallsTableUpdateCompanionBuilder,
          (AiApiCall, $$AiApiCallsTableReferences),
          AiApiCall,
          PrefetchHooks Function({
            bool sessionUuid,
            bool modelUuid,
            bool aiChatMessagesRefs,
          })
        > {
  $$AiApiCallsTableTableManager(_$AiDatabase db, $AiApiCallsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiApiCallsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiApiCallsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiApiCallsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uuid = const Value.absent(),
                Value<String?> sessionUuid = const Value.absent(),
                Value<String> modelUuid = const Value.absent(),
                Value<DateTime> requestedAt = const Value.absent(),
                Value<DateTime?> respondedAt = const Value.absent(),
                Value<String> requestJson = const Value.absent(),
                Value<String?> responseJson = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<int?> inputTokens = const Value.absent(),
                Value<int?> outputTokens = const Value.absent(),
                Value<int?> totalTokens = const Value.absent(),
                Value<int?> latencyMs = const Value.absent(),
                Value<bool> isStreaming = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiApiCallsCompanion(
                uuid: uuid,
                sessionUuid: sessionUuid,
                modelUuid: modelUuid,
                requestedAt: requestedAt,
                respondedAt: respondedAt,
                requestJson: requestJson,
                responseJson: responseJson,
                status: status,
                errorMessage: errorMessage,
                inputTokens: inputTokens,
                outputTokens: outputTokens,
                totalTokens: totalTokens,
                latencyMs: latencyMs,
                isStreaming: isStreaming,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uuid,
                Value<String?> sessionUuid = const Value.absent(),
                required String modelUuid,
                required DateTime requestedAt,
                Value<DateTime?> respondedAt = const Value.absent(),
                required String requestJson,
                Value<String?> responseJson = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<int?> inputTokens = const Value.absent(),
                Value<int?> outputTokens = const Value.absent(),
                Value<int?> totalTokens = const Value.absent(),
                Value<int?> latencyMs = const Value.absent(),
                Value<bool> isStreaming = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiApiCallsCompanion.insert(
                uuid: uuid,
                sessionUuid: sessionUuid,
                modelUuid: modelUuid,
                requestedAt: requestedAt,
                respondedAt: respondedAt,
                requestJson: requestJson,
                responseJson: responseJson,
                status: status,
                errorMessage: errorMessage,
                inputTokens: inputTokens,
                outputTokens: outputTokens,
                totalTokens: totalTokens,
                latencyMs: latencyMs,
                isStreaming: isStreaming,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AiApiCallsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sessionUuid = false,
                modelUuid = false,
                aiChatMessagesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (aiChatMessagesRefs) db.aiChatMessages,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sessionUuid) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sessionUuid,
                                    referencedTable: $$AiApiCallsTableReferences
                                        ._sessionUuidTable(db),
                                    referencedColumn:
                                        $$AiApiCallsTableReferences
                                            ._sessionUuidTable(db)
                                            .uuid,
                                  )
                                  as T;
                        }
                        if (modelUuid) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.modelUuid,
                                    referencedTable: $$AiApiCallsTableReferences
                                        ._modelUuidTable(db),
                                    referencedColumn:
                                        $$AiApiCallsTableReferences
                                            ._modelUuidTable(db)
                                            .uuid,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (aiChatMessagesRefs)
                        await $_getPrefetchedData<
                          AiApiCall,
                          $AiApiCallsTable,
                          AiChatMessage
                        >(
                          currentTable: table,
                          referencedTable: $$AiApiCallsTableReferences
                              ._aiChatMessagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AiApiCallsTableReferences(
                                db,
                                table,
                                p0,
                              ).aiChatMessagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.apiCallUuid == item.uuid,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AiApiCallsTableProcessedTableManager =
    ProcessedTableManager<
      _$AiDatabase,
      $AiApiCallsTable,
      AiApiCall,
      $$AiApiCallsTableFilterComposer,
      $$AiApiCallsTableOrderingComposer,
      $$AiApiCallsTableAnnotationComposer,
      $$AiApiCallsTableCreateCompanionBuilder,
      $$AiApiCallsTableUpdateCompanionBuilder,
      (AiApiCall, $$AiApiCallsTableReferences),
      AiApiCall,
      PrefetchHooks Function({
        bool sessionUuid,
        bool modelUuid,
        bool aiChatMessagesRefs,
      })
    >;
typedef $$AiChatMessagesTableCreateCompanionBuilder =
    AiChatMessagesCompanion Function({
      required String uuid,
      required String sessionUuid,
      required String role,
      required String content,
      required int sequence,
      required DateTime createdAt,
      Value<bool> isStreaming,
      Value<DateTime?> streamCompletedAt,
      Value<String?> toolCallId,
      Value<String?> toolCallsJson,
      Value<String?> usageJson,
      Value<String?> apiCallUuid,
      Value<int> rowid,
    });
typedef $$AiChatMessagesTableUpdateCompanionBuilder =
    AiChatMessagesCompanion Function({
      Value<String> uuid,
      Value<String> sessionUuid,
      Value<String> role,
      Value<String> content,
      Value<int> sequence,
      Value<DateTime> createdAt,
      Value<bool> isStreaming,
      Value<DateTime?> streamCompletedAt,
      Value<String?> toolCallId,
      Value<String?> toolCallsJson,
      Value<String?> usageJson,
      Value<String?> apiCallUuid,
      Value<int> rowid,
    });

final class $$AiChatMessagesTableReferences
    extends BaseReferences<_$AiDatabase, $AiChatMessagesTable, AiChatMessage> {
  $$AiChatMessagesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AiChatSessionsTable _sessionUuidTable(_$AiDatabase db) =>
      db.aiChatSessions.createAlias(
        $_aliasNameGenerator(
          db.aiChatMessages.sessionUuid,
          db.aiChatSessions.uuid,
        ),
      );

  $$AiChatSessionsTableProcessedTableManager get sessionUuid {
    final $_column = $_itemColumn<String>('session_uuid')!;

    final manager = $$AiChatSessionsTableTableManager(
      $_db,
      $_db.aiChatSessions,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AiApiCallsTable _apiCallUuidTable(_$AiDatabase db) =>
      db.aiApiCalls.createAlias(
        $_aliasNameGenerator(db.aiChatMessages.apiCallUuid, db.aiApiCalls.uuid),
      );

  $$AiApiCallsTableProcessedTableManager? get apiCallUuid {
    final $_column = $_itemColumn<String>('api_call_uuid');
    if ($_column == null) return null;
    final manager = $$AiApiCallsTableTableManager(
      $_db,
      $_db.aiApiCalls,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_apiCallUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AiChatMessagesTableFilterComposer
    extends Composer<_$AiDatabase, $AiChatMessagesTable> {
  $$AiChatMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequence => $composableBuilder(
    column: $table.sequence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isStreaming => $composableBuilder(
    column: $table.isStreaming,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get streamCompletedAt => $composableBuilder(
    column: $table.streamCompletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toolCallId => $composableBuilder(
    column: $table.toolCallId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toolCallsJson => $composableBuilder(
    column: $table.toolCallsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usageJson => $composableBuilder(
    column: $table.usageJson,
    builder: (column) => ColumnFilters(column),
  );

  $$AiChatSessionsTableFilterComposer get sessionUuid {
    final $$AiChatSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionUuid,
      referencedTable: $db.aiChatSessions,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatSessionsTableFilterComposer(
            $db: $db,
            $table: $db.aiChatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiApiCallsTableFilterComposer get apiCallUuid {
    final $$AiApiCallsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.apiCallUuid,
      referencedTable: $db.aiApiCalls,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiApiCallsTableFilterComposer(
            $db: $db,
            $table: $db.aiApiCalls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiChatMessagesTableOrderingComposer
    extends Composer<_$AiDatabase, $AiChatMessagesTable> {
  $$AiChatMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequence => $composableBuilder(
    column: $table.sequence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isStreaming => $composableBuilder(
    column: $table.isStreaming,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get streamCompletedAt => $composableBuilder(
    column: $table.streamCompletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toolCallId => $composableBuilder(
    column: $table.toolCallId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toolCallsJson => $composableBuilder(
    column: $table.toolCallsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usageJson => $composableBuilder(
    column: $table.usageJson,
    builder: (column) => ColumnOrderings(column),
  );

  $$AiChatSessionsTableOrderingComposer get sessionUuid {
    final $$AiChatSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionUuid,
      referencedTable: $db.aiChatSessions,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.aiChatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiApiCallsTableOrderingComposer get apiCallUuid {
    final $$AiApiCallsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.apiCallUuid,
      referencedTable: $db.aiApiCalls,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiApiCallsTableOrderingComposer(
            $db: $db,
            $table: $db.aiApiCalls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiChatMessagesTableAnnotationComposer
    extends Composer<_$AiDatabase, $AiChatMessagesTable> {
  $$AiChatMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get sequence =>
      $composableBuilder(column: $table.sequence, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isStreaming => $composableBuilder(
    column: $table.isStreaming,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get streamCompletedAt => $composableBuilder(
    column: $table.streamCompletedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toolCallId => $composableBuilder(
    column: $table.toolCallId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toolCallsJson => $composableBuilder(
    column: $table.toolCallsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usageJson =>
      $composableBuilder(column: $table.usageJson, builder: (column) => column);

  $$AiChatSessionsTableAnnotationComposer get sessionUuid {
    final $$AiChatSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionUuid,
      referencedTable: $db.aiChatSessions,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.aiChatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiApiCallsTableAnnotationComposer get apiCallUuid {
    final $$AiApiCallsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.apiCallUuid,
      referencedTable: $db.aiApiCalls,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiApiCallsTableAnnotationComposer(
            $db: $db,
            $table: $db.aiApiCalls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiChatMessagesTableTableManager
    extends
        RootTableManager<
          _$AiDatabase,
          $AiChatMessagesTable,
          AiChatMessage,
          $$AiChatMessagesTableFilterComposer,
          $$AiChatMessagesTableOrderingComposer,
          $$AiChatMessagesTableAnnotationComposer,
          $$AiChatMessagesTableCreateCompanionBuilder,
          $$AiChatMessagesTableUpdateCompanionBuilder,
          (AiChatMessage, $$AiChatMessagesTableReferences),
          AiChatMessage,
          PrefetchHooks Function({bool sessionUuid, bool apiCallUuid})
        > {
  $$AiChatMessagesTableTableManager(_$AiDatabase db, $AiChatMessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiChatMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiChatMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiChatMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uuid = const Value.absent(),
                Value<String> sessionUuid = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> sequence = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isStreaming = const Value.absent(),
                Value<DateTime?> streamCompletedAt = const Value.absent(),
                Value<String?> toolCallId = const Value.absent(),
                Value<String?> toolCallsJson = const Value.absent(),
                Value<String?> usageJson = const Value.absent(),
                Value<String?> apiCallUuid = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiChatMessagesCompanion(
                uuid: uuid,
                sessionUuid: sessionUuid,
                role: role,
                content: content,
                sequence: sequence,
                createdAt: createdAt,
                isStreaming: isStreaming,
                streamCompletedAt: streamCompletedAt,
                toolCallId: toolCallId,
                toolCallsJson: toolCallsJson,
                usageJson: usageJson,
                apiCallUuid: apiCallUuid,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uuid,
                required String sessionUuid,
                required String role,
                required String content,
                required int sequence,
                required DateTime createdAt,
                Value<bool> isStreaming = const Value.absent(),
                Value<DateTime?> streamCompletedAt = const Value.absent(),
                Value<String?> toolCallId = const Value.absent(),
                Value<String?> toolCallsJson = const Value.absent(),
                Value<String?> usageJson = const Value.absent(),
                Value<String?> apiCallUuid = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiChatMessagesCompanion.insert(
                uuid: uuid,
                sessionUuid: sessionUuid,
                role: role,
                content: content,
                sequence: sequence,
                createdAt: createdAt,
                isStreaming: isStreaming,
                streamCompletedAt: streamCompletedAt,
                toolCallId: toolCallId,
                toolCallsJson: toolCallsJson,
                usageJson: usageJson,
                apiCallUuid: apiCallUuid,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AiChatMessagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionUuid = false, apiCallUuid = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionUuid) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionUuid,
                                referencedTable: $$AiChatMessagesTableReferences
                                    ._sessionUuidTable(db),
                                referencedColumn:
                                    $$AiChatMessagesTableReferences
                                        ._sessionUuidTable(db)
                                        .uuid,
                              )
                              as T;
                    }
                    if (apiCallUuid) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.apiCallUuid,
                                referencedTable: $$AiChatMessagesTableReferences
                                    ._apiCallUuidTable(db),
                                referencedColumn:
                                    $$AiChatMessagesTableReferences
                                        ._apiCallUuidTable(db)
                                        .uuid,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AiChatMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AiDatabase,
      $AiChatMessagesTable,
      AiChatMessage,
      $$AiChatMessagesTableFilterComposer,
      $$AiChatMessagesTableOrderingComposer,
      $$AiChatMessagesTableAnnotationComposer,
      $$AiChatMessagesTableCreateCompanionBuilder,
      $$AiChatMessagesTableUpdateCompanionBuilder,
      (AiChatMessage, $$AiChatMessagesTableReferences),
      AiChatMessage,
      PrefetchHooks Function({bool sessionUuid, bool apiCallUuid})
    >;
typedef $$AiProvenancesTableCreateCompanionBuilder =
    AiProvenancesCompanion Function({
      required String uuid,
      required String provenanceType,
      required String entityUuid,
      required String entityType,
      required DateTime createdAt,
      required String contextSnapshotJson,
      required String inputSnapshotJson,
      Value<String?> outputSnapshotJson,
      Value<String?> promptVersionUuid,
      Value<String?> modelUuid,
      Value<String?> previousProvenanceUuid,
      required String integrityHash,
      Value<int> rowid,
    });
typedef $$AiProvenancesTableUpdateCompanionBuilder =
    AiProvenancesCompanion Function({
      Value<String> uuid,
      Value<String> provenanceType,
      Value<String> entityUuid,
      Value<String> entityType,
      Value<DateTime> createdAt,
      Value<String> contextSnapshotJson,
      Value<String> inputSnapshotJson,
      Value<String?> outputSnapshotJson,
      Value<String?> promptVersionUuid,
      Value<String?> modelUuid,
      Value<String?> previousProvenanceUuid,
      Value<String> integrityHash,
      Value<int> rowid,
    });

final class $$AiProvenancesTableReferences
    extends BaseReferences<_$AiDatabase, $AiProvenancesTable, AiProvenance> {
  $$AiProvenancesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$AiDivinationsTable, List<AiDivination>>
  _aiDivinationsRefsTable(_$AiDatabase db) => MultiTypedResultKey.fromTable(
    db.aiDivinations,
    aliasName: $_aliasNameGenerator(
      db.aiProvenances.uuid,
      db.aiDivinations.provenanceUuid,
    ),
  );

  $$AiDivinationsTableProcessedTableManager get aiDivinationsRefs {
    final manager = $$AiDivinationsTableTableManager($_db, $_db.aiDivinations)
        .filter(
          (f) => f.provenanceUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!),
        );

    final cache = $_typedResult.readTableOrNull(_aiDivinationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AiProvenancesTableFilterComposer
    extends Composer<_$AiDatabase, $AiProvenancesTable> {
  $$AiProvenancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provenanceType => $composableBuilder(
    column: $table.provenanceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityUuid => $composableBuilder(
    column: $table.entityUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contextSnapshotJson => $composableBuilder(
    column: $table.contextSnapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inputSnapshotJson => $composableBuilder(
    column: $table.inputSnapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outputSnapshotJson => $composableBuilder(
    column: $table.outputSnapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promptVersionUuid => $composableBuilder(
    column: $table.promptVersionUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelUuid => $composableBuilder(
    column: $table.modelUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get previousProvenanceUuid => $composableBuilder(
    column: $table.previousProvenanceUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get integrityHash => $composableBuilder(
    column: $table.integrityHash,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> aiDivinationsRefs(
    Expression<bool> Function($$AiDivinationsTableFilterComposer f) f,
  ) {
    final $$AiDivinationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiDivinations,
      getReferencedColumn: (t) => t.provenanceUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiDivinationsTableFilterComposer(
            $db: $db,
            $table: $db.aiDivinations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AiProvenancesTableOrderingComposer
    extends Composer<_$AiDatabase, $AiProvenancesTable> {
  $$AiProvenancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provenanceType => $composableBuilder(
    column: $table.provenanceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityUuid => $composableBuilder(
    column: $table.entityUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contextSnapshotJson => $composableBuilder(
    column: $table.contextSnapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inputSnapshotJson => $composableBuilder(
    column: $table.inputSnapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outputSnapshotJson => $composableBuilder(
    column: $table.outputSnapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promptVersionUuid => $composableBuilder(
    column: $table.promptVersionUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelUuid => $composableBuilder(
    column: $table.modelUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get previousProvenanceUuid => $composableBuilder(
    column: $table.previousProvenanceUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get integrityHash => $composableBuilder(
    column: $table.integrityHash,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AiProvenancesTableAnnotationComposer
    extends Composer<_$AiDatabase, $AiProvenancesTable> {
  $$AiProvenancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get provenanceType => $composableBuilder(
    column: $table.provenanceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityUuid => $composableBuilder(
    column: $table.entityUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get contextSnapshotJson => $composableBuilder(
    column: $table.contextSnapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get inputSnapshotJson => $composableBuilder(
    column: $table.inputSnapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get outputSnapshotJson => $composableBuilder(
    column: $table.outputSnapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get promptVersionUuid => $composableBuilder(
    column: $table.promptVersionUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelUuid =>
      $composableBuilder(column: $table.modelUuid, builder: (column) => column);

  GeneratedColumn<String> get previousProvenanceUuid => $composableBuilder(
    column: $table.previousProvenanceUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get integrityHash => $composableBuilder(
    column: $table.integrityHash,
    builder: (column) => column,
  );

  Expression<T> aiDivinationsRefs<T extends Object>(
    Expression<T> Function($$AiDivinationsTableAnnotationComposer a) f,
  ) {
    final $$AiDivinationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uuid,
      referencedTable: $db.aiDivinations,
      getReferencedColumn: (t) => t.provenanceUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiDivinationsTableAnnotationComposer(
            $db: $db,
            $table: $db.aiDivinations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AiProvenancesTableTableManager
    extends
        RootTableManager<
          _$AiDatabase,
          $AiProvenancesTable,
          AiProvenance,
          $$AiProvenancesTableFilterComposer,
          $$AiProvenancesTableOrderingComposer,
          $$AiProvenancesTableAnnotationComposer,
          $$AiProvenancesTableCreateCompanionBuilder,
          $$AiProvenancesTableUpdateCompanionBuilder,
          (AiProvenance, $$AiProvenancesTableReferences),
          AiProvenance,
          PrefetchHooks Function({bool aiDivinationsRefs})
        > {
  $$AiProvenancesTableTableManager(_$AiDatabase db, $AiProvenancesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiProvenancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiProvenancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiProvenancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uuid = const Value.absent(),
                Value<String> provenanceType = const Value.absent(),
                Value<String> entityUuid = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> contextSnapshotJson = const Value.absent(),
                Value<String> inputSnapshotJson = const Value.absent(),
                Value<String?> outputSnapshotJson = const Value.absent(),
                Value<String?> promptVersionUuid = const Value.absent(),
                Value<String?> modelUuid = const Value.absent(),
                Value<String?> previousProvenanceUuid = const Value.absent(),
                Value<String> integrityHash = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiProvenancesCompanion(
                uuid: uuid,
                provenanceType: provenanceType,
                entityUuid: entityUuid,
                entityType: entityType,
                createdAt: createdAt,
                contextSnapshotJson: contextSnapshotJson,
                inputSnapshotJson: inputSnapshotJson,
                outputSnapshotJson: outputSnapshotJson,
                promptVersionUuid: promptVersionUuid,
                modelUuid: modelUuid,
                previousProvenanceUuid: previousProvenanceUuid,
                integrityHash: integrityHash,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uuid,
                required String provenanceType,
                required String entityUuid,
                required String entityType,
                required DateTime createdAt,
                required String contextSnapshotJson,
                required String inputSnapshotJson,
                Value<String?> outputSnapshotJson = const Value.absent(),
                Value<String?> promptVersionUuid = const Value.absent(),
                Value<String?> modelUuid = const Value.absent(),
                Value<String?> previousProvenanceUuid = const Value.absent(),
                required String integrityHash,
                Value<int> rowid = const Value.absent(),
              }) => AiProvenancesCompanion.insert(
                uuid: uuid,
                provenanceType: provenanceType,
                entityUuid: entityUuid,
                entityType: entityType,
                createdAt: createdAt,
                contextSnapshotJson: contextSnapshotJson,
                inputSnapshotJson: inputSnapshotJson,
                outputSnapshotJson: outputSnapshotJson,
                promptVersionUuid: promptVersionUuid,
                modelUuid: modelUuid,
                previousProvenanceUuid: previousProvenanceUuid,
                integrityHash: integrityHash,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AiProvenancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({aiDivinationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (aiDivinationsRefs) db.aiDivinations,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (aiDivinationsRefs)
                    await $_getPrefetchedData<
                      AiProvenance,
                      $AiProvenancesTable,
                      AiDivination
                    >(
                      currentTable: table,
                      referencedTable: $$AiProvenancesTableReferences
                          ._aiDivinationsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AiProvenancesTableReferences(
                            db,
                            table,
                            p0,
                          ).aiDivinationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.provenanceUuid == item.uuid,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AiProvenancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AiDatabase,
      $AiProvenancesTable,
      AiProvenance,
      $$AiProvenancesTableFilterComposer,
      $$AiProvenancesTableOrderingComposer,
      $$AiProvenancesTableAnnotationComposer,
      $$AiProvenancesTableCreateCompanionBuilder,
      $$AiProvenancesTableUpdateCompanionBuilder,
      (AiProvenance, $$AiProvenancesTableReferences),
      AiProvenance,
      PrefetchHooks Function({bool aiDivinationsRefs})
    >;
typedef $$AiDivinationsTableCreateCompanionBuilder =
    AiDivinationsCompanion Function({
      required String uuid,
      required DateTime createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      required String divinationUuid,
      required String personaUuid,
      Value<String?> sessionUuid,
      required String interpretation,
      Value<String?> fortuneLevel,
      Value<String?> advice,
      Value<String> resultType,
      Value<int?> userRating,
      Value<String?> userFeedback,
      Value<String?> provenanceUuid,
      Value<int> rowid,
    });
typedef $$AiDivinationsTableUpdateCompanionBuilder =
    AiDivinationsCompanion Function({
      Value<String> uuid,
      Value<DateTime> createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      Value<String> divinationUuid,
      Value<String> personaUuid,
      Value<String?> sessionUuid,
      Value<String> interpretation,
      Value<String?> fortuneLevel,
      Value<String?> advice,
      Value<String> resultType,
      Value<int?> userRating,
      Value<String?> userFeedback,
      Value<String?> provenanceUuid,
      Value<int> rowid,
    });

final class $$AiDivinationsTableReferences
    extends BaseReferences<_$AiDatabase, $AiDivinationsTable, AiDivination> {
  $$AiDivinationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AiPersonasTable _personaUuidTable(_$AiDatabase db) =>
      db.aiPersonas.createAlias(
        $_aliasNameGenerator(db.aiDivinations.personaUuid, db.aiPersonas.uuid),
      );

  $$AiPersonasTableProcessedTableManager get personaUuid {
    final $_column = $_itemColumn<String>('persona_uuid')!;

    final manager = $$AiPersonasTableTableManager(
      $_db,
      $_db.aiPersonas,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personaUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AiChatSessionsTable _sessionUuidTable(_$AiDatabase db) =>
      db.aiChatSessions.createAlias(
        $_aliasNameGenerator(
          db.aiDivinations.sessionUuid,
          db.aiChatSessions.uuid,
        ),
      );

  $$AiChatSessionsTableProcessedTableManager? get sessionUuid {
    final $_column = $_itemColumn<String>('session_uuid');
    if ($_column == null) return null;
    final manager = $$AiChatSessionsTableTableManager(
      $_db,
      $_db.aiChatSessions,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AiProvenancesTable _provenanceUuidTable(_$AiDatabase db) =>
      db.aiProvenances.createAlias(
        $_aliasNameGenerator(
          db.aiDivinations.provenanceUuid,
          db.aiProvenances.uuid,
        ),
      );

  $$AiProvenancesTableProcessedTableManager? get provenanceUuid {
    final $_column = $_itemColumn<String>('provenance_uuid');
    if ($_column == null) return null;
    final manager = $$AiProvenancesTableTableManager(
      $_db,
      $_db.aiProvenances,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_provenanceUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AiDivinationsTableFilterComposer
    extends Composer<_$AiDatabase, $AiDivinationsTable> {
  $$AiDivinationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get divinationUuid => $composableBuilder(
    column: $table.divinationUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get interpretation => $composableBuilder(
    column: $table.interpretation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fortuneLevel => $composableBuilder(
    column: $table.fortuneLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get advice => $composableBuilder(
    column: $table.advice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resultType => $composableBuilder(
    column: $table.resultType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userRating => $composableBuilder(
    column: $table.userRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userFeedback => $composableBuilder(
    column: $table.userFeedback,
    builder: (column) => ColumnFilters(column),
  );

  $$AiPersonasTableFilterComposer get personaUuid {
    final $$AiPersonasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaUuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableFilterComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiChatSessionsTableFilterComposer get sessionUuid {
    final $$AiChatSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionUuid,
      referencedTable: $db.aiChatSessions,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatSessionsTableFilterComposer(
            $db: $db,
            $table: $db.aiChatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiProvenancesTableFilterComposer get provenanceUuid {
    final $$AiProvenancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.provenanceUuid,
      referencedTable: $db.aiProvenances,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiProvenancesTableFilterComposer(
            $db: $db,
            $table: $db.aiProvenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiDivinationsTableOrderingComposer
    extends Composer<_$AiDatabase, $AiDivinationsTable> {
  $$AiDivinationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get divinationUuid => $composableBuilder(
    column: $table.divinationUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get interpretation => $composableBuilder(
    column: $table.interpretation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fortuneLevel => $composableBuilder(
    column: $table.fortuneLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get advice => $composableBuilder(
    column: $table.advice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resultType => $composableBuilder(
    column: $table.resultType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userRating => $composableBuilder(
    column: $table.userRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userFeedback => $composableBuilder(
    column: $table.userFeedback,
    builder: (column) => ColumnOrderings(column),
  );

  $$AiPersonasTableOrderingComposer get personaUuid {
    final $$AiPersonasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaUuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableOrderingComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiChatSessionsTableOrderingComposer get sessionUuid {
    final $$AiChatSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionUuid,
      referencedTable: $db.aiChatSessions,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.aiChatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiProvenancesTableOrderingComposer get provenanceUuid {
    final $$AiProvenancesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.provenanceUuid,
      referencedTable: $db.aiProvenances,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiProvenancesTableOrderingComposer(
            $db: $db,
            $table: $db.aiProvenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiDivinationsTableAnnotationComposer
    extends Composer<_$AiDatabase, $AiDivinationsTable> {
  $$AiDivinationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get divinationUuid => $composableBuilder(
    column: $table.divinationUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get interpretation => $composableBuilder(
    column: $table.interpretation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fortuneLevel => $composableBuilder(
    column: $table.fortuneLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get advice =>
      $composableBuilder(column: $table.advice, builder: (column) => column);

  GeneratedColumn<String> get resultType => $composableBuilder(
    column: $table.resultType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get userRating => $composableBuilder(
    column: $table.userRating,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userFeedback => $composableBuilder(
    column: $table.userFeedback,
    builder: (column) => column,
  );

  $$AiPersonasTableAnnotationComposer get personaUuid {
    final $$AiPersonasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaUuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableAnnotationComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiChatSessionsTableAnnotationComposer get sessionUuid {
    final $$AiChatSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionUuid,
      referencedTable: $db.aiChatSessions,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.aiChatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiProvenancesTableAnnotationComposer get provenanceUuid {
    final $$AiProvenancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.provenanceUuid,
      referencedTable: $db.aiProvenances,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiProvenancesTableAnnotationComposer(
            $db: $db,
            $table: $db.aiProvenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiDivinationsTableTableManager
    extends
        RootTableManager<
          _$AiDatabase,
          $AiDivinationsTable,
          AiDivination,
          $$AiDivinationsTableFilterComposer,
          $$AiDivinationsTableOrderingComposer,
          $$AiDivinationsTableAnnotationComposer,
          $$AiDivinationsTableCreateCompanionBuilder,
          $$AiDivinationsTableUpdateCompanionBuilder,
          (AiDivination, $$AiDivinationsTableReferences),
          AiDivination,
          PrefetchHooks Function({
            bool personaUuid,
            bool sessionUuid,
            bool provenanceUuid,
          })
        > {
  $$AiDivinationsTableTableManager(_$AiDatabase db, $AiDivinationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiDivinationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiDivinationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiDivinationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uuid = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> divinationUuid = const Value.absent(),
                Value<String> personaUuid = const Value.absent(),
                Value<String?> sessionUuid = const Value.absent(),
                Value<String> interpretation = const Value.absent(),
                Value<String?> fortuneLevel = const Value.absent(),
                Value<String?> advice = const Value.absent(),
                Value<String> resultType = const Value.absent(),
                Value<int?> userRating = const Value.absent(),
                Value<String?> userFeedback = const Value.absent(),
                Value<String?> provenanceUuid = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiDivinationsCompanion(
                uuid: uuid,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                divinationUuid: divinationUuid,
                personaUuid: personaUuid,
                sessionUuid: sessionUuid,
                interpretation: interpretation,
                fortuneLevel: fortuneLevel,
                advice: advice,
                resultType: resultType,
                userRating: userRating,
                userFeedback: userFeedback,
                provenanceUuid: provenanceUuid,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uuid,
                required DateTime createdAt,
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String divinationUuid,
                required String personaUuid,
                Value<String?> sessionUuid = const Value.absent(),
                required String interpretation,
                Value<String?> fortuneLevel = const Value.absent(),
                Value<String?> advice = const Value.absent(),
                Value<String> resultType = const Value.absent(),
                Value<int?> userRating = const Value.absent(),
                Value<String?> userFeedback = const Value.absent(),
                Value<String?> provenanceUuid = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiDivinationsCompanion.insert(
                uuid: uuid,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                divinationUuid: divinationUuid,
                personaUuid: personaUuid,
                sessionUuid: sessionUuid,
                interpretation: interpretation,
                fortuneLevel: fortuneLevel,
                advice: advice,
                resultType: resultType,
                userRating: userRating,
                userFeedback: userFeedback,
                provenanceUuid: provenanceUuid,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AiDivinationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                personaUuid = false,
                sessionUuid = false,
                provenanceUuid = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (personaUuid) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.personaUuid,
                                    referencedTable:
                                        $$AiDivinationsTableReferences
                                            ._personaUuidTable(db),
                                    referencedColumn:
                                        $$AiDivinationsTableReferences
                                            ._personaUuidTable(db)
                                            .uuid,
                                  )
                                  as T;
                        }
                        if (sessionUuid) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sessionUuid,
                                    referencedTable:
                                        $$AiDivinationsTableReferences
                                            ._sessionUuidTable(db),
                                    referencedColumn:
                                        $$AiDivinationsTableReferences
                                            ._sessionUuidTable(db)
                                            .uuid,
                                  )
                                  as T;
                        }
                        if (provenanceUuid) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.provenanceUuid,
                                    referencedTable:
                                        $$AiDivinationsTableReferences
                                            ._provenanceUuidTable(db),
                                    referencedColumn:
                                        $$AiDivinationsTableReferences
                                            ._provenanceUuidTable(db)
                                            .uuid,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$AiDivinationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AiDatabase,
      $AiDivinationsTable,
      AiDivination,
      $$AiDivinationsTableFilterComposer,
      $$AiDivinationsTableOrderingComposer,
      $$AiDivinationsTableAnnotationComposer,
      $$AiDivinationsTableCreateCompanionBuilder,
      $$AiDivinationsTableUpdateCompanionBuilder,
      (AiDivination, $$AiDivinationsTableReferences),
      AiDivination,
      PrefetchHooks Function({
        bool personaUuid,
        bool sessionUuid,
        bool provenanceUuid,
      })
    >;
typedef $$AgentInvocationsTableCreateCompanionBuilder =
    AgentInvocationsCompanion Function({
      required String uuid,
      required String callerPersonaUuid,
      required String calleePersonaUuid,
      Value<String?> sessionUuid,
      required DateTime invokedAt,
      Value<DateTime?> completedAt,
      required String purpose,
      Value<String?> sharedContextJson,
      Value<String?> resultJson,
      Value<String> status,
      Value<String?> errorMessage,
      Value<String?> parentInvocationUuid,
      Value<int> depth,
      Value<int> rowid,
    });
typedef $$AgentInvocationsTableUpdateCompanionBuilder =
    AgentInvocationsCompanion Function({
      Value<String> uuid,
      Value<String> callerPersonaUuid,
      Value<String> calleePersonaUuid,
      Value<String?> sessionUuid,
      Value<DateTime> invokedAt,
      Value<DateTime?> completedAt,
      Value<String> purpose,
      Value<String?> sharedContextJson,
      Value<String?> resultJson,
      Value<String> status,
      Value<String?> errorMessage,
      Value<String?> parentInvocationUuid,
      Value<int> depth,
      Value<int> rowid,
    });

final class $$AgentInvocationsTableReferences
    extends
        BaseReferences<_$AiDatabase, $AgentInvocationsTable, AgentInvocation> {
  $$AgentInvocationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AiPersonasTable _callerPersonaUuidTable(_$AiDatabase db) =>
      db.aiPersonas.createAlias(
        $_aliasNameGenerator(
          db.agentInvocations.callerPersonaUuid,
          db.aiPersonas.uuid,
        ),
      );

  $$AiPersonasTableProcessedTableManager get callerPersonaUuid {
    final $_column = $_itemColumn<String>('caller_persona_uuid')!;

    final manager = $$AiPersonasTableTableManager(
      $_db,
      $_db.aiPersonas,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_callerPersonaUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AiPersonasTable _calleePersonaUuidTable(_$AiDatabase db) =>
      db.aiPersonas.createAlias(
        $_aliasNameGenerator(
          db.agentInvocations.calleePersonaUuid,
          db.aiPersonas.uuid,
        ),
      );

  $$AiPersonasTableProcessedTableManager get calleePersonaUuid {
    final $_column = $_itemColumn<String>('callee_persona_uuid')!;

    final manager = $$AiPersonasTableTableManager(
      $_db,
      $_db.aiPersonas,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_calleePersonaUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AiChatSessionsTable _sessionUuidTable(_$AiDatabase db) =>
      db.aiChatSessions.createAlias(
        $_aliasNameGenerator(
          db.agentInvocations.sessionUuid,
          db.aiChatSessions.uuid,
        ),
      );

  $$AiChatSessionsTableProcessedTableManager? get sessionUuid {
    final $_column = $_itemColumn<String>('session_uuid');
    if ($_column == null) return null;
    final manager = $$AiChatSessionsTableTableManager(
      $_db,
      $_db.aiChatSessions,
    ).filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AgentInvocationsTableFilterComposer
    extends Composer<_$AiDatabase, $AgentInvocationsTable> {
  $$AgentInvocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get invokedAt => $composableBuilder(
    column: $table.invokedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purpose => $composableBuilder(
    column: $table.purpose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sharedContextJson => $composableBuilder(
    column: $table.sharedContextJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentInvocationUuid => $composableBuilder(
    column: $table.parentInvocationUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get depth => $composableBuilder(
    column: $table.depth,
    builder: (column) => ColumnFilters(column),
  );

  $$AiPersonasTableFilterComposer get callerPersonaUuid {
    final $$AiPersonasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.callerPersonaUuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableFilterComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiPersonasTableFilterComposer get calleePersonaUuid {
    final $$AiPersonasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.calleePersonaUuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableFilterComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiChatSessionsTableFilterComposer get sessionUuid {
    final $$AiChatSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionUuid,
      referencedTable: $db.aiChatSessions,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatSessionsTableFilterComposer(
            $db: $db,
            $table: $db.aiChatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AgentInvocationsTableOrderingComposer
    extends Composer<_$AiDatabase, $AgentInvocationsTable> {
  $$AgentInvocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get invokedAt => $composableBuilder(
    column: $table.invokedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purpose => $composableBuilder(
    column: $table.purpose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sharedContextJson => $composableBuilder(
    column: $table.sharedContextJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentInvocationUuid => $composableBuilder(
    column: $table.parentInvocationUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get depth => $composableBuilder(
    column: $table.depth,
    builder: (column) => ColumnOrderings(column),
  );

  $$AiPersonasTableOrderingComposer get callerPersonaUuid {
    final $$AiPersonasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.callerPersonaUuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableOrderingComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiPersonasTableOrderingComposer get calleePersonaUuid {
    final $$AiPersonasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.calleePersonaUuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableOrderingComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiChatSessionsTableOrderingComposer get sessionUuid {
    final $$AiChatSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionUuid,
      referencedTable: $db.aiChatSessions,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.aiChatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AgentInvocationsTableAnnotationComposer
    extends Composer<_$AiDatabase, $AgentInvocationsTable> {
  $$AgentInvocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get invokedAt =>
      $composableBuilder(column: $table.invokedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get purpose =>
      $composableBuilder(column: $table.purpose, builder: (column) => column);

  GeneratedColumn<String> get sharedContextJson => $composableBuilder(
    column: $table.sharedContextJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parentInvocationUuid => $composableBuilder(
    column: $table.parentInvocationUuid,
    builder: (column) => column,
  );

  GeneratedColumn<int> get depth =>
      $composableBuilder(column: $table.depth, builder: (column) => column);

  $$AiPersonasTableAnnotationComposer get callerPersonaUuid {
    final $$AiPersonasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.callerPersonaUuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableAnnotationComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiPersonasTableAnnotationComposer get calleePersonaUuid {
    final $$AiPersonasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.calleePersonaUuid,
      referencedTable: $db.aiPersonas,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiPersonasTableAnnotationComposer(
            $db: $db,
            $table: $db.aiPersonas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AiChatSessionsTableAnnotationComposer get sessionUuid {
    final $$AiChatSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionUuid,
      referencedTable: $db.aiChatSessions,
      getReferencedColumn: (t) => t.uuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiChatSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.aiChatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AgentInvocationsTableTableManager
    extends
        RootTableManager<
          _$AiDatabase,
          $AgentInvocationsTable,
          AgentInvocation,
          $$AgentInvocationsTableFilterComposer,
          $$AgentInvocationsTableOrderingComposer,
          $$AgentInvocationsTableAnnotationComposer,
          $$AgentInvocationsTableCreateCompanionBuilder,
          $$AgentInvocationsTableUpdateCompanionBuilder,
          (AgentInvocation, $$AgentInvocationsTableReferences),
          AgentInvocation,
          PrefetchHooks Function({
            bool callerPersonaUuid,
            bool calleePersonaUuid,
            bool sessionUuid,
          })
        > {
  $$AgentInvocationsTableTableManager(
    _$AiDatabase db,
    $AgentInvocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgentInvocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgentInvocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgentInvocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uuid = const Value.absent(),
                Value<String> callerPersonaUuid = const Value.absent(),
                Value<String> calleePersonaUuid = const Value.absent(),
                Value<String?> sessionUuid = const Value.absent(),
                Value<DateTime> invokedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> purpose = const Value.absent(),
                Value<String?> sharedContextJson = const Value.absent(),
                Value<String?> resultJson = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<String?> parentInvocationUuid = const Value.absent(),
                Value<int> depth = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AgentInvocationsCompanion(
                uuid: uuid,
                callerPersonaUuid: callerPersonaUuid,
                calleePersonaUuid: calleePersonaUuid,
                sessionUuid: sessionUuid,
                invokedAt: invokedAt,
                completedAt: completedAt,
                purpose: purpose,
                sharedContextJson: sharedContextJson,
                resultJson: resultJson,
                status: status,
                errorMessage: errorMessage,
                parentInvocationUuid: parentInvocationUuid,
                depth: depth,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uuid,
                required String callerPersonaUuid,
                required String calleePersonaUuid,
                Value<String?> sessionUuid = const Value.absent(),
                required DateTime invokedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                required String purpose,
                Value<String?> sharedContextJson = const Value.absent(),
                Value<String?> resultJson = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<String?> parentInvocationUuid = const Value.absent(),
                Value<int> depth = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AgentInvocationsCompanion.insert(
                uuid: uuid,
                callerPersonaUuid: callerPersonaUuid,
                calleePersonaUuid: calleePersonaUuid,
                sessionUuid: sessionUuid,
                invokedAt: invokedAt,
                completedAt: completedAt,
                purpose: purpose,
                sharedContextJson: sharedContextJson,
                resultJson: resultJson,
                status: status,
                errorMessage: errorMessage,
                parentInvocationUuid: parentInvocationUuid,
                depth: depth,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AgentInvocationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                callerPersonaUuid = false,
                calleePersonaUuid = false,
                sessionUuid = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (callerPersonaUuid) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.callerPersonaUuid,
                                    referencedTable:
                                        $$AgentInvocationsTableReferences
                                            ._callerPersonaUuidTable(db),
                                    referencedColumn:
                                        $$AgentInvocationsTableReferences
                                            ._callerPersonaUuidTable(db)
                                            .uuid,
                                  )
                                  as T;
                        }
                        if (calleePersonaUuid) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.calleePersonaUuid,
                                    referencedTable:
                                        $$AgentInvocationsTableReferences
                                            ._calleePersonaUuidTable(db),
                                    referencedColumn:
                                        $$AgentInvocationsTableReferences
                                            ._calleePersonaUuidTable(db)
                                            .uuid,
                                  )
                                  as T;
                        }
                        if (sessionUuid) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sessionUuid,
                                    referencedTable:
                                        $$AgentInvocationsTableReferences
                                            ._sessionUuidTable(db),
                                    referencedColumn:
                                        $$AgentInvocationsTableReferences
                                            ._sessionUuidTable(db)
                                            .uuid,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$AgentInvocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AiDatabase,
      $AgentInvocationsTable,
      AgentInvocation,
      $$AgentInvocationsTableFilterComposer,
      $$AgentInvocationsTableOrderingComposer,
      $$AgentInvocationsTableAnnotationComposer,
      $$AgentInvocationsTableCreateCompanionBuilder,
      $$AgentInvocationsTableUpdateCompanionBuilder,
      (AgentInvocation, $$AgentInvocationsTableReferences),
      AgentInvocation,
      PrefetchHooks Function({
        bool callerPersonaUuid,
        bool calleePersonaUuid,
        bool sessionUuid,
      })
    >;
typedef $$AiUsageAuditsTableCreateCompanionBuilder =
    AiUsageAuditsCompanion Function({
      Value<int> id,
      required DateTime auditedAt,
      required String auditType,
      Value<String?> entityUuid,
      Value<String?> entityType,
      Value<String?> userIdentifier,
      required String action,
      Value<String?> detailsJson,
      Value<int?> tokensUsed,
      Value<double?> estimatedCost,
      Value<String?> ipAddress,
      Value<String?> deviceInfo,
    });
typedef $$AiUsageAuditsTableUpdateCompanionBuilder =
    AiUsageAuditsCompanion Function({
      Value<int> id,
      Value<DateTime> auditedAt,
      Value<String> auditType,
      Value<String?> entityUuid,
      Value<String?> entityType,
      Value<String?> userIdentifier,
      Value<String> action,
      Value<String?> detailsJson,
      Value<int?> tokensUsed,
      Value<double?> estimatedCost,
      Value<String?> ipAddress,
      Value<String?> deviceInfo,
    });

class $$AiUsageAuditsTableFilterComposer
    extends Composer<_$AiDatabase, $AiUsageAuditsTable> {
  $$AiUsageAuditsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get auditedAt => $composableBuilder(
    column: $table.auditedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get auditType => $composableBuilder(
    column: $table.auditType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityUuid => $composableBuilder(
    column: $table.entityUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userIdentifier => $composableBuilder(
    column: $table.userIdentifier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detailsJson => $composableBuilder(
    column: $table.detailsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tokensUsed => $composableBuilder(
    column: $table.tokensUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ipAddress => $composableBuilder(
    column: $table.ipAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceInfo => $composableBuilder(
    column: $table.deviceInfo,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AiUsageAuditsTableOrderingComposer
    extends Composer<_$AiDatabase, $AiUsageAuditsTable> {
  $$AiUsageAuditsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get auditedAt => $composableBuilder(
    column: $table.auditedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get auditType => $composableBuilder(
    column: $table.auditType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityUuid => $composableBuilder(
    column: $table.entityUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userIdentifier => $composableBuilder(
    column: $table.userIdentifier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detailsJson => $composableBuilder(
    column: $table.detailsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tokensUsed => $composableBuilder(
    column: $table.tokensUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ipAddress => $composableBuilder(
    column: $table.ipAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceInfo => $composableBuilder(
    column: $table.deviceInfo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AiUsageAuditsTableAnnotationComposer
    extends Composer<_$AiDatabase, $AiUsageAuditsTable> {
  $$AiUsageAuditsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get auditedAt =>
      $composableBuilder(column: $table.auditedAt, builder: (column) => column);

  GeneratedColumn<String> get auditType =>
      $composableBuilder(column: $table.auditType, builder: (column) => column);

  GeneratedColumn<String> get entityUuid => $composableBuilder(
    column: $table.entityUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userIdentifier => $composableBuilder(
    column: $table.userIdentifier,
    builder: (column) => column,
  );

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get detailsJson => $composableBuilder(
    column: $table.detailsJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tokensUsed => $composableBuilder(
    column: $table.tokensUsed,
    builder: (column) => column,
  );

  GeneratedColumn<double> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ipAddress =>
      $composableBuilder(column: $table.ipAddress, builder: (column) => column);

  GeneratedColumn<String> get deviceInfo => $composableBuilder(
    column: $table.deviceInfo,
    builder: (column) => column,
  );
}

class $$AiUsageAuditsTableTableManager
    extends
        RootTableManager<
          _$AiDatabase,
          $AiUsageAuditsTable,
          AiUsageAudit,
          $$AiUsageAuditsTableFilterComposer,
          $$AiUsageAuditsTableOrderingComposer,
          $$AiUsageAuditsTableAnnotationComposer,
          $$AiUsageAuditsTableCreateCompanionBuilder,
          $$AiUsageAuditsTableUpdateCompanionBuilder,
          (
            AiUsageAudit,
            BaseReferences<_$AiDatabase, $AiUsageAuditsTable, AiUsageAudit>,
          ),
          AiUsageAudit,
          PrefetchHooks Function()
        > {
  $$AiUsageAuditsTableTableManager(_$AiDatabase db, $AiUsageAuditsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiUsageAuditsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiUsageAuditsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiUsageAuditsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> auditedAt = const Value.absent(),
                Value<String> auditType = const Value.absent(),
                Value<String?> entityUuid = const Value.absent(),
                Value<String?> entityType = const Value.absent(),
                Value<String?> userIdentifier = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String?> detailsJson = const Value.absent(),
                Value<int?> tokensUsed = const Value.absent(),
                Value<double?> estimatedCost = const Value.absent(),
                Value<String?> ipAddress = const Value.absent(),
                Value<String?> deviceInfo = const Value.absent(),
              }) => AiUsageAuditsCompanion(
                id: id,
                auditedAt: auditedAt,
                auditType: auditType,
                entityUuid: entityUuid,
                entityType: entityType,
                userIdentifier: userIdentifier,
                action: action,
                detailsJson: detailsJson,
                tokensUsed: tokensUsed,
                estimatedCost: estimatedCost,
                ipAddress: ipAddress,
                deviceInfo: deviceInfo,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime auditedAt,
                required String auditType,
                Value<String?> entityUuid = const Value.absent(),
                Value<String?> entityType = const Value.absent(),
                Value<String?> userIdentifier = const Value.absent(),
                required String action,
                Value<String?> detailsJson = const Value.absent(),
                Value<int?> tokensUsed = const Value.absent(),
                Value<double?> estimatedCost = const Value.absent(),
                Value<String?> ipAddress = const Value.absent(),
                Value<String?> deviceInfo = const Value.absent(),
              }) => AiUsageAuditsCompanion.insert(
                id: id,
                auditedAt: auditedAt,
                auditType: auditType,
                entityUuid: entityUuid,
                entityType: entityType,
                userIdentifier: userIdentifier,
                action: action,
                detailsJson: detailsJson,
                tokensUsed: tokensUsed,
                estimatedCost: estimatedCost,
                ipAddress: ipAddress,
                deviceInfo: deviceInfo,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AiUsageAuditsTableProcessedTableManager =
    ProcessedTableManager<
      _$AiDatabase,
      $AiUsageAuditsTable,
      AiUsageAudit,
      $$AiUsageAuditsTableFilterComposer,
      $$AiUsageAuditsTableOrderingComposer,
      $$AiUsageAuditsTableAnnotationComposer,
      $$AiUsageAuditsTableCreateCompanionBuilder,
      $$AiUsageAuditsTableUpdateCompanionBuilder,
      (
        AiUsageAudit,
        BaseReferences<_$AiDatabase, $AiUsageAuditsTable, AiUsageAudit>,
      ),
      AiUsageAudit,
      PrefetchHooks Function()
    >;
typedef $$AiToolsTableCreateCompanionBuilder =
    AiToolsCompanion Function({
      required String uuid,
      required DateTime createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      required String name,
      required String description,
      required String toolType,
      Value<int?> skillId,
      required String parametersSchemaJson,
      Value<String?> returnSchemaJson,
      Value<bool> requiresConfirmation,
      Value<bool> isEnabled,
      Value<String> executorType,
      Value<String?> executorConfigJson,
      Value<int> rowid,
    });
typedef $$AiToolsTableUpdateCompanionBuilder =
    AiToolsCompanion Function({
      Value<String> uuid,
      Value<DateTime> createdAt,
      Value<DateTime?> lastUpdatedAt,
      Value<DateTime?> deletedAt,
      Value<String> name,
      Value<String> description,
      Value<String> toolType,
      Value<int?> skillId,
      Value<String> parametersSchemaJson,
      Value<String?> returnSchemaJson,
      Value<bool> requiresConfirmation,
      Value<bool> isEnabled,
      Value<String> executorType,
      Value<String?> executorConfigJson,
      Value<int> rowid,
    });

class $$AiToolsTableFilterComposer
    extends Composer<_$AiDatabase, $AiToolsTable> {
  $$AiToolsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toolType => $composableBuilder(
    column: $table.toolType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get skillId => $composableBuilder(
    column: $table.skillId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parametersSchemaJson => $composableBuilder(
    column: $table.parametersSchemaJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get returnSchemaJson => $composableBuilder(
    column: $table.returnSchemaJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiresConfirmation => $composableBuilder(
    column: $table.requiresConfirmation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get executorType => $composableBuilder(
    column: $table.executorType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get executorConfigJson => $composableBuilder(
    column: $table.executorConfigJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AiToolsTableOrderingComposer
    extends Composer<_$AiDatabase, $AiToolsTable> {
  $$AiToolsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toolType => $composableBuilder(
    column: $table.toolType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get skillId => $composableBuilder(
    column: $table.skillId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parametersSchemaJson => $composableBuilder(
    column: $table.parametersSchemaJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get returnSchemaJson => $composableBuilder(
    column: $table.returnSchemaJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiresConfirmation => $composableBuilder(
    column: $table.requiresConfirmation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get executorType => $composableBuilder(
    column: $table.executorType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get executorConfigJson => $composableBuilder(
    column: $table.executorConfigJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AiToolsTableAnnotationComposer
    extends Composer<_$AiDatabase, $AiToolsTable> {
  $$AiToolsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toolType =>
      $composableBuilder(column: $table.toolType, builder: (column) => column);

  GeneratedColumn<int> get skillId =>
      $composableBuilder(column: $table.skillId, builder: (column) => column);

  GeneratedColumn<String> get parametersSchemaJson => $composableBuilder(
    column: $table.parametersSchemaJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get returnSchemaJson => $composableBuilder(
    column: $table.returnSchemaJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get requiresConfirmation => $composableBuilder(
    column: $table.requiresConfirmation,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get executorType => $composableBuilder(
    column: $table.executorType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get executorConfigJson => $composableBuilder(
    column: $table.executorConfigJson,
    builder: (column) => column,
  );
}

class $$AiToolsTableTableManager
    extends
        RootTableManager<
          _$AiDatabase,
          $AiToolsTable,
          AiTool,
          $$AiToolsTableFilterComposer,
          $$AiToolsTableOrderingComposer,
          $$AiToolsTableAnnotationComposer,
          $$AiToolsTableCreateCompanionBuilder,
          $$AiToolsTableUpdateCompanionBuilder,
          (AiTool, BaseReferences<_$AiDatabase, $AiToolsTable, AiTool>),
          AiTool,
          PrefetchHooks Function()
        > {
  $$AiToolsTableTableManager(_$AiDatabase db, $AiToolsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiToolsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiToolsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiToolsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uuid = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> toolType = const Value.absent(),
                Value<int?> skillId = const Value.absent(),
                Value<String> parametersSchemaJson = const Value.absent(),
                Value<String?> returnSchemaJson = const Value.absent(),
                Value<bool> requiresConfirmation = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String> executorType = const Value.absent(),
                Value<String?> executorConfigJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiToolsCompanion(
                uuid: uuid,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                name: name,
                description: description,
                toolType: toolType,
                skillId: skillId,
                parametersSchemaJson: parametersSchemaJson,
                returnSchemaJson: returnSchemaJson,
                requiresConfirmation: requiresConfirmation,
                isEnabled: isEnabled,
                executorType: executorType,
                executorConfigJson: executorConfigJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uuid,
                required DateTime createdAt,
                Value<DateTime?> lastUpdatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String name,
                required String description,
                required String toolType,
                Value<int?> skillId = const Value.absent(),
                required String parametersSchemaJson,
                Value<String?> returnSchemaJson = const Value.absent(),
                Value<bool> requiresConfirmation = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String> executorType = const Value.absent(),
                Value<String?> executorConfigJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiToolsCompanion.insert(
                uuid: uuid,
                createdAt: createdAt,
                lastUpdatedAt: lastUpdatedAt,
                deletedAt: deletedAt,
                name: name,
                description: description,
                toolType: toolType,
                skillId: skillId,
                parametersSchemaJson: parametersSchemaJson,
                returnSchemaJson: returnSchemaJson,
                requiresConfirmation: requiresConfirmation,
                isEnabled: isEnabled,
                executorType: executorType,
                executorConfigJson: executorConfigJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AiToolsTableProcessedTableManager =
    ProcessedTableManager<
      _$AiDatabase,
      $AiToolsTable,
      AiTool,
      $$AiToolsTableFilterComposer,
      $$AiToolsTableOrderingComposer,
      $$AiToolsTableAnnotationComposer,
      $$AiToolsTableCreateCompanionBuilder,
      $$AiToolsTableUpdateCompanionBuilder,
      (AiTool, BaseReferences<_$AiDatabase, $AiToolsTable, AiTool>),
      AiTool,
      PrefetchHooks Function()
    >;

class $AiDatabaseManager {
  final _$AiDatabase _db;
  $AiDatabaseManager(this._db);
  $$LlmProvidersTableTableManager get llmProviders =>
      $$LlmProvidersTableTableManager(_db, _db.llmProviders);
  $$LlmModelsTableTableManager get llmModels =>
      $$LlmModelsTableTableManager(_db, _db.llmModels);
  $$PromptTemplatesTableTableManager get promptTemplates =>
      $$PromptTemplatesTableTableManager(_db, _db.promptTemplates);
  $$PromptVersionsTableTableManager get promptVersions =>
      $$PromptVersionsTableTableManager(_db, _db.promptVersions);
  $$PromptSkillBindingsTableTableManager get promptSkillBindings =>
      $$PromptSkillBindingsTableTableManager(_db, _db.promptSkillBindings);
  $$AiPersonasTableTableManager get aiPersonas =>
      $$AiPersonasTableTableManager(_db, _db.aiPersonas);
  $$AiChatSessionsTableTableManager get aiChatSessions =>
      $$AiChatSessionsTableTableManager(_db, _db.aiChatSessions);
  $$AiApiCallsTableTableManager get aiApiCalls =>
      $$AiApiCallsTableTableManager(_db, _db.aiApiCalls);
  $$AiChatMessagesTableTableManager get aiChatMessages =>
      $$AiChatMessagesTableTableManager(_db, _db.aiChatMessages);
  $$AiProvenancesTableTableManager get aiProvenances =>
      $$AiProvenancesTableTableManager(_db, _db.aiProvenances);
  $$AiDivinationsTableTableManager get aiDivinations =>
      $$AiDivinationsTableTableManager(_db, _db.aiDivinations);
  $$AgentInvocationsTableTableManager get agentInvocations =>
      $$AgentInvocationsTableTableManager(_db, _db.agentInvocations);
  $$AiUsageAuditsTableTableManager get aiUsageAudits =>
      $$AiUsageAuditsTableTableManager(_db, _db.aiUsageAudits);
  $$AiToolsTableTableManager get aiTools =>
      $$AiToolsTableTableManager(_db, _db.aiTools);
}
