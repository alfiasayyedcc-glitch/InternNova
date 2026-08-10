import 'package:cloud_firestore/cloud_firestore.dart';

class InternshipModel {
  final String id;
  final String mentorId;
  final String mentorEmail;

  final String companyName;
  final String title;
  final String location;
  final String duration;

  final String description;
  final int seats;
  final String skills;
  final String status;
  final String stipend;

  final DateTime createdAt;

  InternshipModel({
    this.id = '',
    required this.mentorId,
    required this.mentorEmail,
    required this.companyName,
    required this.title,
    required this.location,
    required this.duration,
    this.description = '',
    this.seats = 1,
    this.skills = '',
    this.status = 'active',
    this.stipend = '',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // ------------------------------------------------------------
  // Convert model to Firestore
  // ------------------------------------------------------------

  Map<String, dynamic> toMap() {
    return {
      'mentorId': mentorId,
      'mentorEmail': mentorEmail,
      'companyName': companyName,
      'title': title,
      'location': location,
      'duration': duration,
      'description': description,
      'seats': seats,
      'skills': skills,
      'status': status,
      'stipend': stipend,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // ------------------------------------------------------------
  // Create model from Firestore
  // ------------------------------------------------------------

  factory InternshipModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    DateTime createdDate = DateTime.now();

    final createdAtValue = map['createdAt'];

    if (createdAtValue is Timestamp) {
      createdDate = createdAtValue.toDate();
    } else if (createdAtValue is DateTime) {
      createdDate = createdAtValue;
    }

    return InternshipModel(
      id: id,
      mentorId: map['mentorId'] ?? '',
      mentorEmail: map['mentorEmail'] ?? '',
      companyName: map['companyName'] ?? '',
      title: map['title'] ?? '',
      location: map['location'] ?? '',
      duration: map['duration'] ?? '',
      description: map['description'] ?? '',
      seats: _parseInt(map['seats']),
      skills: map['skills'] ?? '',
      status: map['status'] ?? 'active',
      stipend: map['stipend'] ?? '',
      createdAt: createdDate,
    );
  }

  // ------------------------------------------------------------
  // Safely convert Firestore number values to int
  // ------------------------------------------------------------

  static int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is double) {
      return value.toInt();
    }

    if (value is String) {
      return int.tryParse(value) ?? 1;
    }

    return 1;
  }
}