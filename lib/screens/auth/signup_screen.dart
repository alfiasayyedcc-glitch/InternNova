import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AuthService _authService = AuthService();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // =========================
  // SIGN UP
  // =========================

  Future<void> _signUp() async {
    final String name =
        _nameController.text.trim();

    final String email =
        _emailController.text.trim();

    final String password =
        _passwordController.text;

    final String confirmPassword =
        _confirmPasswordController.text;

    // =========================
    // VALIDATION
    // =========================

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage(
        'Please fill in all fields',
      );
      return;
    }

    if (name.length < 2) {
      _showMessage(
        'Please enter a valid name',
      );
      return;
    }

    if (!email.contains('@') ||
        !email.contains('.')) {
      _showMessage(
        'Please enter a valid email address',
      );
      return;
    }

    if (password.length < 6) {
      _showMessage(
        'Password must contain at least 6 characters',
      );
      return;
    }

    if (password != confirmPassword) {
      _showMessage(
        'Passwords do not match',
      );
      return;
    }

    // =========================
    // START LOADING
    // =========================

    setState(() {
      _isLoading = true;
    });

    try {
      // =========================
      // CREATE ACCOUNT
      // =========================

      final String? error =
          await _authService.signUp(
        name: name,
        email: email,
        password: password,

        // All users registering through
        // this screen are students.
        role: 'student',
      );

      if (!mounted) return;

      // =========================
      // SIGNUP FAILED
      // =========================

      if (error != null) {
        setState(() {
          _isLoading = false;
        });

        _showMessage(error);
        return;
      }

      // =========================
      // SIGNUP SUCCESSFUL
      // =========================

      setState(() {
        _isLoading = false;
      });

      _showMessage(
        'Account created successfully!',
      );

      await Future.delayed(
        const Duration(milliseconds: 800),
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      _showMessage(
        'Something went wrong. Please try again.',
      );
    }
  }

  // =========================
  // SHOW MESSAGE
  // =========================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // =========================
  // BUILD UI
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Account',
        ),
        backgroundColor:
            Colors.deepPurple,
        foregroundColor:
            Colors.white,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 20),

              // =========================
              // ICON
              // =========================

              const Center(
                child: Icon(
                  Icons.person_add_alt_1,
                  size: 85,
                  color: Colors.deepPurple,
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              // TITLE
              // =========================

              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Create your InternNova account to get started.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              // =========================
              // FULL NAME
              // =========================

              TextField(
                controller:
                    _nameController,
                textCapitalization:
                    TextCapitalization.words,
                enabled: !_isLoading,

                decoration:
                    InputDecoration(
                  labelText: 'Full Name',
                  hintText:
                      'Enter your full name',

                  prefixIcon:
                      const Icon(
                    Icons.person_outline,
                  ),

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // EMAIL
              // =========================

              TextField(
                controller:
                    _emailController,

                keyboardType:
                    TextInputType.emailAddress,

                enabled: !_isLoading,

                decoration:
                    InputDecoration(
                  labelText: 'Email',
                  hintText:
                      'Enter your email',

                  prefixIcon:
                      const Icon(
                    Icons.email_outlined,
                  ),

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // PASSWORD
              // =========================

              TextField(
                controller:
                    _passwordController,

                obscureText:
                    _obscurePassword,

                enabled: !_isLoading,

                decoration:
                    InputDecoration(
                  labelText: 'Password',
                  hintText:
                      'Minimum 6 characters',

                  prefixIcon:
                      const Icon(
                    Icons.lock_outline,
                  ),

                  suffixIcon:
                      IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons
                              .visibility_off_outlined
                          : Icons
                              .visibility_outlined,
                    ),

                    onPressed:
                        _isLoading
                            ? null
                            : () {
                                setState(() {
                                  _obscurePassword =
                                      !_obscurePassword;
                                });
                              },
                  ),

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // CONFIRM PASSWORD
              // =========================

              TextField(
                controller:
                    _confirmPasswordController,

                obscureText:
                    _obscureConfirmPassword,

                enabled: !_isLoading,

                decoration:
                    InputDecoration(
                  labelText:
                      'Confirm Password',

                  hintText:
                      'Re-enter your password',

                  prefixIcon:
                      const Icon(
                    Icons.lock_outline,
                  ),

                  suffixIcon:
                      IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons
                              .visibility_off_outlined
                          : Icons
                              .visibility_outlined,
                    ),

                    onPressed:
                        _isLoading
                            ? null
                            : () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                  ),

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // =========================
              // CREATE ACCOUNT BUTTON
              // =========================

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.deepPurple,

                    foregroundColor:
                        Colors.white,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),
                  ),

                  onPressed:
                      _isLoading
                          ? null
                          : _signUp,

                  child: _isLoading
                      ? const SizedBox(
                          width: 25,
                          height: 25,

                          child:
                              CircularProgressIndicator(
                            strokeWidth: 3,
                            color:
                                Colors.white,
                          ),
                        )
                      : const Text(
                          'Create Account',

                          style:
                              TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              // LOGIN
              // =========================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),

                  GestureDetector(
                    onTap:
                        _isLoading
                            ? null
                            : () {
                                Navigator.pop(
                                  context,
                                );
                              },

                    child: const Text(
                      'Login',

                      style: TextStyle(
                        color:
                            Colors.deepPurple,
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
