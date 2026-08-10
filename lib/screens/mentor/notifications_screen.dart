import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    final notifications = [
      {
        'title': 'New Applicant',
        'message': 'A student has applied for your internship.',
        'time': '10 min ago',
        'icon': Icons.person_add_alt_1_outlined,
      },
      {
        'title': 'Task Submitted',
        'message': 'An intern has submitted a task for review.',
        'time': '1 hour ago',
        'icon': Icons.assignment_turned_in_outlined,
      },
      {
        'title': 'Leave Request',
        'message': 'You have a new leave request to review.',
        'time': '2 hours ago',
        'icon': Icons.event_note_outlined,
      },
      {
        'title': 'Announcement',
        'message': 'Your announcement was published successfully.',
        'time': 'Yesterday',
        'icon': Icons.campaign_outlined,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: notifications.isEmpty
          ? const Center(
        child: Text('No notifications'),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: secondary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  notification['icon'] as IconData,
                  color: secondary,
                ),
              ),
              title: Text(
                notification['title'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  notification['message'] as String,
                ),
              ),
              trailing: Text(
                notification['time'] as String,
                style: TextStyle(
                  fontSize: 11,
                  color: primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}