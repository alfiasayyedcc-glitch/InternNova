import 'package:flutter/material.dart';

class PostInternshipScreen extends StatefulWidget {
  const PostInternshipScreen({super.key});

  @override
  State<PostInternshipScreen> createState() =>
      _PostInternshipScreenState();
}

class _PostInternshipScreenState
    extends State<PostInternshipScreen> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final descriptionController = TextEditingController();
  final skillsController = TextEditingController();
  final durationController = TextEditingController();
  final stipendController = TextEditingController();

  String workMode = 'On-site';

  @override
  void dispose() {
    titleController.dispose();
    companyController.dispose();
    descriptionController.dispose();
    skillsController.dispose();
    durationController.dispose();
    stipendController.dispose();
    super.dispose();
  }

  void _postInternship() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Internship posted successfully.'),
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  InputDecoration _decoration(
      String label,
      IconData icon, {
        String? hint,
      }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF18A6A6),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8ED),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF18A6A6),
          width: 1.5,
        ),
      ),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF123B5D),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF123B5D),
                      Color(0xFF18A6A6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.work_outline_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Create Internship',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Provide details about the opportunity for students.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Internship Details',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF17212B),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: titleController,
                validator: _required,
                decoration: _decoration(
                  'Internship Title',
                  Icons.work_outline,
                  hint: 'e.g. Flutter Developer Intern',
                ),
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: companyController,
                validator: _required,
                decoration: _decoration(
                  'Company Name',
                  Icons.business_outlined,
                  hint: 'e.g. InternNova Technologies',
                ),
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: descriptionController,
                validator: _required,
                maxLines: 4,
                decoration: _decoration(
                  'Description',
                  Icons.description_outlined,
                  hint: 'Describe the internship...',
                ),
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: skillsController,
                validator: _required,
                decoration: _decoration(
                  'Required Skills',
                  Icons.code_outlined,
                  hint: 'Flutter, Dart, Firebase',
                ),
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: durationController,
                validator: _required,
                decoration: _decoration(
                  'Duration',
                  Icons.calendar_month_outlined,
                  hint: 'e.g. 3 months',
                ),
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: stipendController,
                keyboardType: TextInputType.number,
                decoration: _decoration(
                  'Stipend',
                  Icons.currency_rupee,
                  hint: 'e.g. 10000 per month',
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'Work Mode',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF17212B),
                ),
              ),

              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE2E8ED),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: workMode,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'On-site',
                        child: Text('On-site'),
                      ),
                      DropdownMenuItem(
                        value: 'Remote',
                        child: Text('Remote'),
                      ),
                      DropdownMenuItem(
                        value: 'Hybrid',
                        child: Text('Hybrid'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          workMode = value;
                        });
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _postInternship,
                  icon: const Icon(
                    Icons.publish_rounded,
                  ),
                  label: const Text(
                    'Post Internship',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF123B5D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}