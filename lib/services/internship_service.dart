
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/intern_model.dart';

class InternshipService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // ============================================================
  // ADD INTERNSHIP
  // ============================================================

  Future<void> addInternship(
    InternshipModel internship,
  ) async {
    await _firestore
        .collection('internships')
        .add({
      ...internship.toMap(),

      // Identify internships created through Admin
      'createdBy': 'admin',

      // Use Firebase server time
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // ============================================================
  // GET ACTIVE ADMIN INTERNSHIPS
  // ============================================================

  Stream<List<InternshipModel>> getInternships() {
    return _firestore
        .collection('internships')
        .where(
          'status',
          isEqualTo: 'active',
        )
        .where(
          'createdBy',
          isEqualTo: 'admin',
        )
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) {
            return snapshot.docs
                .map(
                  (doc) {
                    return InternshipModel.fromMap(
                      doc.id,
                      doc.data(),
                    );
                  },
                )
                .toList();
          },
        );
  }

  // ============================================================
  // GET INTERNSHIPS CREATED BY CURRENT MENTOR
  // ============================================================

  Stream<List<InternshipModel>>
      getMentorInternships() {
    final User? user =
        _auth.currentUser;

    if (user == null) {
      return Stream.value(
        <InternshipModel>[],
      );
    }

    return _firestore
        .collection('internships')
        .where(
          'mentorId',
          isEqualTo: user.uid,
        )
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) {
            return snapshot.docs
                .map(
                  (doc) {
                    return InternshipModel.fromMap(
                      doc.id,
                      doc.data(),
                    );
                  },
                )
                .toList();
          },
        );
  }

  // ============================================================
  // GET SINGLE INTERNSHIP
  // ============================================================

  Future<InternshipModel?>
      getInternship(
    String internshipId,
  ) async {
    final DocumentSnapshot<
        Map<String, dynamic>> doc =
        await _firestore
            .collection('internships')
            .doc(internshipId)
            .get();

    if (!doc.exists ||
        doc.data() == null) {
      return null;
    }

    return InternshipModel.fromMap(
      doc.id,
      doc.data()!,
    );
  }

  // ============================================================
  // UPDATE INTERNSHIP
  // ============================================================

  Future<void> updateInternship(
    String internshipId,
    Map<String, dynamic> data,
  ) async {
    await _firestore
        .collection('internships')
        .doc(internshipId)
        .update(data);
  }

  // ============================================================
  // DELETE INTERNSHIP
  // ============================================================

  Future<void> deleteInternship(
    String internshipId,
  ) async {
    await _firestore
        .collection('internships')
        .doc(internshipId)
        .delete();
  }

  // ============================================================
  // DEACTIVATE INTERNSHIP
  // ============================================================

  Future<void> deactivateInternship(
    String internshipId,
  ) async {
    await _firestore
        .collection('internships')
        .doc(internshipId)
        .update({
      'status': 'inactive',
    });
  }

  // ============================================================
  // ACTIVATE INTERNSHIP
  // ============================================================

  Future<void> activateInternship(
    String internshipId,
  ) async {
    await _firestore
        .collection('internships')
        .doc(internshipId)
        .update({
      'status': 'active',
    });
  }
}

