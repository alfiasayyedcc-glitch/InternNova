import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Attendance Overview',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'View student attendance records.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 25),

          // Summary cards
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: 'Present',
                  count: '2',
                  icon: Icons.check_circle_outline,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryCard(
                  title: 'Absent',
                  count: '1',
                  icon: Icons.cancel_outlined,
                  color: Colors.red,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            'Recent Attendance',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          const _AttendanceCard(
            name: 'Student One',
            date: '08 Aug 2026',
            status: 'Present',
          ),

          const _AttendanceCard(
            name: 'Student Two',
            date: '08 Aug 2026',
            status: 'Present',
          ),

          const _AttendanceCard(
            name: 'Student Three',
            date: '08 Aug 2026',
            status: 'Absent',
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Icon(
              icon,
              size: 35,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              count,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttendanceCard extends StatelessWidget {
  final String name;
  final String date;
  final String status;

  const _AttendanceCard({
    required this.name,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPresent = status == 'Present';

    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Icon(
          isPresent
              ? Icons.check_circle_outline
              : Icons.cancel_outlined,
          color: isPresent ? Colors.green : Colors.red,
          size: 32,
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(date),
        ),
        trailing: Text(
          status,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isPresent ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}