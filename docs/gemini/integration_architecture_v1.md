# 玄学模块与 AI 集成架构设计 (v1)

本文档详细描述了如何将 `xuan-qimendunjia`, `xuan-taiyishenshu` 等业务模块与 `xuan-ai` 模块进行解耦集成。核心目标是实现 **高内聚（High Cohesion）** 与 **低耦合（Low Coupling）**，并支持“模块携带上下文唤起 AI”的场景。

## 1. 核心架构原则：依赖倒置 (DIP)

传统架构可能是 AI 模块依赖各个业务模块（`xuan-ai` -> `xuan-qimen`），这会导致循环依赖或高耦合。
我们采用 **依赖倒置**：

1. 定义统一的 **抽象协议接口** 于基础层 (`xuan-common`)。
2. `xuan-ai` 模块 **实现** 该接口（作为服务提供者）。
3. 业务模块（如 `xuan-qimen`） **调用** 该接口（作为服务消费者）。
4. 所有模块都只依赖 `xuan-common`，互不依赖。

---

## 2. 接口定义 (`xuan-common`)

在 `xuan-common` 中定义 AI 服务的能力标准和数据传输协议。

### 2.1 数据模型 (`lib/domain/ai/ai_context.dart`)

定义“上下文”的标准格式。这是业务模块向 AI 传递数据的载体。

```dart
/// AI 上下文实体：描述一个具体的业务对象（如一个奇门局）
class AiEntity {
  final String id;
  final String type;          // 类型标识，如 "qimen_pan", "bazi_chart"
  final String name;          // 人类可读名称，如 "阳遁五局"
  final String description;   // 【关键】自然语言描述。这是直接喂给 LLM 的文本。
                              // 业务模块负责生成："此时为阳遁五局，甲子戊在坎宫..."
  final Map<String, dynamic>? rawData; // 原始结构化数据（JSON），供 AI 工具（Function Call）使用

  AiEntity({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    this.rawData,
  });
}

/// AI 上下文容器：包含一次交互的所有背景信息
class AiContext {
  final String intention;     // 用户意图，如 "分析这个局"
  final List<AiEntity> entities; // 附带的实体列表
  final String? systemPromptOverride; // 可选：覆盖系统提示词（慎用）

  AiContext({
    required this.intention,
    this.entities = const [],
    this.systemPromptOverride,
  });
}
```

### 2.2 服务接口 (`lib/services/ai_service.dart`)

定义 AI 模块对外提供的能力。

```dart
import 'package:flutter/widgets.dart';
import '../domain/ai/ai_context.dart';

abstract class AiService {
  /// 打开 AI 聊天窗口
  ///
  /// [context]: Flutter BuildContext，用于导航（弹窗/跳转）。
  /// [initialContext]: 初始上下文数据。如果非空，AI 会在开启时自动加载这些数据。
  Future<void> openChat({
    required BuildContext context,
    AiContext? initialContext,
  });

  /// 仅发送数据给 AI（静默处理或后台分析），不打开界面
  Future<String> analyze({
    required AiContext context,
  });
}
```

---

## 3. 服务实现 (`xuan-ai`)

`xuan-ai` 模块负责实现上述接口。它不需要知道 `xuan-qimen` 的存在，只需要处理 `AiContext`。

### 3.1 `AiServiceImpl`

```dart
import 'package:xuan_common/services/ai_service.dart';
import 'package:xuan_common/domain/ai/ai_context.dart';
import '.../ui/ai_chat_page.dart';

class AiServiceImpl implements AiService {
  @override
  Future<void> openChat({
    required BuildContext context,
    AiContext? initialContext,
  }) async {
    // 1. 构建初始消息
    String? startMessage;
    if (initialContext != null) {
      // 将结构化的 AiEntity 转换为 LLM 的 Prompt
      final buffer = StringBuffer();
      buffer.writeln("用户意图：${initialContext.intention}");
      buffer.writeln("当前上下文信息：");
      for (final entity in initialContext.entities) {
        buffer.writeln("- [${entity.name}]: ${entity.description}");
      }
      startMessage = buffer.toString();
    }
    
    // 2. 导航到聊天页面，并传入初始消息
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AiChatPage(
          initialMessage: startMessage,
          // 也可以将 entities 存入 session，供后续 Function Call 查询
          attachedEntities: initialContext?.entities, 
        ),
      ),
    );
  }
  
  @override
  Future<String> analyze({required AiContext context}) async {
    // ... 实现后台分析逻辑
  }
}
```

---

## 4. 服务消费者 (`xuan-qimendunjia` 等)

业务模块通过统一接口调用 AI，完全解耦。

### 4.1 场景：在奇门排盘结果页唤起 AI

```dart
// 在 xuan-qimendunjia 模块的 ResultPage 中

void _onAskAiPressed(BuildContext context) {
  // 1. 获取当前业务数据（Domain Object）
  final QimenJu currentJu = this.layoutData;

  // 2. 转换为 AI 实体 (Transform)
  // 这是关键步骤：业务模块自己最懂如何描述自己
  final qimenEntity = AiEntity(
    id: currentJu.id,
    type: 'qimen_pan',
    name: '${currentJu.dunjiaType} ${currentJu.juName}',
    // description 是给 LLM 读的自然语言
    description: "当前为${currentJu.timeString}，${currentJu.dunjiaType}。值符为${currentJu.zhifu}，落${currentJu.zhifuGong}宫...", 
    rawData: currentJu.toJson(), // 结构化数据
  );

  // 3. 组装上下文
  final aiContext = AiContext(
    intention: "请结合当前局势，分析用户的财运。",
    entities: [qimenEntity],
  );

  // 4. 调用服务 (Service Locator / Provider)
  // 假设使用 get_it 或类似的定位器
  final aiService = GetIt.I<AiService>(); 
  aiService.openChat(
    context: context,
    initialContext: aiContext,
  );
}
```

---

## 5. 依赖注入 (Dependency Injection)

在 App 的入口层（通常是 `example/lib/main.dart` 或 `lib/app_dependencies.dart`）进行“连线”。只有这一层知道所有的具体实现类。

```dart
// 在 App 初始化时
void setupLocator() {
  final locator = GetIt.instance;

  // 注册 xuan-ai 的实现
  locator.registerLazySingleton<AiService>(() => AiServiceImpl());
  
  // 注册其他服务...
}
```

---

## 6. 用户界面与配置 (User Interface & Configuration)

为了保持子模块的纯粹性，**配置 AI（选择 Persona/Model）** 的 UI 不应由子模块实现，而是由 `xuan-ai` 提供通用面板，子模块只负责唤起。

### 6.1 接口扩展 (`lib/services/ai_service.dart`)

```dart
abstract class AiService {
  // ... existing methods ...

  /// 唤起 AI 配置面板
  /// 让用户选择当前偏好的 AI 卦师、模型等
  /// [context] 上下文
  /// Returns: 用户是否确认修改 (true/false)
  Future<bool> showConfigSheet({
    required BuildContext context,
  });

  /// 获取当前激活的 AI 配置摘要（用于在子模块 UI 上展示，如 "当前卦师：玄机子"）
  /// 子模块监听此流，实时更新界面上的文本
  Stream<AiConfigSummary> get activeConfig;
}

class AiConfigSummary {
  final String personaName;
  final String modelName;
  
  AiConfigSummary({required this.personaName, required this.modelName});
}
```

### 6.2 交互流程

1. **子模块 (`xuan-qimen`)**: 在界面（如右上角）放置一个 "AI 设置" 按钮。
    * 按钮文案可绑定 `activeConfig` 流，动态显示 "当前: 玄机子"。
2. **点击事件**: 调用 `AiService.showConfigSheet(context)`。
3. **UI 响应 (`xuan-ai`)**: 弹出一个 BottomSheet，列出所有可用卦师/模型。
4. **状态更新**: 用户选择并确认后，`activeConfig` 流发出新值，子模块界面自动刷新。

---

## 7. 扩展能力 (Extensions)

AI 服务不仅限于“排盘分析”，还可以通过以下接口赋能更多场景。

### 7.1 术语解释 (Term Explanation)

* **场景**: 用户点击“空亡”、“伏吟”等术语。
* **接口**:

    ```dart
    Future<String> explainTerm(String term, {AiContext? context});
    ```

### 7.2 智能摘要 (Smart Summary)

* **场景**: 用户保存记录时，自动生成标题或断语摘要。
* **接口**:

    ```dart
    Future<String> generateSummary(AiEntity entity);
    ```

### 7.3 相似案例 (Similar Cases)

* **场景**: 检索历史相似盘面 (RAG)。
* **接口**:

    ```dart
    Future<List<String>> findSimilarCases(AiEntity entity);
    ```

---

---

## 8. 扩展性管理 (Scalability Management)

随着功能不断增加，单纯往 `AiService` 里加方法会导致接口臃肿（God Interface）。为了应对未来的功能膨胀，我们采用以下策略：

### 8.1 接口隔离与分组 (Interface Segregation)

当功能变多时，不要全部堆在 `AiService` 根节点下。将其按领域分组：

```dart
abstract class AiService {
  // 核心能力
  Future<void> openChat(...);

  // 子功能模块 (Getter)
  AiKnowledgeService get knowledge; // 负责术语、查询
  AiAnalysisService get analysis;   // 负责摘要、深度分析
}

abstract class AiKnowledgeService {
  Future<String> explainTerm(...);
  Future<List<String>> findSimilarCases(...);
}
```

### 8.2 通用指令模式 (Command Pattern)

对于长尾需求（非核心、变动快的功能），不再定义显式方法，而是使用通用指令：

```dart
/// 通用指令基类
abstract class AiCommand<T> {
  String get type;
  Map<String, dynamic> get payload;
}

abstract class AiService {
  // ...
  /// 执行通用指令
  Future<T> execute<T>(AiCommand<T> command);
}
```

**优势**：在不修改 `AiService` 接口定义的情况下，可以无限扩展新的 `Command` 类（如 `GenerateWeeklyReportCommand`, `CompareTwoJuCommand`）。

---

## 9. 场景演练：“一键总结与存储” (Scenario: Summarize & Save)

这是一个典型的复杂交互场景：用户在 Chat 窗口中点击“总结”，AI 生成吉凶断语，并自动保存到数据库，供业务模块后续展示中查询。

### 9.1 流程设计

1. **触发 (Trigger)**
    * 用户在 `AiChatView` 顶部工具栏点击 "一键总结" 按钮。
    * 或者直接发送指令 "/summary"。

2. **生成 (Generation)**
    * `xuan-ai` 构造专用 Prompt（无需业务模块参与）：
        > "请根据上文的【奇门局】信息，用简练的语言总结吉凶，并给出 50 字以内的直断结论。"
    * LLM 返回内容："此局为大吉，青龙返首，利于求财..."

3. **存储 (Storage)**
    * `xuan-ai` 模块内部持有 `AiDatabase`。
    * 将结果存入 **`AiDivinations` 表**：
        * `entity_id`: "qimen_uuid_123" (来自 `AiContext`)
        * `summary`: "此局为大吉..."
        * `created_at`: timestamp

4. **同步与展示 (Sync & Display)**
    * **问题**：奇门模块的历史记录列表如何显示这个总结？
    * **机制**：通过 `AiService` 查询。
    * **奇门模块代码**：

        ```dart
        // 在奇门的历史记录列表中
        Widget buildHistoryItem(QimenRecord record) {
          return Column(
            children: [
              Text(record.name),
              // 异步加载 AI 总结
              FutureBuilder<String?>(
                future: AiService.instance.getSummary(entityId: record.uuid),
                builder: (context, snapshot) {
                  return Text(snapshot.data ?? "暂无总结");
                },
              ),
            ],
          );
        }
        ```

### 9.2 接口支持 (`AiService`)

为了支持上述流程，`AiService` 需要增加持久化数据的读取接口：

```dart
abstract class AiService {
  // ... existing methods ...

  /// 根据实体 ID 获取最新的 AI 总结/断语
  Future<String?> getSummary({required String entityId});
  
  /// (可选) 监听总结更新流
  Stream<String?> watchSummary({required String entityId});
}
```

### 9.3 优势

* **数据隔离**：奇门模块的数据库只需存“排盘参数”，不需要增加 "ai_summary" 字段。AI 数据完全由 AI 模块管理。
* **解耦显示**：奇门模块只负责“问”，不负责“存”和“算”。

---

## 10. 动态操作扩展 (Dynamic Action Extension)

为了支持“吉凶”、“直断”、“总结”等多种操作，并且允许未来无限扩展，我们不能在 Chat 界面写死按钮。我们需要一套 **动态动作注册机制**。

### 10.1 动作定义 (`xuan-common`)

定义一个抽象动作类，所有功能按钮都通过继承此类来实现。

```dart
/// AI 聊天窗口中的可执行操作
abstract class AiAction {
  String get id;
  String get label; // 按钮文字，如 "一键总结"
  IconData? get icon;
  
  /// 判断该动作是否适用于当前上下文
  /// 例如："排盘分析"动作只在有盘面数据时显示
  bool isApplicable(AiContext context);
  
  /// 执行动作
  Future<void> execute({
    required BuildContext context,
    required AiContext aiContext,
  });
}
```

### 10.2 动作注册与发现

在 `AiService` 中维护一个动作注册表。

```dart
abstract class AiService {
  // ... existing ...
  
  /// 注册一个新动作
  void registerAction(AiAction action);
  
  /// 获取适用于当前上下文的所有动作
  List<AiAction> getAvailableActions(AiContext context);
}
```

### 10.3 场景实现：添加“一键总结”功能

不需要修改 Chat UI 的代码，只需要实现并注册一个 `AiAction`。

```dart
class SummarizeAction extends AiAction {
  @override
  String get id => 'action_summarize';
  @override
  String get label => '一键总结';
  
  @override
  bool isApplicable(AiContext context) => context.entities.isNotEmpty;
  
  @override
  Future<void> execute({
    required BuildContext context, 
    required AiContext aiContext,
  }) async {
    // 1. 发送提示给用户 (User Message)
    // 2. 调用 AI 分析 (不带 UI 交互，或通过 Chat 里的 sendHiddenMessage)
    // 3. 获取结果
    // 4. 存入数据库 (调用 service.saveSummary)
  }
}
```

**扩展流程**：

1. 在 `xuan-ai` 或子模块中编写新的 `AiAction` 实现类。
2. 在 App 启动时调用 `AiService.registerAction(NewAction())`。
3. Chat 窗口会自动根据 `getAvailableActions` 渲染出新的按钮。

---

## 11. 释疑：子模块如何“注册”AI Action？

这是一个常见误区：认为子模块包含 "AI Action" 就意味着它依赖了 AI 模块。

**事实恰恰相反**。

### 11.1 依赖关系

* `xuan-common`: 定义了 `abstract class AiAction`。
* `xuan-ai`: 依赖 `xuan-common`。负责 **调用** `action.execute()`。
* `xuan-qimen`: 依赖 `xuan-common`。负责 **实现** `QimenAction extends AiAction`。

### 11.2 代码示例

在 `xuan-qimen` 模块中：

```dart
import 'package:xuan_common/domain/ai/ai_action.dart'; // 只依赖 common

class QimenAnalysisAction extends AiAction {
  @override
  String get label => "奇门专属分析";

  @override
  Future<void> execute(...) async {
    // 这里写的全是奇门自己的逻辑
    // 比如：弹出一个奇门特有的参数配置框
    // 然后再调用 aiService.openChat(...)
  }
}
```

**结论**：子模块完全不需要引入 `xuan-ai` 的代码，它只是实现了 `common` 给出的标准接口。

---

## 12. 总结：双向通信机制 (Two-Way Communication)

您的理解完全正确。整个架构的核心就是这两条通信链路：

### 链路 A：子模块 -> AI (分析/总结)

* **动作**：子模块主动调用 `AiService.openChat` 或 `AiService.execute(Action)`。
* **载体**：`AiContext` (包含自然语言描述的 prompt)。
* **场景**：用户点击“分析”、“总结”、“甚至预测”。
* **本质**：子模块是**发起者**，AI 是**服务者**。

### 链路 B：AI -> 子模块 (数据访问/反向查询)

* **动作**：AI 模块内部的 Tool/Agent 需要获取实时业务数据。
* **载体**：`AiEntity.rawData` 或 `AiAction` 的回调。
* **场景**：
  * AI 想要知道“这个奇门局的排盘时间对不对？” -> 它可以读取 `rawData` 中的 timestamps。
  * (未来) AI 想要“重新排一个局” -> 它可以调用一个注册好的 `ReCalucateAction`。
* **本质**：AI 是**发起者**（通过回调接口），子模块是**能力提供者**。

这种双向机制，通过 `xuan-common` 作为中间交换层，实现了完美的解耦。

---

## 13. 场景演练：“跨模块协同起局” (Cross-Module Collaboration)

这是一个高级场景：用户在“奇门 Chat Window”中请求 AI “起一个六壬课”，AI 调用六壬模块的能力，并将结果融合到当前对话中。

### 13.1 核心机制：Function Calling (工具调用)

为了实现这个功能，我们需要利用 LLM 的 **Function Calling** 能力，配合我们定义的 `AiTool` 接口。

#### 1. 工具定义 (`xuan-daliuren`)

大六壬模块在启动时，向 `AiService` 注册一个工具：

```dart
class CreateLiurenTool extends AiTool {
  @override
  String get name => "create_liuren_lesson";
  @override
  String get description => "起一个新的大六壬课，用于辅助判断。";
  
  @override
  Future<Map<String, dynamic>> execute(Map<String, dynamic> args) async {
    // 1. 调用六壬核心算法起课
    final lesson = LiurenCore.create(time: args['time']);
    // 2. 返回结果 (AiEntity 结构)
    return {
      "entity_type": "liuren_lesson",
      "description": lesson.toNaturalLanguage(), // "干支：甲子... 三传：..."
      "data": lesson.toJson(),
    };
  }
}
```

#### 2. 交互流程

1. **用户指令**: "我觉得奇门信息不够，请起一个大六壬课看看。"
2. **LLM 思考**: 识别意图 -> 匹配工具 `create_liuren_lesson`。
3. **LLM 请求**: `FunctionCall(name: "create_liuren_lesson", args: { "time": "2024-..." })`。
4. **`xuan-ai` 执行**:
    * 拦截请求。
    * 在注册表中找到 `CreateLiurenTool`。
    * 执行工具，获取六壬课数据。
5. **上下文融合**:
    * `xuan-ai` 将工具返回的六壬数据（`AiEntity`）添加到当前对话的 `AiContext` 中。
    * **UI 更新**：Chat 窗口中不仅显示文字，还渲染出一个“六壬课简盘”（这是 `AiEntity` 的可视化，由 `xuan-ai` 的通用渲染器或六壬提供的 Widget 负责）。
6. **LLM 最终回复**: "好的，已经为您起好了六壬课。课象显示..."（此时 LLM 同时拥有奇门和六壬的上下文）。

### 13.2 关键结论

* **单一窗口，多重上下文**：不需要跳转到新的“六壬窗口”。`xuan-ai` 的 Chat Window 是一个容器，可以容纳多个不同来源的 `AiEntity`。
* **工具注册制**：只要大六壬模块注册了工具，奇门窗口里的 AI 就能调用它。这是真正的**模块间互通**。

---

## 14. 场景演练：“历史案例检索” (Historical Data Retrieval)

场景：用户问：“之前是不是有个奇门局也是类似的？那个局是什么样的？”

这需要 AI 具备 **“跨模块检索历史数据”** 的能力。

### 14.1 机制：Tool-based RAG (工具增强检索)

这依然是通过 **Function Calling (Link B)** 实现的。

#### 1. 工具定义 (`xuan-qimendunjia`)

奇门模块注册一个搜索工具：

```dart
class SearchQimenHistoryTool extends AiTool {
  @override
  String get name => "search_qimen_history";
  @override
  String get description => "搜索历史保存的奇门局。支持按时间范围、格局特征（如'青龙返首'）、备注关键词搜索。";
  
  @override
  Map<String, dynamic> get parametersSchema => {
    "type": "object",
    "properties": {
      "keywords": {"type": "string", "description": "搜索关键词"},
      "pattern_feature": {"type": "string", "description": "格局特征"},
      "start_date": {"type": "string", "description": "开始日期 (YYYY-MM-DD)"}
    }
  };

  @override
  Future<Map<String, dynamic>> execute(Map<String, dynamic> args) async {
    // 1. 调用奇门模块的 Database/Repository 进行查询
    final results = await QimenRepository.search(
      keyword: args['keywords'],
      pattern: args['pattern_feature'],
    );
    
    // 2. 返回结果列表
    return {
      "count": results.length,
      "items": results.map((r) => r.toSummaryString()).toList(),
    };
  }
}
```

#### 2. 交互流程

1. **用户提问**: "之前是不是有个跟现在一样也是‘青龙返首’的局？"
2. **LLM 分析**: 提取特征 "青龙返首"，匹配工具 `search_qimen_history`。
3. **LLM 请求**: `FunctionCall(name: "search_qimen_history", args: { "pattern_feature": "青龙返首" })`。
4. **`xuan-ai` 执行**: 调用 `SearchQimenHistoryTool`。
5. **奇门模块响应**: 查询本地 SQL 数据库，返回 3 条历史记录的摘要。
6. **LLM 最终回复**: "找到了。在 2023年10月5日 和 2023年11月12日，您都起过‘青龙返首’的局。其中 10月5日 那个局也是..."

### 14.2 意义

* **隐私安全**: 数据保留在本地库，通过 Tool 接口按需通过 AI 处理，而不是把整个数据库传给 LLM。
* **精确查询**: 利用子模块已有的 SQL/ORM 查询能力，比纯向量检索更精准匹配特定术数特征。
