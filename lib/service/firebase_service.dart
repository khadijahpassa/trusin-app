import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trusin_app/models/company_request.dart';

class FirebaseService {
  final _collection = FirebaseFirestore.instance.collection('companyRequests');

  Future<List<CompanyRequest>> fetchRequests() async {
    final snapshot = await _collection.get();
    return snapshot.docs.map((doc) => CompanyRequest.fromMap(doc.data(), doc.id)).toList();
  }
}
