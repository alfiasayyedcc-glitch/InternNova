import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/intern_model.dart';
import '../../services/internship_service.dart';

class AddInternshipScreen extends StatefulWidget {
  const AddInternshipScreen({super.key});

  @override
  State<AddInternshipScreen> createState() =>
      _AddInternshipScreenState();
}

class _AddInternshipScreenState
    extends State<AddInternshipScreen> {
  final _formKey = GlobalKey<FormState>();

  final companyController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final durationController = TextEditingController();
  final skillsController = TextEditingController();
  final stipendController = TextEditingController();
  final seatsController = TextEditingController();

  final InternshipService _internshipService =
      InternshipService();

  bool _isLoading = false;

  @override
  void dispose() {
    companyController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    durationController.dispose();
    skillsController.dispose();
    stipendController.dispose();
    seatsController.dispose();

    super.dispose();
  }

  // ============================================================
  // ADD INTERNSHIP
  // ============================================================

  Future<void> _addInternship() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final User? user =
        FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'User not logged in. Please login again.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final internship = InternshipModel(
        companyName: companyController.text.trim(),
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        location: locationController.text.trim(),
        duration: durationController.text.trim(),

        // Current logged-in mentor
        mentorId: user.uid,
        mentorEmail: user.email ?? '',

        // Additional information
        seats: int.parse(
          seatsController.text.trim(),
        ),
        skills: skillsController.text.trim(),
        status: 'active',
        stipend: stipendController.text.trim(),

        // Model automatically uses DateTime.now()
        createdAt: DateTime.now(),
      );

      await _internshipService.addInternship(
        internship,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Internship added successfully! 🎉',
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to add internship: $e',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'Add Internship',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // ==================================================
              // HEADER
              // ==================================================

              const Text(
                'Create Internship',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Add the details of the internship you want to publish.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 25),

              // ==================================================
              // COMPANY NAME
              // ==================================================

              _field(
                controller: companyController,
                label: 'Company Name',
                icon: Icons.business,
                hint: 'Example: Infosys',
              ),

              // ==================================================
              // INTERNSHIP TITLE
              // ==================================================

              _field(
                controller: titleController,
                label: 'Internship Title',
                icon: Icons.work_outline,
                hint: 'Example: Flutter Developer Intern',
              ),

              // ==================================================
              // DESCRIPTION
              // ==================================================

              _field(
                controller: descriptionController,
                label: 'Description',
                icon: Icons.description_outlined,
                hint: 'Describe the internship...',
                maxLines: 4,
              ),

              // ==================================================
              // LOCATION
              // ==================================================

              _field(
                controller: locationController,
                label: 'Location',
                icon: Icons.location_on_outlined,
                hint: 'Example: Pune / Remote',
              ),

              // ==================================================
              // DURATION
              // ==================================================

              _field(
                controller: durationController,
                label: 'Duration',
                icon: Icons.access_time,
                hint: 'Example: 3 Months',
              ),

              // ==================================================
              // SKILLS
              // ==================================================

              _field(
                controller: skillsController,
                label: 'Required Skills',
                icon: Icons.code,
                hint: 'Example: Flutter, Dart, Firebase',
              ),

              // ==================================================
              // STIPEND
              // ==================================================

              _field(
                controller: stipendController,
                label: 'Stipend',
                icon: Icons.currency_rupee,
                hint: 'Example: ₹10,000/month',
              ),

              // ==================================================
              // SEATS
              // ==================================================

              _field(
                controller: seatsController,
                label: 'Number of Seats',
                icon: Icons.people_outline,
                hint: 'Example: 5',
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 15),

              // ==================================================
              // ADD BUTTON
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed:
                      _isLoading
                          ? null
                          : _addInternship,

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF6C3CC9),

                    foregroundColor: Colors.white,

                    disabledBackgroundColor:
                        Colors.grey.shade400,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                  ),

                  child: _isLoading
                      ? const SizedBox(
                          height: 25,
                          width: 25,

                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Add Internship',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 15),

      child: TextFormField(
        controller: controller,

        maxLines: maxLines,

        keyboardType: keyboardType,

        validator: (value) {
          if (value == null ||
              value.trim().isEmpty) {
            return 'Please enter $label';
          }

          // Validate number of seats
          if (label == 'Number of Seats') {
            final seats =
                int.tryParse(value.trim());

            if (seats == null || seats <= 0) {
              return 'Please enter a valid number of seats';
            }
          }

          return null;
        },

        decoration: InputDecoration(
          labelText: label,
          hintText: hint,

          prefixIcon: Icon(icon),

          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15),
            borderSide:
                BorderSide.none,
          ),

          enabledBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15),
            borderSide:
                BorderSide.none,
          ),

          focusedBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15),
            borderSide:
                const BorderSide(
              color: Color(0xFF6C3CC9),
              width: 2,
            ),
          ),

          errorBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15),
            borderSide:
                const BorderSide(
              color: Colors.red,
            ),
          ),

          focusedErrorBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15),
            borderSide:
                const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}