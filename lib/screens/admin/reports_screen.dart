import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Reports & Analytics',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          _ReportCard(
            icon: Icons.people_outline,
            title: 'Total Users',
            value: '120',
          ),

          _ReportCard(
            icon: Icons.school_outlined,
            title: 'Active Students',
            value: '85',
          ),

          _ReportCard(
            icon: Icons.person_outline,
            title: 'Mentors',
            value: '20',
          ),

          _ReportCard(
            icon: Icons.workspace_premium_outlined,
            title: 'Certificates Issued',
            value: '65',
          ),

          _ReportCard(
            icon: Icons.event_available_outlined,
            title: 'Average Attendance',
            value: '87%',
          ),
        ],
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ReportCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Icon(
          icon,
          size: 35,
          color: Colors.deepPurple,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}