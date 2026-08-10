import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';
import '../admin/admin_dashboard.dart';
import '../mentor/mentor_dashboard.dart';
import '../student/student_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  final AuthService _authService = AuthService();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // =========================
  // LOGIN
  // =========================

  Future<void> _login() async {
    final String email =
        _emailController.text.trim();

    final String password =
        _passwordController.text;

    // Empty field validation
    if (email.isEmpty || password.isEmpty) {
      _showMessage(
        'Please enter email and password',
      );
      return;
    }

    // Basic email validation
    if (!email.contains('@') || !email.contains('.')) {
      _showMessage(
        'Please enter a valid email address',
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // =========================
      // FIREBASE LOGIN
      // =========================

      final String? loginError =
          await _authService.login(
        email: email,
        password: password,
      );

      if (!mounted) return;

      // Login failed
      if (loginError != null) {
        setState(() {
          _isLoading = false;
        });

        _showMessage(loginError);
        return;
      }

      // =========================
      // GET USER ROLE
      // =========================

      final String? role =
          await _authService.getUserRole();

      if (!mounted) return;

      if (role == null) {
        setState(() {
          _isLoading = false;
        });

        _showMessage(
          'User role not found. Please contact administrator.',
        );

        await _authService.logout();
        return;
      }

      // =========================
      // ROLE-BASED NAVIGATION
      // =========================

      setState(() {
        _isLoading = false;
      });

      if (role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const AdminDashboard(),
          ),
        );
      } else if (role == 'mentor') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const MentorDashboard(),
          ),
        );
      } else if (role == 'student') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const StudentDashboard(),
          ),
        );
      } else {
        _showMessage(
          'Invalid user role.',
        );

        await _authService.logout();
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // =========================
              // LOGO
              // =========================

              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/internnova_logo.jpeg',
                      height: 100,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'InternNova',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // =========================
              // WELCOME
              // =========================

              const Text(
                'Welcome Back 👋',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Login to continue to your internship portal',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              // =========================
              // EMAIL
              // =========================

              TextField(
                controller: _emailController,
                keyboardType:
                    TextInputType.emailAddress,
                enabled: !_isLoading,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
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
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons
                              .visibility_off_outlined
                          : Icons
                              .visibility_outlined,
                    ),
                    onPressed: _isLoading
                        ? null
                        : () {
                            setState(() {
                              _obscurePassword =
                                  !_obscurePassword;
                            });
                          },
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // =========================
              // FORGOT PASSWORD
              // =========================

              Align(
                alignment:
                    Alignment.centerRight,
                child: TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const ForgotPasswordScreen(),
                            ),
                          );
                        },
                  child: const Text(
                    'Forgot Password?',
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // LOGIN BUTTON
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
                      _isLoading ? null : _login,
                  child: _isLoading
                      ? const SizedBox(
                          width: 25,
                          height: 25,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 30),

              // =========================
              // SIGN UP
              // =========================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: _isLoading
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const SignupScreen(),
                              ),
                            );
                          },
                    child: const Text(
                      'Sign Up',
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
