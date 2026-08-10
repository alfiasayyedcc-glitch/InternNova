import 'package:flutter/material.dart';

class CertificateScreen extends StatelessWidget {
  const CertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificates'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Certificate Management',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'View and manage internship certificates.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 25),

          _CertificateCard(
            studentName: 'Student One',
            internship: 'Flutter Development',
            company: 'InternNova Technologies',
            status: 'Issued',
          ),

          _CertificateCard(
            studentName: 'Student Two',
            internship: 'Python Development',
            company: 'Tech Solutions',
            status: 'Pending',
          ),

          _CertificateCard(
            studentName: 'Student Three',
            internship: 'Web Development',
            company: 'Digital Innovations',
            status: 'Issued',
          ),
        ],
      ),
    );
  }
}

class _CertificateCard extends StatelessWidget {
  final String studentName;
  final String internship;
  final String company;
  final String status;

  const _CertificateCard({
    required this.studentName,
    required this.internship,
    required this.company,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIssued = status == 'Issued';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(
                      alpha: 0.1,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.workspace_premium_outlined,
                    color: Colors.deepPurple,
                    size: 32,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        studentName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        internship,
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
                    color: isIssued
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isIssued
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            const Divider(),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(
                  Icons.business_outlined,
                  size: 20,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    company,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isIssued
                      ? Colors.deepPurple
                      : Colors.grey,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: isIssued
                    ? () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          SnackBar(
                            content: Text(
                              'Certificate of $studentName is ready to view.',
                            ),
                          ),
                        );
                      }
                    : null,
                icon: Icon(
                  isIssued
                      ? Icons.visibility_outlined
                      : Icons.hourglass_empty,
                ),
                label: Text(
                  isIssued
                      ? 'View Certificate'
                      : 'Certificate Pending',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}