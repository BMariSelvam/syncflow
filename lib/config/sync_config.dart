class SyncConfig {
  final int retryCount;
  final Duration retryDelay;
  final bool enableLogs;

  const SyncConfig({
    this.retryCount = 3,
    this.retryDelay = const Duration(seconds: 2),
    this.enableLogs = true,
  });
}