import 'package:flutter/material.dart';

class InternshipsScreen extends StatelessWidget {
  const InternshipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
     appBar: AppBar(
  backgroundColor: const Color(0xFF1F3A5F),
  foregroundColor: Colors.white,
  elevation: 0,
  title: const Text(
    'Available Internships',
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _internshipCard(
            context,
            'Flutter Developer',
            'ABC Technologies',
            '3 Months',
            'Pune',
          ),
          _internshipCard(
            context,
            'IoT Developer',
            'XYZ Technologies',
            '6 Months',
            'Pune',
          ),
          _internshipCard(
            context,
            'Mobile App Developer',
            'Tech Solutions',
            '3 Months',
            'Remote',
          ),
        ],
      ),
    );
  }

  Widget _internshipCard(
    BuildContext context,
    String title,
    String company,
    String duration,
    String location,
  ) {
    return Card(
       elevation: 3,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
  title,
  style: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1F3A5F),
  ),
),
            const SizedBox(height: 8),
            Text(company),
            const SizedBox(height: 8),
            Text('Duration: $duration'),
            Text('Location: $location'),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF1F3A5F),
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 45),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  onPressed: () {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Application submitted successfully!'),
      ),
    );
  },
  child: const Text('Apply Now'),
),
            ),
          ],
        ),
      ),
    );
  }
}