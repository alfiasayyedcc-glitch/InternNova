import 'package:flutter/material.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
  backgroundColor: const Color(0xFF1F3A5F),
  foregroundColor: Colors.white,
  elevation: 0,
  title: const Text(
    'My Applications',
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _applicationCard(
            'Flutter Developer',
            'ABC Technologies',
            'Pending',
          ),
          _applicationCard(
            'IoT Developer',
            'XYZ Technologies',
            'Accepted',
          ),
        ],
      ),
    );
  }

  Widget _applicationCard(
    String title,
    String company,
    String status,
  ) {
    return Card(
       elevation: 3,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
       title: Text(
  title,
  style: const TextStyle(
    fontWeight: FontWeight.bold,
    color: Color(0xFF1F3A5F),
  ),
),
        subtitle: Text(company),
        trailing: Text(
  status,
  style: TextStyle(
    fontWeight: FontWeight.bold,
    color: status == 'Accepted'
        ? Colors.green
        : const Color(0xFFF59E0B),
  ),
),
      ),
    );
  }
}