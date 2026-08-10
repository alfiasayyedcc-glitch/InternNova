import 'package:flutter/material.dart';

class LeaveRequestsScreen extends StatefulWidget {
  const LeaveRequestsScreen({super.key});

  @override
  State<LeaveRequestsScreen> createState() => _LeaveRequestsScreenState();
}

class _LeaveRequestsScreenState extends State<LeaveRequestsScreen> {
  final List<Map<String, String>> requests = [
    {
      'name': 'Aarav Sharma',
      'dates': '12 Aug - 14 Aug 2026',
      'reason': 'Personal work',
      'status': 'Pending',
    },
    {
      'name': 'Priya Patel',
      'dates': '18 Aug - 19 Aug 2026',
      'reason': 'College examination',
      'status': 'Pending',
    },
    {
      'name': 'Rahul Mehta',
      'dates': '22 Aug - 23 Aug 2026',
      'reason': 'Family function',
      'status': 'Approved',
    },
  ];

  void _updateStatus(int index, String status) {
    setState(() {
      requests[index]['status'] = status;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          status == 'Approved'
              ? 'Leave request approved.'
              : 'Leave request rejected.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Requests'),
      ),
      body: requests.isEmpty
          ? const Center(
        child: Text('No leave requests available.'),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          final status = request['status']!;

          final isPending = status == 'Pending';
          final isApproved = status == 'Approved';

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                        primary.withValues(alpha: 0.1),
                        child: Text(
                          request['name']![0],
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          request['name']!,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isPending
                              ? Colors.orange.withValues(alpha: 0.12)
                              : isApproved
                              ? Colors.green
                              .withValues(alpha: 0.12)
                              : Colors.red.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isPending
                                ? Colors.orange
                                : isApproved
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: secondary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          request['dates']!,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: 18,
                        color: secondary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          request['reason']!,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),

                  if (isPending) ...[
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              _updateStatus(index, 'Rejected');
                            },
                            child: const Text('Reject'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _updateStatus(index, 'Approved');
                            },
                            child: const Text('Approve'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}