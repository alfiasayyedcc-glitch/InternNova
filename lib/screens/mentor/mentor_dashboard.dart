import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'add_internship_screen.dart';
import 'applicants_screen.dart';
import 'feedback_screen.dart';
import 'manage_internships_screen.dart';

class MentorDashboard extends StatelessWidget {
  const MentorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text(
          'Mentor Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // --------------------------------------------------
            // WELCOME CARD
            // --------------------------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3949AB),
                    Color(0xFF5C6BC0),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),

                  const SizedBox(width: 18),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, Mentor! 👋',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Manage internships and guide your students.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // --------------------------------------------------
            // OVERVIEW
            // --------------------------------------------------
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // --------------------------------------------------
            // LIVE INTERNSHIP COUNT
            // --------------------------------------------------
            StreamBuilder<QuerySnapshot>(
              stream: user == null
                  ? const Stream.empty()
                  : FirebaseFirestore.instance
                      .collection('internships')
                      .where(
                        'mentorId',
                        isEqualTo: user.uid,
                      )
                      .snapshots(),

              builder: (context, snapshot) {
                String internshipCount = '0';

                if (snapshot.hasData) {
                  internshipCount =
                      snapshot.data!.docs.length.toString();
                }

                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.45,
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),

                  children: [
                    _StatCard(
                      title: 'Internships',
                      value: internshipCount,
                      icon: Icons.work_outline,
                      iconColor: Colors.blue,
                    ),

                    const _StatCard(
                      title: 'Applicants',
                      value: '0',
                      icon: Icons.people_outline,
                      iconColor: Colors.orange,
                    ),

                    const _StatCard(
                      title: 'Accepted',
                      value: '0',
                      icon: Icons.check_circle_outline,
                      iconColor: Colors.green,
                    ),

                    const _StatCard(
                      title: 'Pending',
                      value: '0',
                      icon: Icons.pending_actions,
                      iconColor: Colors.purple,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 30),

            // --------------------------------------------------
            // QUICK ACTIONS
            // --------------------------------------------------
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _ActionCard(
              icon: Icons.add_business,
              title: 'Add Internship',
              subtitle:
                  'Create and publish a new internship',
              iconColor: Colors.blue,
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const AddInternshipScreen(),
                  ),
                );
              },
            ),

            _ActionCard(
              icon: Icons.work_history_outlined,
              title: 'Manage Internships',
              subtitle:
                  'View and manage your internships',
              iconColor: Colors.indigo,
             onTap: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return const ManageInternshipsScreen();
      },
    ),
  );
},
            ),

            _ActionCard(
  icon: Icons.people_alt_outlined,
  title: 'View Applicants',
  subtitle: 'Review internship applications',
  iconColor: Colors.orange,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ApplicantsScreen(),
      ),
    );
  },
),

            _ActionCard(
              icon: Icons.bar_chart,
              title: 'Student Progress',
              subtitle:
                  'Track student internship progress',
              iconColor: Colors.green,
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Student Progress screen will be connected next.',
                    ),
                  ),
                );
              },
            ),

            _ActionCard(
              icon: Icons.star_outline,
              title: 'Feedback',
              subtitle:
                  'Provide feedback to students',
              iconColor: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const FeedbackScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 25),

            // --------------------------------------------------
            // RECENT ACTIVITY
            // --------------------------------------------------
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: 0.05,
                    ),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.history,
                    size: 50,
                    color: Colors.grey.shade400,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'No recent activity',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Your internship activities will appear here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// STAT CARD
// ============================================================

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 26,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
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

// ============================================================
// ACTION CARD
// ============================================================

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),

        leading: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 17,
        ),

        onTap: onTap,
      ),
    );
  }
}