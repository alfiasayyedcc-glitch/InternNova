
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationModel {
  final String id;
  final String studentId;
  final String studentEmail;
  final String internshipId;
  final String internshipTitle;
  final String companyName;
  final String mentorId;
  final String status;
  final DateTime appliedAt;

  ApplicationModel({
    this.id = '',
    required this.studentId,
    required this.studentEmail,
    required this.internshipId,
    required this.internshipTitle,
    required this.companyName,
    this.mentorId = '',
    this.status = 'Pending',
    DateTime? appliedAt,
  }) : appliedAt = appliedAt ?? DateTime.now();

  // ============================================================
  // TO MAP
  // ============================================================

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'studentEmail': studentEmail,
      'internshipId': internshipId,
      'internshipTitle': internshipTitle,
      'companyName': companyName,
      'mentorId': mentorId,
      'status': status,
      'appliedAt': Timestamp.fromDate(appliedAt),
    };
  }

  // ============================================================
  // FROM MAP
  // ============================================================

  factory ApplicationModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    DateTime date = DateTime.now();

    final value = map['appliedAt'];

    if (value is Timestamp) {
      date = value.toDate();
    }

    return ApplicationModel(
      id: id,
      studentId: map['studentId'] ?? '',
      studentEmail: map['studentEmail'] ?? '',
      internshipId: map['internshipId'] ?? '',
      internshipTitle: map['internshipTitle'] ?? '',
      companyName: map['companyName'] ?? '',
      mentorId: map['mentorId'] ?? '',
      status: map['status'] ?? 'Pending',
      appliedAt: date,
    );
  }
}

