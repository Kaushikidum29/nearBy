import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  // Dummy data
  final List<Map<String, String>> notifications = [
    {"type": "Emergency", "message": "Medical help required immediately"},
    {"type": "Essentials", "message": "Groceries delivered to nearby shop"},
    {"type": "Updates", "message": "App update available"},
    {"type": "Information", "message": "Community meeting tomorrow 10 AM"},
  ];

  Color _getTypeColor(String type) {
    switch (type) {
      case "Emergency":
        return Colors.red.shade400;
      case "Essentials":
        return Colors.green.shade400;
      case "Updates":
        return Colors.blue.shade400;
      case "Information":
        return Colors.orange.shade400;
      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.cyan.shade800,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          final type = item["type"]!;
          final message = item["message"]!;

          return Dismissible(
            key: Key(item["message"]!),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              setState(() {
                notifications.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$type notification dismissed")),
              );
            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              color: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: _getTypeColor(type),
                    child: const Icon(Icons.notifications, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(type,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _getTypeColor(type))),
                        const SizedBox(height: 4),
                        Text(message,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
