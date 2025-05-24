import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:trusin_app/models/company_request.dart';

class VerifyController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  var requestList = <CompanyRequest>[].obs; // status pending/rejected
  var approvedCompanies = <CompanyRequest>[].obs; // status approved
  var selectedStatuses = <String, String>{}.obs; // untuk dropdown filter
  var selectedActionStatus = <String, String>{}.obs; // untuk simpan status company yg dipilih


  @override
  void onInit() {
    super.onInit();
    fetchRequests(); // buat pending
    fetchApprovedCompanies(); // buat approved
  }

  // DATA YANG MASIH PENDING
  void fetchRequests() {
  _firestore
      .collection('users')
      .where('role', isEqualTo: 'supervisor')
      .snapshots()
      .listen((snapshot) {
    final requests = snapshot.docs
        .where((doc) {
          final status = (doc['status'] ?? '').toLowerCase();
          return status == 'pending' || status == 'rejected';
        })
        .map((doc) => CompanyRequest.fromMap(doc.data(), doc.id))
        .toList();

    requestList.value = requests;
  });
}

  // AMBIL DATA YANG UDAH DI APPROVED
  void fetchApprovedCompanies() {
    _firestore
        .collection('users')
        .where('role', isEqualTo: 'supervisor')
        .snapshots()
        .listen((snapshot) {
      final companies = snapshot.docs
    .where((doc) => (doc['status'] ?? '').toLowerCase() == 'approved')
    .map((doc) => CompanyRequest.fromMap(doc.data(), doc.id))
    .toList();

    approvedCompanies.value = companies;
    });
  }

  // UPDATE STATUS LOKAL DI UI
  void updateRequestStatus(String id, String newStatus) {
    final index = requestList.indexWhere((e) => e.id == id);
    if (index != -1) {
      final updated = CompanyRequest(
        id: requestList[index].id,
        companyName: requestList[index].companyName,
        supervisorName: requestList[index].supervisorName,
        status: newStatus,
        email: '',
        phone: '',
        alamat: '',
      );
      requestList[index] = updated;
      requestList.refresh();
    }
  }

  // NGEPUSH DI FIREBASE
  Future<void> submitStatusChange(String id, String newStatus) async {
    await _firestore.collection('users').doc(id).update({
      'status': newStatus,
    });

    // Refresh ulang semua list
    fetchRequests();            
    fetchApprovedCompanies();   
  }
}
