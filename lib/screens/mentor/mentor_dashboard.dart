import 'package:flutter/material.dart';

class MentorDashboard extends StatefulWidget {
  const MentorDashboard({super.key});

  @override
  State<MentorDashboard> createState() => _MentorDashboardState();
}

class _MentorDashboardState extends State<MentorDashboard> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> internships = [
    {
      'title': 'Flutter Developer Intern',
      'company': 'InternNova Technologies',
      'duration': '3 Months',
      'mode': 'Hybrid',
      'stipend': '₹10,000/month',
      'active': true,
    },
    {
      'title': 'IoT Developer Intern',
      'company': 'InternNova Technologies',
      'duration': '6 Months',
      'mode': 'On-site',
      'stipend': '₹12,000/month',
      'active': true,
    },
  ];

  final List<Map<String, dynamic>> applicants = [
    {
      'name': 'Aarav Sharma',
      'course': 'Computer Engineering',
      'skills': 'Flutter, Dart, Firebase',
      'internship': 'Flutter Developer Intern',
      'status': 'Pending',
    },
    {
      'name': 'Priya Patel',
      'course': 'Computer Engineering',
      'skills': 'Python, IoT, SQL',
      'internship': 'IoT Developer Intern',
      'status': 'Pending',
    },
    {
      'name': 'Rohan Mehta',
      'course': 'Information Technology',
      'skills': 'Java, Flutter',
      'internship': 'Flutter Developer Intern',
      'status': 'Accepted',
    },
  ];

  final List<Map<String, dynamic>> tasks = [
    {
      'student': 'Rohan Mehta',
      'title': 'Create Flutter Login Screen',
      'deadline': '15 Aug 2026',
      'status': 'Pending',
    },
  ];

  final List<Map<String, dynamic>> announcements = [
    {
      'title': 'Welcome to InternNova',
      'message':
      'Please check your assigned internship tasks regularly.',
      'date': '10 Aug 2026',
    },
  ];

  final List<Map<String, dynamic>> leaveRequests = [
    {
      'student': 'Rohan Mehta',
      'reason': 'Medical Leave',
      'date': '12 Aug 2026',
      'status': 'Pending',
    },
    {
      'student': 'Priya Patel',
      'reason': 'Personal Work',
      'date': '14 Aug 2026',
      'status': 'Pending',
    },
  ];

  final List<String> notifications = [
    'New internship application received.',
    'Rohan Mehta submitted a task.',
    'New leave request received.',
  ];

  void _open(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
          'InternNova',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 21,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () => _open(const NotificationsPage()),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: _dashboardBody(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);

          if (index == 1) {
            _open(const AnnouncementsPage());
          } else if (index == 2) {
            _open(const ProfilePage());
          }
        },
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFF18A6A6).withValues(alpha: 0.15),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined),
            selectedIcon: Icon(Icons.campaign),
            label: 'Announcements',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _dashboardBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome, Mentor',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Color(0xFF123B5D),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Manage internships, students and tasks.',
            style: TextStyle(
              color: Color(0xFF66727F),
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              _statCard(
                'Internships',
                internships.length.toString(),
                Icons.work_outline,
              ),
              const SizedBox(width: 10),
              _statCard(
                'Applicants',
                applicants.length.toString(),
                Icons.people_outline,
              ),
              const SizedBox(width: 10),
              _statCard(
                'Tasks',
                tasks.length.toString(),
                Icons.assignment_outlined,
              ),
            ],
          ),

          const SizedBox(height: 26),

          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Color(0xFF17212B),
            ),
          ),

          const SizedBox(height: 14),

          _actionCard(
            Icons.add_business_outlined,
            'Post Internship',
            'Create a new internship opportunity',
                () => _open(PostInternshipPage(
              onPosted: (data) {
                setState(() {
                  internships.add(data);
                });
              },
            )),
          ),

          _actionCard(
            Icons.manage_accounts_outlined,
            'Manage Internships',
            'View, edit, close or delete internships',
                () => _open(ManageInternshipsPage(
              internships: internships,
            )),
          ),

          _actionCard(
            Icons.people_alt_outlined,
            'Applicants',
            'Review and manage student applications',
                () => _open(ApplicantsPage(
              applicants: applicants,
            )),
          ),

          _actionCard(
            Icons.assignment_outlined,
            'Assign Tasks',
            'Assign work and deadlines to interns',
                () => _open(TasksPage(
              tasks: tasks,
            )),
          ),

          _actionCard(
            Icons.rate_review_outlined,
            'Feedback',
            'Review intern performance and provide feedback',
                () => _open(const FeedbackPage()),
          ),

          _actionCard(
            Icons.campaign_outlined,
            'Announcements',
            'Share important updates with students',
                () => _open(AnnouncementsPage(
              announcements: announcements,
            )),
          ),

          _actionCard(
            Icons.event_available_outlined,
            'Leave Requests',
            'Approve or reject student leave requests',
                () => _open(LeaveRequestsPage(
              requests: leaveRequests,
            )),
          ),

          _actionCard(
            Icons.notifications_none_rounded,
            'Notifications',
            'View recent activity and updates',
                () => _open(NotificationsPage(
              notifications: notifications,
            )),
          ),
        ],
      ),
    );
  }

  Widget _statCard(
      String title,
      String value,
      IconData icon,
      ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xFFE2E8ED),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: const Color(0xFF18A6A6),
              size: 24,
            ),
            const SizedBox(height: 7),
            Text(
              value,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: Color(0xFF123B5D),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF66727F),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionCard(
      IconData icon,
      String title,
      String subtitle,
      VoidCallback onTap,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFF18A6A6)
                        .withValues(alpha: 0.11),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF18A6A6),
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF17212B),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF66727F),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: Color(0xFF66727F),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// POST INTERNSHIP
// ============================================================

class PostInternshipPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onPosted;

  const PostInternshipPage({
    super.key,
    required this.onPosted,
  });

  @override
  State<PostInternshipPage> createState() =>
      _PostInternshipPageState();
}

class _PostInternshipPageState
    extends State<PostInternshipPage> {
  final title = TextEditingController();
  final company = TextEditingController();
  final description = TextEditingController();
  final skills = TextEditingController();
  final duration = TextEditingController();
  final stipend = TextEditingController();

  String mode = 'Hybrid';

  @override
  void dispose() {
    title.dispose();
    company.dispose();
    description.dispose();
    skills.dispose();
    duration.dispose();
    stipend.dispose();
    super.dispose();
  }

  void post() {
    if (title.text.trim().isEmpty ||
        company.text.trim().isEmpty ||
        description.text.trim().isEmpty ||
        skills.text.trim().isEmpty ||
        duration.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all required fields.'),
        ),
      );
      return;
    }

    widget.onPosted({
      'title': title.text.trim(),
      'company': company.text.trim(),
      'duration': duration.text.trim(),
      'mode': mode,
      'stipend': stipend.text.trim().isEmpty
          ? 'Not specified'
          : stipend.text.trim(),
      'active': true,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Internship posted successfully.'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return _formPage(
      title: 'Post Internship',
      children: [
        _field(title, 'Internship Title', Icons.work_outline),
        _field(company, 'Company Name', Icons.business_outlined),
        _field(
          description,
          'Description',
          Icons.description_outlined,
          lines: 4,
        ),
        _field(skills, 'Required Skills', Icons.code_outlined),
        _field(
          duration,
          'Duration',
          Icons.calendar_month_outlined,
        ),
        _field(
          stipend,
          'Stipend',
          Icons.currency_rupee,
          required: false,
        ),
        const SizedBox(height: 8),
        const Text(
          'Work Mode',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: mode,
          decoration: _inputDecoration(
            'Work Mode',
            Icons.location_on_outlined,
          ),
          items: const [
            DropdownMenuItem(
              value: 'On-site',
              child: Text('On-site'),
            ),
            DropdownMenuItem(
              value: 'Remote',
              child: Text('Remote'),
            ),
            DropdownMenuItem(
              value: 'Hybrid',
              child: Text('Hybrid'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() => mode = value);
            }
          },
        ),
        const SizedBox(height: 24),
        _primaryButton('Post Internship', post),
      ],
    );
  }
}

// ============================================================
// MANAGE INTERNSHIPS
// ============================================================

class ManageInternshipsPage extends StatefulWidget {
  final List<Map<String, dynamic>> internships;

  const ManageInternshipsPage({
    super.key,
    required this.internships,
  });

  @override
  State<ManageInternshipsPage> createState() =>
      _ManageInternshipsPageState();
}

class _ManageInternshipsPageState
    extends State<ManageInternshipsPage> {
  late List<Map<String, dynamic>> list;

  @override
  void initState() {
    super.initState();
    list = widget.internships;
  }

  @override
  Widget build(BuildContext context) {
    return _simpleScaffold(
      'Manage Internships',
      list.isEmpty
          ? const Center(
        child: Text('No internships posted yet.'),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          final active = item['active'] == true;

          return _card(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.work_outline,
                      color: Color(0xFF18A6A6),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item['title'],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF123B5D),
                        ),
                      ),
                    ),
                    Text(
                      active ? 'ACTIVE' : 'CLOSED',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: active
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(item['company']),
                const SizedBox(height: 10),
                Text(
                  '${item['duration']} • ${item['mode']} • ${item['stipend']}',
                  style: const TextStyle(
                    color: Color(0xFF66727F),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            item['active'] = !active;
                          });
                        },
                        child: Text(
                          active ? 'Close' : 'Activate',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          list.removeAt(index);
                        });
                      },
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
}

// ============================================================
// APPLICANTS
// ============================================================

class ApplicantsPage extends StatefulWidget {
  final List<Map<String, dynamic>> applicants;

  const ApplicantsPage({
    super.key,
    required this.applicants,
  });

  @override
  State<ApplicantsPage> createState() => _ApplicantsPageState();
}

class _ApplicantsPageState extends State<ApplicantsPage> {
  @override
  Widget build(BuildContext context) {
    return _simpleScaffold(
      'Applicants',
      ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.applicants.length,
        itemBuilder: (context, index) {
          final applicant = widget.applicants[index];

          return _card(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color(0xFFE5F5F5),
                      child: Icon(
                        Icons.person_outline,
                        color: Color(0xFF18A6A6),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            applicant['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            applicant['course'],
                            style: const TextStyle(
                              color: Color(0xFF66727F),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      applicant['status'],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: applicant['status'] == 'Accepted'
                            ? Colors.green
                            : applicant['status'] == 'Rejected'
                            ? Colors.red
                            : Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Internship: ${applicant['internship']}',
                ),
                const SizedBox(height: 5),
                Text(
                  'Skills: ${applicant['skills']}',
                  style: const TextStyle(
                    color: Color(0xFF66727F),
                    fontSize: 12,
                  ),
                ),
                if (applicant['status'] == 'Pending') ...[
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              applicant['status'] = 'Rejected';
                            });
                          },
                          child: const Text('Reject'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              applicant['status'] = 'Accepted';
                            });
                          },
                          child: const Text('Accept'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// TASKS
// ============================================================

class TasksPage extends StatefulWidget {
  final List<Map<String, dynamic>> tasks;

  const TasksPage({
    super.key,
    required this.tasks,
  });

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  void addTask() {
    final student = TextEditingController();
    final task = TextEditingController();
    final deadline = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Assign Task'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: student,
                decoration: const InputDecoration(
                  labelText: 'Student Name',
                ),
              ),
              TextField(
                controller: task,
                decoration: const InputDecoration(
                  labelText: 'Task',
                ),
              ),
              TextField(
                controller: deadline,
                decoration: const InputDecoration(
                  labelText: 'Deadline',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (student.text.isNotEmpty &&
                  task.text.isNotEmpty) {
                setState(() {
                  widget.tasks.add({
                    'student': student.text,
                    'title': task.text,
                    'deadline': deadline.text.isEmpty
                        ? 'Not specified'
                        : deadline.text,
                    'status': 'Pending',
                  });
                });

                Navigator.pop(context);
              }
            },
            child: const Text('Assign'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _simpleScaffold(
      'Assign Tasks',
      Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
            itemCount: widget.tasks.length,
            itemBuilder: (context, index) {
              final task = widget.tasks[index];

              return _card(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      task['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF123B5D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Student: ${task['student']}'),
                    Text('Deadline: ${task['deadline']}'),
                    const SizedBox(height: 8),
                    Text(
                      task['status'],
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton.extended(
              backgroundColor: const Color(0xFF123B5D),
              foregroundColor: Colors.white,
              onPressed: addTask,
              icon: const Icon(Icons.add),
              label: const Text('Assign Task'),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// FEEDBACK
// ============================================================

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  double rating = 4;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _formPage(
      title: 'Intern Feedback',
      children: [
        _field(
          TextEditingController(),
          'Student Name',
          Icons.person_outline,
        ),
        const SizedBox(height: 15),
        const Text(
          'Rating',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        Slider(
          value: rating,
          min: 1,
          max: 5,
          divisions: 4,
          label: rating.toString(),
          activeColor: const Color(0xFF18A6A6),
          onChanged: (value) {
            setState(() => rating = value);
          },
        ),
        Center(
          child: Text(
            '${rating.toStringAsFixed(0)} / 5',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF123B5D),
            ),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: controller,
          maxLines: 5,
          decoration: _inputDecoration(
            'Feedback',
            Icons.rate_review_outlined,
          ),
        ),
        const SizedBox(height: 22),
        _primaryButton(
          'Submit Feedback',
              () {
            _showGlobalMessage(
              context,
              'Feedback submitted successfully.',
            );
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

// ============================================================
// ANNOUNCEMENTS
// ============================================================

class AnnouncementsPage extends StatefulWidget {
  final List<Map<String, dynamic>>? announcements;

  const AnnouncementsPage({
    super.key,
    this.announcements,
  });

  @override
  State<AnnouncementsPage> createState() =>
      _AnnouncementsPageState();
}

class _AnnouncementsPageState
    extends State<AnnouncementsPage> {
  late List<Map<String, dynamic>> list;

  @override
  void initState() {
    super.initState();

    list = widget.announcements ??
        [
          {
            'title': 'Welcome to InternNova',
            'message':
            'Please check your assigned internship tasks regularly.',
            'date': '10 Aug 2026',
          },
        ];
  }

  void addAnnouncement() {
    final title = TextEditingController();
    final message = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Announcement'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: message,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Message',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (title.text.isNotEmpty &&
                  message.text.isNotEmpty) {
                setState(() {
                  list.insert(0, {
                    'title': title.text,
                    'message': message.text,
                    'date': 'Today',
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Publish'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _simpleScaffold(
      'Announcements',
      Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];

              return _card(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.campaign_outlined,
                          color: Color(0xFF18A6A6),
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            item['title'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF123B5D),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Text(item['message']),
                    const SizedBox(height: 9),
                    Text(
                      item['date'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF66727F),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton.extended(
              backgroundColor: const Color(0xFF123B5D),
              foregroundColor: Colors.white,
              onPressed: addAnnouncement,
              icon: const Icon(Icons.add),
              label: const Text('Announcement'),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LEAVE REQUESTS
// ============================================================

class LeaveRequestsPage extends StatefulWidget {
  final List<Map<String, dynamic>> requests;

  const LeaveRequestsPage({
    super.key,
    required this.requests,
  });

  @override
  State<LeaveRequestsPage> createState() =>
      _LeaveRequestsPageState();
}

class _LeaveRequestsPageState
    extends State<LeaveRequestsPage> {
  @override
  Widget build(BuildContext context) {
    return _simpleScaffold(
      'Leave Requests',
      ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.requests.length,
        itemBuilder: (context, index) {
          final request = widget.requests[index];

          return _card(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  request['student'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF123B5D),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Reason: ${request['reason']}'),
                Text('Date: ${request['date']}'),
                const SizedBox(height: 10),
                Text(
                  request['status'],
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: request['status'] == 'Approved'
                        ? Colors.green
                        : request['status'] == 'Rejected'
                        ? Colors.red
                        : Colors.orange,
                  ),
                ),
                if (request['status'] == 'Pending') ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              request['status'] = 'Rejected';
                            });
                          },
                          child: const Text('Reject'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              request['status'] = 'Approved';
                            });
                          },
                          child: const Text('Approve'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// NOTIFICATIONS
// ============================================================

class NotificationsPage extends StatelessWidget {
  final List<String>? notifications;

  const NotificationsPage({
    super.key,
    this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    final items = notifications ??
        const [
          'New internship application received.',
          'New task submission received.',
          'New leave request received.',
        ];

    return _simpleScaffold(
      'Notifications',
      ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _card(
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFE5F5F5),
                  child: Icon(
                    Icons.notifications_none,
                    color: Color(0xFF18A6A6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    items[index],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// PROFILE
// ============================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _simpleScaffold(
      'Mentor Profile',
      ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const CircleAvatar(
            radius: 42,
            backgroundColor: Color(0xFFE5F5F5),
            child: Icon(
              Icons.person,
              size: 45,
              color: Color(0xFF18A6A6),
            ),
          ),
          const SizedBox(height: 15),
          const Center(
            child: Text(
              'Mentor',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF123B5D),
              ),
            ),
          ),
          const SizedBox(height: 25),
          _profileTile(
            Icons.person_outline,
            'Name',
            'InternNova Mentor',
          ),
          _profileTile(
            Icons.business_outlined,
            'Company',
            'InternNova Technologies',
          ),
          _profileTile(
            Icons.email_outlined,
            'Email',
            'mentor@internnova.com',
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              _showGlobalMessage(
                context,
                'Logout functionality will be connected with authentication.',
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF123B5D),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileTile(
      IconData icon,
      String title,
      String value,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFFE2E8ED),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF18A6A6),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF66727F),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SHARED UI HELPERS
// ============================================================

Widget _simpleScaffold(
    String title,
    Widget body,
    ) {
  return Scaffold(
    backgroundColor: const Color(0xFFF5F8FA),
    appBar: AppBar(
      backgroundColor: const Color(0xFF123B5D),
      foregroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    body: body,
  );
}

Widget _card({
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: const Color(0xFFE2E8ED),
      ),
    ),
    child: child,
  );
}

Widget _formPage({
  required String title,
  required List<Widget> children,
}) {
  return Scaffold(
    backgroundColor: const Color(0xFFF5F8FA),
    appBar: AppBar(
      backgroundColor: const Color(0xFF123B5D),
      foregroundColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: children,
      ),
    ),
  );
}

Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
      int lines = 1,
      bool required = true,
    }) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextField(
      controller: controller,
      maxLines: lines,
      decoration: _inputDecoration(label, icon),
    ),
  );
}

InputDecoration _inputDecoration(
    String label,
    IconData icon,
    ) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      icon,
      color: const Color(0xFF18A6A6),
    ),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFFE2E8ED),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFF18A6A6),
        width: 1.5,
      ),
    ),
  );
}

Widget _primaryButton(
    String text,
    VoidCallback onPressed,
    ) {
  return SizedBox(
    width: double.infinity,
    height: 52,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF123B5D),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

void _showGlobalMessage(
    BuildContext context,
    String message,
    ) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}