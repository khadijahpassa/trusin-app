import 'package:cloud_firestore/cloud_firestore.dart';

class LeadModel {
  final String name;
  final String phone;
  final String email;
  final String source;
  final DateTime createdOn;
  final String createdBy;
  final String status;
  final String title;
  final String address;
  final String reminderDate;

  LeadModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.source,
    required this.createdOn,
    required this.createdBy,
    required this.status,
    required this.title,
    required this.address,
    required this.reminderDate,
  });

  factory LeadModel.fromMap(Map<String, dynamic> map) {
    return LeadModel(
      name: map['name'] ?? '-',
      phone: map['phone'] ?? '-',
      email: map['email'] ?? '-',
      source: map['source'] ?? '-',
      createdOn: (map['createdOn'] as Timestamp).toDate(),
      createdBy: map['createdBy'] ?? '-',
      status: map['status'] ?? '-',
      title: map['title'] ?? '-',
      address: map['address'] ?? '-',
      reminderDate: map['reminderDate'] ?? '-',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'source': source,
      'createdOn': createdOn,
      'createdBy': createdBy,
      'status': status,
      'title': title,
      'address': address,
      'reminderDate': reminderDate,
    };
  }
}
