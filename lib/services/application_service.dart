import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/application_model.dart';

class ApplicationService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // ============================================================
  // APPLY FOR INTERNSHIP
  // ============================================================

  Future<void> applyForInternship({
    required String internshipId,
    required String internshipTitle,
    required String companyName,
  }) async {
    final User? user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    // Check if already applied
    final existing = await _firestore
        .collection('applications')
        .where('studentId', isEqualTo: user.uid)
        .where(
          'internshipId',
          isEqualTo: internshipId,
        )
        .get();

    if (existing.docs.isNotEmpty) {
      throw Exception(
        'You have already applied for this internship.',
      );
    }

    final application = ApplicationModel(
      studentId: user.uid,
      studentEmail: user.email ?? '',
      internshipId: internshipId,
      internshipTitle: internshipTitle,
      companyName: companyName,
      status: 'Pending',
      appliedAt: DateTime.now(),
    );

    await _firestore
        .collection('applications')
        .add(application.toMap());
  }

  // ============================================================
  // GET CURRENT STUDENT APPLICATIONS
  // ============================================================

  Stream<List<ApplicationModel>> getMyApplications() {
    final User? user = _auth.currentUser;

    if (user == null) {
      return Stream.value(<ApplicationModel>[]);
    }

    return _firestore
        .collection('applications')
        .where(
          'studentId',
          isEqualTo: user.uid,
        )
        .orderBy(
          'appliedAt',
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ApplicationModel.fromMap(
                  doc.id,
                  doc.data(),
                ),
              )
              .toList(),
        );
  }
}