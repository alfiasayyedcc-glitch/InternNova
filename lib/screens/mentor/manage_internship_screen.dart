import 'package:flutter/material.dart';

class ManageInternshipsScreen extends StatefulWidget {
  const ManageInternshipsScreen({super.key});

  @override
  State<ManageInternshipsScreen> createState() =>
      _ManageInternshipsScreenState();
}

class _ManageInternshipsScreenState
    extends State<ManageInternshipsScreen> {
  final List<Map<String, dynamic>> internships = [
    {
      'title': 'Flutter Developer Intern',
      'company': 'InternNova Technologies',
      'duration': '3 Months',
      'mode': 'Hybrid',
      'stipend': '₹10,000/month',
      'status': true,
    },
    {
      'title': 'IoT Developer Intern',
      'company': 'Tech Solutions',
      'duration': '6 Months',
      'mode': 'On-site',
      'stipend': '₹12,000/month',
      'status': true,
    },
  ];

  void editInternship(int index) {
    final controller =
    TextEditingController(text: internships[index]['title']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Internship'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Internship Title',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  internships[index]['title'] =
                      controller.text.trim();
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void deleteInternship(int index) {
    setState(() {
      internships.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Internship deleted'),
      ),
    );
  }

  void toggleInternship(int index) {
    setState(() {
      internships[index]['status'] =
      !internships[index]['status'];
    });
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
          'Manage Internships',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: internships.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.work_off_outlined,
              size: 60,
              color: Color(0xFF18A6A6),
            ),
            SizedBox(height: 12),
            Text(
              'No internships posted yet',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: internships.length,
        itemBuilder: (context, index) {
          final item = internships[index];
          final active = item['status'] as bool;

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE2E8ED),
              ),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5F5),
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.work_outline,
                        color: Color(0xFF18A6A6),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item['title'],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF123B5D),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Text(
                  item['company'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _chip(
                      Icons.calendar_today_outlined,
                      item['duration'],
                    ),
                    _chip(
                      Icons.location_on_outlined,
                      item['mode'],
                    ),
                    _chip(
                      Icons.currency_rupee,
                      item['stipend'],
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Icon(
                      active
                          ? Icons.check_circle
                          : Icons.cancel,
                      size: 16,
                      color: active
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      active ? 'Active' : 'Closed',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: active
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            editInternship(index),
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 17,
                        ),
                        label: const Text('Edit'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            toggleInternship(index),
                        icon: Icon(
                          active
                              ? Icons.close
                              : Icons.check,
                          size: 17,
                        ),
                        label: Text(
                          active ? 'Close' : 'Activate',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          deleteInternship(index),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _chip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: const Color(0xFF18A6A6),
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}