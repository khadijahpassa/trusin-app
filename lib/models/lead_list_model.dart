import 'package:cloud_firestore/cloud_firestore.dart';

class LeadModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String source;
  final DateTime createdOn;
  final String createdBy;
  final String companyName;
  final String status;
  final String title;
  final String address;
  final DateTime reminderDate;
  final String reminderCategory;

  LeadModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.source,
    required this.createdOn,
    required this.createdBy,
    required this.companyName, 
    required this.status,
    required this.title,
    required this.address,
    required this.reminderDate,
    required this.reminderCategory,
  });

  factory LeadModel.fromDocument(DocumentSnapshot doc) {
  final map = doc.data() as Map<String, dynamic>;

  return LeadModel(
    id: doc.id,
    name: map['name'] ?? '-',
    phone: map['phone'] ?? '-',
    email: map['email'] ?? '-',
    source: map['source'] ?? '-',
    createdOn: (map['createdOn'] as Timestamp).toDate(),
    createdBy: map['createdBy'] ?? '-',
    companyName: map['companyName'] ?? '-',
    status: map['status'] ?? '-',
    title: map['title'] ?? '-',
    address: map['address'] ?? '-',
    reminderDate: (map['reminderDate'] as Timestamp).toDate(),
    reminderCategory: map['reminderCategory'] ?? '-',
  );
}

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
      'reminderCategory': reminderCategory,
    };
  }
}
