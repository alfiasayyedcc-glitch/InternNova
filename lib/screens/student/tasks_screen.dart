import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
const TasksScreen({super.key});

@override
State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
final List<Map<String, dynamic>> tasks = [
{
'title': 'Complete Flutter Assignment',
'description': 'Build the internship management UI.',
'completed': false,
},
{
'title': 'Submit Weekly Report',
'description': 'Submit your weekly internship report.',
'completed': true,
},
{
'title': 'Update Profile',
'description': 'Complete your student profile.',
'completed': false,
},
];

void _toggleTask(int index) {
setState(() {
tasks[index]['completed'] =
!tasks[index]['completed'];
});
}

@override
Widget build(BuildContext context) {
final completedTasks =
tasks.where((task) => task['completed'] == true).length;


final totalTasks = tasks.length;

return Scaffold(
  backgroundColor: const Color(0xFFF5F7FB),

  appBar: AppBar(
    title: const Text(
      'My Tasks',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    elevation: 0,
  ),

  body: ListView(
    padding: const EdgeInsets.all(20),
    children: [

      // Progress Card
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2563EB),
              Color(0xFF4F46E5),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              'Task Progress',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '$completedTasks / $totalTasks Completed',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            LinearProgressIndicator(
              value: totalTasks == 0
                  ? 0
                  : completedTasks / totalTasks,

              minHeight: 8,

              backgroundColor:
                  Colors.white24,

              valueColor:
                  const AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 25),

      const Text(
        'Assigned Tasks',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 15),

      // Tasks
      ...List.generate(
        tasks.length,
        (index) {
          final task = tasks[index];

          return _taskCard(
            title: task['title'],
            description: task['description'],
            completed: task['completed'],
            onTap: () => _toggleTask(index),
          );
        },
      ),
    ],
  ),
);

}

Widget _taskCard({
required String title,
required String description,
required bool completed,
required VoidCallback onTap,
}) {
return InkWell(
onTap: onTap,
borderRadius: BorderRadius.circular(18),


  child: Container(
    margin:
        const EdgeInsets.only(bottom: 15),

    padding:
        const EdgeInsets.all(18),

    decoration: BoxDecoration(
      color: Colors.white,

      borderRadius:
          BorderRadius.circular(18),

      boxShadow: [
        BoxShadow(
          color:
              Colors.black.withValues(alpha: 0.05),

          blurRadius: 10,

          offset:
              const Offset(0, 4),
        ),
      ],
    ),

    child: Row(
      children: [

        Icon(
          completed
              ? Icons.check_circle
              : Icons.radio_button_unchecked,

          color: completed
              ? Colors.green
              : Colors.grey,

          size: 30,
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                title,

                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,

                  fontSize: 16,

                  decoration: completed
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,

                  color: completed
                      ? Colors.grey
                      : Colors.black87,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                description,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                completed
                    ? 'Completed'
                    : 'Tap to mark as completed',

                style: TextStyle(
                  fontSize: 12,

                  fontWeight:
                      FontWeight.w600,

                  color: completed
                      ? Colors.green
                      : Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);


}
}
