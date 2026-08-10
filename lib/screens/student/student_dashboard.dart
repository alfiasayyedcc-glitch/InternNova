import 'package:flutter/material.dart';
import 'internships_screen.dart';
import 'applications_screen.dart';
import 'tasks_screen.dart';
import 'profile_screen.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
  backgroundColor: const Color(0xFF1F3A5F),
  foregroundColor: Colors.white,
  elevation: 0,
  title: const Text(
    'InternNova',
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Student 👋',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
  width: double.infinity,
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: const Color(0xFF1F3A5F),
  ),
  child: const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Active Internship',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 8),
      Text(
        'Flutter Developer',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 5),
      Text(
        'ABC Technologies',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      Text(
        '45 days remaining',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ],
  ),
),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    'Applications',
                    '2',
                    Icons.description,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    'Tasks',
                    '5',
                    Icons.task,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'Upcoming Tasks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            _taskTile('Complete Flutter UI'),
            _taskTile('Submit project report'),

            const SizedBox(height: 25),

            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF1F3A5F),
    foregroundColor: Colors.white,
  ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InternshipsScreen(),
                    ),
                  );
                },
                child: const Text('Browse Internships'),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFFF59E0B),
    side: const BorderSide(
      color: Color(0xFFF59E0B),
    ),
  ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ApplicationsScreen(),
                    ),
                  );
                },
                child: const Text('My Applications'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _statCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(
  icon,
  size: 30,
  color: const Color(0xFF2A9D8F),
),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }

  static Widget _taskTile(String task) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.check_circle_outline),
        title: Text(task),
      ),
    );
  }
}