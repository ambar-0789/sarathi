class AppData {
  static List<String> notifications = [];

  static void addNotification(String message) {
    final now = DateTime.now();
    final timestamp =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    notifications.insert(0, "🔔 $message at $timestamp");
  }
}
