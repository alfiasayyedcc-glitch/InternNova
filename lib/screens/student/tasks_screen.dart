import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
  backgroundColor: const Color(0xFF1F3A5F),
  foregroundColor: Colors.white,
  elevation: 0,
  title: const Text(
    'My Tasks',
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
  elevation: 3,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
            child: ListTile(
              leading: const Icon(
  Icons.pending_actions,
  color: Color(0xFFF59E0B),
),
              title: Text('Complete Flutter UI'),
              subtitle: Text('Due: 10 August'),
             trailing: const Text(
  'Pending',
  style: TextStyle(
    color: Color(0xFFF59E0B),
    fontWeight: FontWeight.bold,
  ),
),
            ),
          ),
          Card(
  elevation: 3,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
            child: ListTile(
              leading: const Icon(
  Icons.pending_actions,
  color: Color(0xFFF59E0B),
),
              title: Text('Submit project report'),
              subtitle: Text('Due: 12 August'),
              trailing: const Text(
  'Pending',
  style: TextStyle(
    color: Color(0xFFF59E0B),
    fontWeight: FontWeight.bold,
  ),
),
            ),
          ),
          Card(
  elevation: 3,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
            child: ListTile(
              leading: const Icon(
  Icons.check_circle,
  color: Colors.green,
),
              title: Text('Create GitHub repository'),
              subtitle: Text('Completed'),
              trailing: const Text(
  'Done',
  style: TextStyle(
    color: Colors.green,
    fontWeight: FontWeight.bold,
  ),
),
            ),
          ),
        ],
      ),
    );
  }
}