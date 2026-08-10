import 'package:flutter/material.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'My Applications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [

          // 1st Internship
          _applicationCard(
            company: 'Infosys',
            position: 'Flutter Developer Intern',
            status: 'Pending',
            statusColor: Colors.orange,
          ),

          // 2nd Internship
          _applicationCard(
            company: 'TechNova Solutions',
            position: 'Flutter Developer Intern',
            status: 'Accepted',
            statusColor: Colors.green,
          ),

          // 3rd Internship
          _applicationCard(
            company: 'Third Company',
            position: 'Flutter Developer Intern',
            status: 'Pending',
            statusColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _applicationCard({
    required String company,
    required String position,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [

          const CircleAvatar(
            backgroundColor: Color(0xFFEFF6FF),
            child: Icon(
              Icons.description_outlined,
              color: Color(0xFF2563EB),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  company,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  position,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),

            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}