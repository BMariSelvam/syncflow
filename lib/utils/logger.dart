class SyncLogger {
  static bool enabled = true;

  static void log(String message) {
    if (enabled) {
      print("[SyncFlow] $message");
    }
  }
}