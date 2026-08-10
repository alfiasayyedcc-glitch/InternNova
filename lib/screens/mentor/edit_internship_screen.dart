
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditInternshipScreen extends StatefulWidget {
  final String documentId;
  final Map<String, dynamic> internshipData;

  const EditInternshipScreen({
    super.key,
    required this.documentId,
    required this.internshipData,
  });

  @override
  State<EditInternshipScreen> createState() =>
      _EditInternshipScreenState();
}

class _EditInternshipScreenState
    extends State<EditInternshipScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController companyController;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController durationController;
  late TextEditingController skillsController;
  late TextEditingController stipendController;
  late TextEditingController seatsController;

  String status = 'active';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    companyController = TextEditingController(
      text: widget.internshipData['companyName']?.toString() ?? '',
    );

    titleController = TextEditingController(
      text: widget.internshipData['title']?.toString() ?? '',
    );

    descriptionController = TextEditingController(
      text: widget.internshipData['description']?.toString() ?? '',
    );

    locationController = TextEditingController(
      text: widget.internshipData['location']?.toString() ?? '',
    );

    durationController = TextEditingController(
      text: widget.internshipData['duration']?.toString() ?? '',
    );

    skillsController = TextEditingController(
      text: widget.internshipData['skills']?.toString() ?? '',
    );

    stipendController = TextEditingController(
      text: widget.internshipData['stipend']?.toString() ?? '',
    );

    seatsController = TextEditingController(
      text: widget.internshipData['seats']?.toString() ?? '',
    );

    status =
        widget.internshipData['status']?.toString() ?? 'active';
  }

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
  // UPDATE INTERNSHIP
  // ============================================================

  Future<void> _updateInternship() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final seats =
          int.tryParse(seatsController.text.trim());

      await FirebaseFirestore.instance
          .collection('internships')
          .doc(widget.documentId)
          .update({
        'companyName': companyController.text.trim(),
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'location': locationController.text.trim(),
        'duration': durationController.text.trim(),
        'skills': skillsController.text.trim(),
        'stipend': stipendController.text.trim(),
        'seats': seats,
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Internship updated successfully! 🎉',
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
            'Failed to update internship: $e',
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
          'Edit Internship',
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
              const Text(
                'Edit Internship Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Update the internship information below.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 25),

              _field(
                controller: companyController,
                label: 'Company Name',
                icon: Icons.business,
              ),

              _field(
                controller: titleController,
                label: 'Internship Title',
                icon: Icons.work_outline,
              ),

              _field(
                controller: descriptionController,
                label: 'Description',
                icon: Icons.description_outlined,
                maxLines: 4,
              ),

              _field(
                controller: locationController,
                label: 'Location',
                icon: Icons.location_on_outlined,
              ),

              _field(
                controller: durationController,
                label: 'Duration',
                icon: Icons.access_time,
              ),

              _field(
                controller: skillsController,
                label: 'Required Skills',
                icon: Icons.code,
              ),

              _field(
                controller: stipendController,
                label: 'Stipend',
                icon: Icons.currency_rupee,
              ),

              _field(
                controller: seatsController,
                label: 'Number of Seats',
                icon: Icons.people_outline,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 5),

              // ==================================================
              // STATUS
              // ==================================================

              
                DropdownButtonFormField<String>(
                  initialValue: status,
                decoration: InputDecoration(
                  labelText: 'Status',
                  prefixIcon:
                      const Icon(Icons.toggle_on_outlined),
                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),

                items: const [
                  DropdownMenuItem(
                    value: 'active',
                    child: Text('Active'),
                  ),
                  DropdownMenuItem(
                    value: 'inactive',
                    child: Text('Inactive'),
                  ),
                  DropdownMenuItem(
                    value: 'closed',
                    child: Text('Closed'),
                  ),
                ],

                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      status = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 25),

              // ==================================================
              // UPDATE BUTTON
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed:
                      _isLoading
                          ? null
                          : _updateInternship,

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
                          'Update Internship',
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

          prefixIcon: Icon(icon),

          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),

          enabledBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15),
            borderSide: BorderSide.none,
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

