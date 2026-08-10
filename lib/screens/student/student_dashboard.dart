import 'package:flutter/material.dart';

import 'applications_screen.dart';
import 'internships_screen.dart';
import 'profile_screen.dart';
import 'tasks_screen.dart';

class StudentDashboard extends StatelessWidget {
const StudentDashboard({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFFF5F7FB),


  // ---------------- APP BAR ----------------
  appBar: AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    title: const Text(
      'Student Dashboard',
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

  // ---------------- BODY ----------------
  body: SingleChildScrollView(
    padding: const EdgeInsets.all(20),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        // ---------------- WELCOME CARD ----------------
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),

          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF2563EB),
                Color(0xFF4F46E5),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),

          child: const Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Icon(
                Icons.school_outlined,
                color: Colors.white,
                size: 40,
              ),

              SizedBox(height: 15),

              Text(
                'Welcome, Student!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                'Find internships, manage applications and track your tasks.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        // ---------------- QUICK ACCESS ----------------
        const Text(
          'Quick Access',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        // ---------------- FIRST ROW ----------------
        Row(
          children: [

            // INTERNSHIPS
            Expanded(
              child: _dashboardCard(
                context,

                icon: Icons.work_outline,

                title: 'Internships',

                subtitle:
                    'Browse internships',

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const InternshipsScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 15),

            // APPLICATIONS
            Expanded(
              child: _dashboardCard(
                context,

                icon:
                    Icons.description_outlined,

                title: 'Applications',

                subtitle:
                    'Track applications',

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ApplicationsScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        // ---------------- SECOND ROW ----------------
        Row(
          children: [

            // MY TASKS
            Expanded(
              child: _dashboardCard(
                context,

                icon: Icons.task_alt,

                title: 'My Tasks',

                subtitle:
                    'View assigned tasks',

                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          const TasksScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 15),

            // PROFILE
            Expanded(
              child: _dashboardCard(
                context,

                icon:
                    Icons.person_outline,

                title: 'Profile',

                subtitle:
                    'Manage your profile',

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ProfileScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        // ---------------- MY INTERNSHIP ----------------
        const Text(
          'My Internship',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(18),

            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withValues(
                  alpha: 0.05,
                ),
                blurRadius: 10,
                offset:
                    const Offset(0, 4),
              ),
            ],
          ),

          child: const Column(
            children: [

              Icon(
                Icons.business_center_outlined,
                size: 45,
                color: Color(0xFF2563EB),
              ),

              SizedBox(height: 12),

              Text(
                'No Active Internship',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                'Apply for an internship to see your internship details here.',
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // ---------------- NEED HELP ----------------
        const Text(
          'Need Help?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(18),
          ),

          child: const Row(
            children: [

              CircleAvatar(
                radius: 25,

                backgroundColor:
                    Color(0xFFE0E7FF),

                child: Icon(
                  Icons.support_agent,
                  color:
                      Color(0xFF4F46E5),
                ),
              ),

              SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      'Contact your mentor',

                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      'Your mentor can help you with internship-related queries.',

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),

  // ---------------- BOTTOM NAVIGATION ----------------
  bottomNavigationBar:
      BottomNavigationBar(
    currentIndex: 0,

    type:
        BottomNavigationBarType.fixed,

    selectedItemColor:
        const Color(0xFF2563EB),

    unselectedItemColor:
        Colors.grey,

    onTap: (index) {

      if (index == 0) {
        return;
      }

      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const InternshipsScreen(),
          ),
        );
      }

      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const ApplicationsScreen(),
          ),
        );
      }

      if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const ProfileScreen(),
          ),
        );
      }
    },

    items: const [

      BottomNavigationBarItem(
        icon:
            Icon(Icons.dashboard_outlined),
        label: 'Home',
      ),

      BottomNavigationBarItem(
        icon:
            Icon(Icons.work_outline),
        label: 'Internships',
      ),

      BottomNavigationBarItem(
        icon:
            Icon(Icons.description_outlined),
        label: 'Applications',
      ),

      BottomNavigationBarItem(
        icon:
            Icon(Icons.person_outline),
        label: 'Profile',
      ),
    ],
  ),
);

}

// ---------------- DASHBOARD CARD ----------------
static Widget _dashboardCard(
BuildContext context, {
required IconData icon,
required String title,
required String subtitle,
required VoidCallback onTap,
}) {
return Material(
color: Colors.transparent,


  child: InkWell(
    onTap: onTap,

    borderRadius:
        BorderRadius.circular(18),

    child: Container(
      padding:
          const EdgeInsets.all(18),

      height: 155,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(
              alpha: 0.05,
            ),

            blurRadius: 10,

            offset:
                const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Container(
            padding:
                const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color:
                  const Color(0xFFEFF6FF),

              borderRadius:
                  BorderRadius.circular(12),
            ),

            child: Icon(
              icon,

              color:
                  const Color(0xFF2563EB),

              size: 28,
            ),
          ),

          const Spacer(),

          Text(
            title,

            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,

              fontSize: 16,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            subtitle,

            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  ),
);


}
}
