import 'package:flutter/material.dart';
import 'screens/mentor/mentor_dashboard.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const InternNovaApp());
}

class InternNovaApp extends StatelessWidget {
  const InternNovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InternNova',
      theme: AppTheme.lightTheme,
      home: MentorDashboard(),
    );
  }
}