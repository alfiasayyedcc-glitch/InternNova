import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ApplicantsScreen extends StatefulWidget {
  const ApplicantsScreen({super.key});

  @override
  State<ApplicantsScreen> createState() =>
      _ApplicantsScreenState();
}

class _ApplicantsScreenState extends State<ApplicantsScreen> {
  final List<Map<String, String>> applicants = [
    {
      'name': 'Aarav Sharma',
      'role': 'Flutter Developer Intern',
      'status': 'Pending',
    },
    {
      'name': 'Aisha Khan',
      'role': 'IoT Development Intern',
      'status': 'Pending',
    },
    {
      'name': 'Rahul Patil',
      'role': 'Python Developer Intern',
      'status': 'Accepted',
    },
    {
      'name': 'Sneha Joshi',
      'role': 'Flutter Developer Intern',
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Applicants',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: applicants.length,
        itemBuilder: (context, index) {
          final applicant = applicants[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            color: AppColors.surface,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(
                color: AppColors.border,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor:
                        AppColors.primary.withValues(alpha: 0.10),
                        child: Text(
                          applicant['name']![0],
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(width: 13),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              applicant['name']!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              applicant['role']!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      _status(applicant['status']!),
                    ],
                  ),

                  if (applicant['status'] == 'Pending') ...[
                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              _updateStatus(index, 'Rejected');
                            },
                            child: const Text('Reject'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _updateStatus(index, 'Accepted');
                            },
                            child: const Text('Accept'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _status(String status) {
    final accepted = status == 'Accepted';
    final rejected = status == 'Rejected';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: accepted
            ? AppColors.success.withValues(alpha: 0.10)
            : rejected
            ? AppColors.error.withValues(alpha: 0.10)
            : AppColors.accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: accepted
              ? AppColors.success
              : rejected
              ? AppColors.error
              : AppColors.warning,
        ),
      ),
    );
  }

  void _updateStatus(int index, String status) {
    setState(() {
      applicants[index]['status'] = status;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${applicants[index]['name']} marked as $status.',
        ),
      ),
    );
  }
}