import 'package:flutter/material.dart';
import 'models/GardenNotification.dart';


class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<GardenNotification> notifications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            title: Text(notification.title),
            subtitle: Text(
                '${notification.scheduledDate.toLocal().toString()}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeNotification(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNotification,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addNotification() {
    // Navigate to a page to create a new notification
  }

  void _removeNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }
}
