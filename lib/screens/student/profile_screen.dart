import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
  backgroundColor: const Color(0xFF1F3A5F),
  foregroundColor: Colors.white,
  elevation: 0,
  title: const Text(
    'My Profile',
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
  radius: 45,
  backgroundColor: const Color(0xFF1F3A5F),
  child: const Icon(
    Icons.person,
    size: 50,
    color: Colors.white,
  ),
),

            const SizedBox(height: 20),

            const Text(
  'Student Name',
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1F3A5F),
  ),
),

            const SizedBox(height: 20),

            const ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('student@gmail.com'),
            ),

            const ListTile(
              leading: Icon(Icons.school),
              title: Text('College'),
              subtitle: Text('Cusrow Wadia Institute'),
            ),

            const ListTile(
              leading: Icon(Icons.computer),
              title: Text('Course'),
              subtitle: Text('Computer Engineering & IoT'),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF1F3A5F),
    foregroundColor: Colors.white,
  ),
  onPressed: () {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit profile coming soon'),
      ),
    );
  },
  child: const Text('Edit Profile'),
),
            ),
          ],
        ),
      ),
    );
  }
}