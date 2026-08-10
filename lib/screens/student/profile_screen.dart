import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isEditing = false;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _collegeController;
  late TextEditingController _courseController;
  late TextEditingController _phoneController;
  late TextEditingController _skillsController;

  @override
  void initState() {
    super.initState();

    final user = _auth.currentUser;

    _nameController = TextEditingController(
      text: user?.displayName ?? 'Student Name',
    );

    _emailController = TextEditingController(
      text: user?.email ?? 'student@example.com',
    );

    _collegeController =
        TextEditingController(text: 'Your College');

    _courseController =
        TextEditingController(text: 'Computer Engineering');

    _phoneController =
        TextEditingController(text: 'Not added');

    _skillsController =
        TextEditingController(text: 'Flutter, Dart, Firebase');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _collegeController.dispose();
    _courseController.dispose();
    _phoneController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    setState(() {
      _isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true) return;

    await _auth.signOut();

    if (!mounted) return;

    // Go back to the first screen after logout.
    Navigator.of(context).popUntil(
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,

        actions: [
          IconButton(
            tooltip: _isEditing ? 'Save' : 'Edit',
            icon: Icon(
              _isEditing ? Icons.check : Icons.edit,
            ),
            onPressed: () {
              if (_isEditing) {
                _saveProfile();
              } else {
                setState(() {
                  _isEditing = true;
                });
              }
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // Profile picture
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFE0E7FF),
              child: Icon(
                Icons.person,
                size: 55,
                color: Color(0xFF2563EB),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              _nameController.text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Student',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 25),

            _profileItem(
              icon: Icons.person_outline,
              title: 'Full Name',
              controller: _nameController,
            ),

            _profileItem(
              icon: Icons.email_outlined,
              title: 'Email',
              controller: _emailController,
              enabled: false,
            ),

            _profileItem(
              icon: Icons.phone_outlined,
              title: 'Phone',
              controller: _phoneController,
            ),

            _profileItem(
              icon: Icons.school_outlined,
              title: 'College',
              controller: _collegeController,
            ),

            _profileItem(
              icon: Icons.computer_outlined,
              title: 'Course',
              controller: _courseController,
            ),

            _profileItem(
              icon: Icons.code_outlined,
              title: 'Skills',
              controller: _skillsController,
            ),

            const SizedBox(height: 15),

            if (_isEditing)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _saveProfile,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Profile'),
                ),
              ),

            const SizedBox(height: 12),

            // Logout button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: _logout,
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileItem({
    required IconData icon,
    required String title,
    required TextEditingController controller,
    bool enabled = true,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF2563EB),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 5),

                if (_isEditing)
                  TextField(
                    controller: controller,
                    enabled: enabled,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  )
                else
                  Text(
                    controller.text,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}