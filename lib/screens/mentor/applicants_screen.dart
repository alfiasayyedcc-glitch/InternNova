import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApplicantsScreen extends StatelessWidget {
const ApplicantsScreen({super.key});

final Color backgroundColor = const Color(0xFFF5F7FB);

// Get student name from users collection
Future<String> _getStudentName(String studentId) async {
if (studentId.isEmpty) {
return 'Unknown Student';
}


final doc = await FirebaseFirestore.instance
    .collection('users')
    .doc(studentId)
    .get();

if (doc.exists) {
  final data = doc.data();

  return data?['name'] ?? 'Unknown Student';
}

return 'Unknown Student';


}

// Get internships belonging to logged-in mentor
Future<List<String>> _getMentorInternshipIds(
String mentorId) async {
final snapshot = await FirebaseFirestore.instance
.collection('internships')
.where('mentorId', isEqualTo: mentorId)
.get();


return snapshot.docs.map((doc) => doc.id).toList();

}

@override
Widget build(BuildContext context) {
final User? currentUser =
FirebaseAuth.instance.currentUser;


if (currentUser == null) {
  return const Scaffold(
    body: Center(
      child: Text(
        'Please login first.',
        style: TextStyle(fontSize: 18),
      ),
    ),
  );
}

final mentorId = currentUser.uid;

return Scaffold(
  backgroundColor: backgroundColor,

  appBar: AppBar(
    title: const Text(
      'Applicants',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),

  body: FutureBuilder<List<String>>(
    future: _getMentorInternshipIds(mentorId),

    builder: (context, internshipSnapshot) {

      // Loading internships
      if (internshipSnapshot.connectionState ==
          ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Error loading internships
      if (internshipSnapshot.hasError) {
        return Center(
          child: Text(
            'Error loading internships:\n${internshipSnapshot.error}',
            textAlign: TextAlign.center,
          ),
        );
      }

      final internshipIds =
          internshipSnapshot.data ?? [];

      // Mentor has no internships
      if (internshipIds.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              Icon(
                Icons.work_off_outlined,
                size: 70,
                color: Colors.grey,
              ),

              SizedBox(height: 15),

              Text(
                'No internships found',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 5),

              Text(
                'You have not posted any internships yet.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      }

      /*
       * Firestore whereIn supports a maximum of 30 values.
       * For a normal internship portal this should be enough.
       */
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('applications')
            .where(
              'internshipId',
              whereIn: internshipIds,
            )
            .snapshots(),

        builder: (context, applicationSnapshot) {

          // Loading applications
          if (applicationSnapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error
          if (applicationSnapshot.hasError) {
            return Center(
              child: Padding(
                padding:
                    const EdgeInsets.all(20),

                child: Text(
                  'Error loading applicants:\n\n${applicationSnapshot.error}',
                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            );
          }

          // No applications
          if (!applicationSnapshot.hasData ||
              applicationSnapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.people_outline,
                    size: 70,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 15),

                  Text(
                    'No applicants yet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    'Students who apply will appear here.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          final applicants =
              applicationSnapshot.data!.docs;

          return ListView.builder(
            padding:
                const EdgeInsets.all(20),

            itemCount: applicants.length,

            itemBuilder: (context, index) {

              final data =
                  applicants[index].data()
                      as Map<String, dynamic>;

              final studentId =
                  data['studentId'] ?? '';

              final studentEmail =
                  data['studentEmail'] ??
                      'No email';

              final internshipTitle =
                  data['internshipTitle'] ??
                      'Internship';

              final companyName =
                  data['companyName'] ??
                      'Company';

              final status =
                  data['status'] ??
                      'Pending';

              return FutureBuilder<String>(
                future:
                    _getStudentName(studentId),

                builder:
                    (context, studentSnapshot) {

                  final studentName =
                      studentSnapshot.data ??
                          'Loading...';

                  return Card(
                    margin:
                        const EdgeInsets.only(
                      bottom: 15,
                    ),

                    elevation: 2,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              15),
                    ),

                    child: Padding(
                      padding:
                          const EdgeInsets.all(
                              18),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          // Student
                          Row(
                            children: [

                              CircleAvatar(
                                radius: 28,

                                backgroundColor:
                                    Colors.blue
                                        .shade100,

                                child: Text(
                                  studentName
                                          .isNotEmpty
                                      ? studentName[
                                              0]
                                          .toUpperCase()
                                      : '?',

                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                    color: Colors
                                        .blue
                                        .shade700,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                  width: 15),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    Text(
                                      studentName,

                                      style:
                                          const TextStyle(
                                        fontSize: 18,
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),

                                    const SizedBox(
                                        height: 4),

                                    Text(
                                      studentEmail,

                                      style:
                                          const TextStyle(
                                        color:
                                            Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                              height: 18),

                          const Divider(),

                          const SizedBox(
                              height: 10),

                          // Internship
                          Row(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              const Icon(
                                Icons
                                    .work_outline,
                                color:
                                    Colors.blue,
                              ),

                              const SizedBox(
                                  width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    const Text(
                                      'Internship',
                                      style:
                                          TextStyle(
                                        color:
                                            Colors.grey,
                                        fontSize:
                                            13,
                                      ),
                                    ),

                                    const SizedBox(
                                        height: 3),

                                    Text(
                                      internshipTitle,

                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                        fontSize:
                                            16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                              height: 12),

                          // Company
                          Row(
                            children: [

                              const Icon(
                                Icons
                                    .business_outlined,
                                color:
                                    Colors.blue,
                              ),

                              const SizedBox(
                                  width: 10),

                              Expanded(
                                child: Text(
                                  companyName,

                                  style:
                                      const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                              height: 15),

                          // Status
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,

                            children: [

                              const Text(
                                'Application Status',

                                style:
                                    TextStyle(
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                              ),

                              Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal:
                                      12,
                                  vertical: 6,
                                ),

                                decoration:
                                    BoxDecoration(
                                  color: status ==
                                          'Accepted'
                                      ? Colors
                                          .green
                                          .shade100
                                      : status ==
                                              'Rejected'
                                          ? Colors
                                              .red
                                              .shade100
                                          : Colors
                                              .orange
                                              .shade100,

                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                              20),
                                ),

                                child: Text(
                                  status,

                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight
                                            .bold,

                                    color: status ==
                                            'Accepted'
                                        ? Colors
                                            .green
                                            .shade700
                                        : status ==
                                                'Rejected'
                                            ? Colors
                                                .red
                                                .shade700
                                            : Colors
                                                .orange
                                                .shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      );
    },
  ),
);

}
}
