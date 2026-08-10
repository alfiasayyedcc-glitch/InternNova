import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AddInternshipScreen extends StatefulWidget {
  const AddInternshipScreen({super.key});

  @override
  State<AddInternshipScreen> createState() =>
      _AddInternshipScreenState();
}

class _AddInternshipScreenState
    extends State<AddInternshipScreen> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final descriptionController = TextEditingController();

  String location = 'Remote';
  String duration = '3 Months';

  @override
  void dispose() {
    titleController.dispose();
    companyController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _postInternship() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Internship posted successfully.',
        ),
      ),
    );

    Navigator.pop(context);
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
          'Post Internship',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Create Internship',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Add details about the opportunity for students.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 24),

            _label('Internship Title'),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'e.g. Flutter Developer Intern',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an internship title';
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            _label('Company / Organization'),
            TextFormField(
              controller: companyController,
              decoration: const InputDecoration(
                hintText: 'e.g. InternNova',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter company name';
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            _label('Location'),
            DropdownButtonFormField<String>(
              value: location,
              decoration: const InputDecoration(),
              items: const [
                DropdownMenuItem(
                  value: 'Remote',
                  child: Text('Remote'),
                ),
                DropdownMenuItem(
                  value: 'Pune',
                  child: Text('Pune'),
                ),
                DropdownMenuItem(
                  value: 'Mumbai',
                  child: Text('Mumbai'),
                ),
                DropdownMenuItem(
                  value: 'Bangalore',
                  child: Text('Bangalore'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  location = value!;
                });
              },
            ),

            const SizedBox(height: 18),

            _label('Duration'),
            DropdownButtonFormField<String>(
              value: duration,
              decoration: const InputDecoration(),
              items: const [
                DropdownMenuItem(
                  value: '1 Month',
                  child: Text('1 Month'),
                ),
                DropdownMenuItem(
                  value: '3 Months',
                  child: Text('3 Months'),
                ),
                DropdownMenuItem(
                  value: '6 Months',
                  child: Text('6 Months'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  duration = value!;
                });
              },
            ),

            const SizedBox(height: 18),

            _label('Description'),
            TextFormField(
              controller: descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText:
                'Describe the internship, responsibilities and requirements...',
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: _postInternship,
              icon: const Icon(Icons.publish_outlined),
              label: const Text('Post Internship'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}