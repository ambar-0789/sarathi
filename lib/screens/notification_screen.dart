import 'package:flutter/material.dart';
import '../data/app_data.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = AppData.notifications;

    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: notifications.isEmpty
          ? const Center(child: Text("No notifications yet."))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(Icons.notifications),
                title: Text(notifications[index]),
              ),
            ),
    );
  }
}
