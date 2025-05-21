import 'package:cloud_firestore/cloud_firestore.dart';

class LeadModel {
  final String name;
  final String phone;
  final String email;
  final String address;
  final String source;
  final DateTime createdOn;
  final String createdBy;
  final String status;
  final String title;
  final String reminderDate;

  LeadModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.source,
    required this.createdOn,
    required this.createdBy,
    required this.status,
    required this.title,
    required this.reminderDate,
  });

  factory LeadModel.fromMap(Map<String, dynamic> map) {
    return LeadModel(
      name: map['name'] ?? '-',
      phone: map['phone'] ?? '-',
      email: map['email'] ?? '-',
      address: map['address'] ?? '-',
      source: map['source'] ?? '-',
      createdOn: (map['createdOn'] as Timestamp).toDate(),
      createdBy: map['createdBy'] ?? '-',
      status: map['status'] ?? 'Unknown',
      title: map['title'] ?? '-',
      reminderDate: map['reminderDate'] ?? '-',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'source': source,
      'createdOn': createdOn,
      'createdBy': createdBy,
      'status': status,
      'title': title,
      'reminderDate': reminderDate,
    };
  }
}
