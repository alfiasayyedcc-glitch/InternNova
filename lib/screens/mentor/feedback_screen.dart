import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() =>
      _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final feedbackController = TextEditingController();

  String selectedStudent = 'Aarav Sharma';

  final students = [
    'Aarav Sharma',
    'Aisha Khan',
    'Rahul Patil',
    'Sneha Joshi',
  ];

  int rating = 4;

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (feedbackController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter feedback.'),
        ),
      );
      return;
    }

    feedbackController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feedback submitted successfully.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Student Feedback',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Review Student',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Student',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 7),

          DropdownButtonFormField<String>(
            value: selectedStudent,
            decoration: const InputDecoration(),
            items: students.map((student) {
              return DropdownMenuItem(
                value: student,
                child: Text(student),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedStudent = value!;
              });
            },
          ),

          const SizedBox(height: 24),

          const Text(
            'Rating',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: List.generate(
              5,
                  (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      rating = index + 1;
                    });
                  },
                  icon: Icon(
                    index < rating
                        ? Icons.star
                        : Icons.star_border,
                    color: AppColors.accent,
                    size: 30,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Feedback',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 7),

          TextField(
            controller: feedbackController,
            maxLines: 6,
            decoration: const InputDecoration(
              hintText:
              'Write feedback about the student performance...',
            ),
          ),

          const SizedBox(height: 22),

          ElevatedButton.icon(
            onPressed: _submitFeedback,
            icon: const Icon(Icons.send_outlined),
            label: const Text('Submit Feedback'),
          ),

          const SizedBox(height: 30),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.info,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Feedback helps students understand their progress and improve their skills.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}