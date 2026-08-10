import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AssignTaskScreen extends StatefulWidget {
  const AssignTaskScreen({super.key});

  @override
  State<AssignTaskScreen> createState() =>
      _AssignTaskScreenState();
}

class _AssignTaskScreenState
    extends State<AssignTaskScreen> {
  final taskController = TextEditingController();

  String selectedStudent = 'Aarav Sharma';

  final students = [
    'Aarav Sharma',
    'Aisha Khan',
    'Rahul Patil',
    'Sneha Joshi',
  ];

  final List<Map<String, String>> tasks = [
    {
      'student': 'Aarav Sharma',
      'task': 'Build Login Screen',
      'status': 'Assigned',
    },
    {
      'student': 'Aisha Khan',
      'task': 'IoT Sensor Dashboard',
      'status': 'Submitted',
    },
  ];

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  void _assignTask() {
    if (taskController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a task.'),
        ),
      );
      return;
    }

    setState(() {
      tasks.add({
        'student': selectedStudent,
        'task': taskController.text.trim(),
        'status': 'Assigned',
      });
      taskController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task assigned successfully.'),
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
          'Assign Tasks',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Assign New Task',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 18),

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

          const SizedBox(height: 17),

          const Text(
            'Task',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 7),

          TextField(
            controller: taskController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Enter task details...',
            ),
          ),

          const SizedBox(height: 18),

          ElevatedButton.icon(
            onPressed: _assignTask,
            icon: const Icon(Icons.send_outlined),
            label: const Text('Assign Task'),
          ),

          const SizedBox(height: 30),

          const Text(
            'Assigned Tasks',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 14),

          ...tasks.map(
                (task) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.assignment_outlined,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  task['task']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  task['student']!,
                ),
                trailing: Text(
                  task['status']!,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: task['status'] == 'Submitted'
                        ? AppColors.success
                        : AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}