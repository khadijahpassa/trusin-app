import 'package:cloud_firestore/cloud_firestore.dart';

class QuotationModel {
  final String id;
  final String fromCompany;
  final String fromPhone;
  final String fromSocialMedia;
  final String fromAddress;
  final String toCompany;
  final String toSeller;
  final String toPhone;
  final String terms;
  final String bank;
  final String receiver;
  final String rekening;
  final String? logoImagePath;
  final DateTime? selectedDate;

  QuotationModel({
    required this.fromCompany,
    required this.fromPhone,
    required this.fromSocialMedia,
    required this.fromAddress,
    required this.toCompany,
    required this.toSeller,
    required this.toPhone,
    required this.terms,
    required this.bank,
    required this.receiver,
    required this.rekening,
    this.logoImagePath,
    this.selectedDate,
    required this.id,
  });

  factory QuotationModel.fromMap(Map<String, dynamic> map) {
    return QuotationModel(
      id: map['id'] ?? '-',
      fromCompany: map['fromCompany'] ?? '-',
      fromPhone: map['fromPhone'] ?? '-',
      fromSocialMedia: map['fromSocialMedia'] ?? '-',
      fromAddress: map['fromAddress'] ?? '-',
      toCompany: map['toCompany'] ?? '-',
      toSeller: map['toSeller'] ?? '-',
      toPhone: map['toPhone'] ?? '-',
      terms: map['terms'] ?? '-',
      bank: map['bank'] ?? '-',
      receiver: map['receiver'] ?? '-',
      rekening: map['rekening'] ?? '-',
      logoImagePath: map['logoImagePath'],
      selectedDate: map['selectedDate'] is Timestamp
        ? (map['selectedDate'] as Timestamp).toDate()
        : map['selectedDate'] is String
            ? DateTime.tryParse(map['selectedDate'])
            : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromCompany': fromCompany,
      'fromPhone': fromPhone,
      'fromSocialMedia': fromSocialMedia,
      'fromAddress': fromAddress,
      'toCompany': toCompany,
      'toSeller': toSeller,
      'toPhone': toPhone,
      'terms': terms,
      'bank': bank,
      'receiver': receiver,
      'rekening': rekening,
      'logoImagePath': logoImagePath,
      'selectedDate':
          selectedDate != null ? Timestamp.fromDate(selectedDate!) : null,
    };
  }
}