import 'package:cloud_firestore/cloud_firestore.dart';

// file untuk mengambil data dari firebase
class StatistikService {
  final _firestore = FirebaseFirestore.instance;

  // UNTUK PERUSAHAAN
  Stream<int> getTotalPerusahaanByStatus(String status) {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'supervisor')
        .where('status', isEqualTo: status)
        .snapshots()
        .map((snapshot) => snapshot.size);
  }


  // UNTUK SPV & CS
  Stream<int> getTotalSupervisorAndCS() {
    return _firestore
      .collection('users')
      .where('role', whereIn: ['supervisor', 'customer_service'])
      .snapshots()
      .map((snapshot) => snapshot.size);
  }
}