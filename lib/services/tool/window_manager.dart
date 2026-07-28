/// 窗口管理器接口
///
/// 定义了跨平台的窗口操作能力，由具体平台实现层提供支持。
abstract class WindowManager {
  /// 显示窗口
  Future<void> show();

  /// 隐藏窗口
  Future<void> hide();

  /// 关闭窗口
  Future<void> close();

  /// 最小化
  Future<void> minimize();

  /// 最大化
  Future<void> maximize();

  /// 恢复（取消最大化/最小化）
  Future<void> restore();

  /// 设置窗口大小
  Future<void> setSize(double width, double height);

  /// 设置窗口位置
  Future<void> setPosition(double x, double y);

  /// 居中窗口
  Future<void> center();

  /// 设置窗口标题
  Future<void> setTitle(String title);

  /// 是否全屏
  Future<bool> isFullScreen();

  /// 切换全屏
  Future<void> setFullScreen(bool isFullScreen);
}
