import 'package:flutter/widgets.dart';

import 'ai_context.dart';

/// Link A 动作接口：子模块通过此接口向 AI 注册可执行操作。
///
/// [AiAction] 代表一个可以出现在聊天窗口中的动态按钮/命令，
/// 例如"一键总结"、"奇门专属分析"等。
///
/// 子模块在 `xuan-common` 中定义并实现 [AiAction]，
/// 然后通过 [AiService.registerAction] 注册到 AI 服务。
/// Chat UI 会根据 [isApplicable] 动态显示适用的 Action。
abstract class AiAction {
  /// 唯一标识符，如 `qimen_summarize`。
  String get id;

  /// 显示文本，如 "一键总结"。
  String get label;

  /// 显示图标（可选）。
  IconData? get icon;

  /// 判断该动作是否适用于当前上下文。
  ///
  /// 例如："排盘分析"动作只在有盘面数据时显示。
  bool isApplicable(AiContext context);

  /// 执行动作。
  ///
  /// [context] 是 Flutter 的 BuildContext，用于 UI 操作（如弹窗）。
  /// [aiContext] 是当前的 AI 上下文数据。
  Future<void> execute({
    required BuildContext context,
    required AiContext aiContext,
  });
}
