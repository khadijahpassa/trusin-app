import 'dart:async';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trusin_app/models/lead_list_model.dart';

class LeadListController extends GetxController {
  var leadList = <LeadModel>[].obs;
  Stream<List<LeadModel>>? _csStream;

  StreamSubscription? _subscription;
  // RxList<LeadModel> leadListStatus = <LeadModel>[].obs;
  var statusCount = <String, int>{
    'New Customer': 0,
    'Follow Up': 0,
    'Send Quotation': 0,
    'Won': 0,
    'Rejected': 0,
  }.obs;



  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchLeads();
  // }

  // //FETCH DATA DARI FIRESTORE
  // Future<void> fetchLeads() async {
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection('customers')
  //       .get();
  //   leadList.value = snapshot.docs
  //       .map((doc) => LeadModel.fromMap(doc.data() as Map<String, dynamic>))
  //       .toList();

  //   print("DATA LEAD DITEMUKAN: ${leadList.length}");
  // }

  // Buat widget Data: hitung status per CS
  Future<Map<String, int>> getStatusCountByCS(String csId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('customers')
          .where('createdBy', isEqualTo: csId)
          .get();

      final Map<String, int> result = {};
      for (var doc in snapshot.docs) {
        final status = doc['status'] ?? 'Unknown';
        result[status] = (result[status] ?? 0) + 1;
      }
      return result;
    } catch (e) {
      print('Error getStatusCountByCS: $e');
      return {};
    }
  }

  // Buat widget ProgressLeads: filter berdasarkan status & CS
  Future<List<LeadModel>> getLeadsByStatusAndCS(
      String status, String csId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('customers')
          .where('status', isEqualTo: status)
          .where('createdBy', isEqualTo: csId)
          .get();

      return snapshot.docs.map((doc) => LeadModel.fromMap(doc.data())).toList();
    } catch (e) {
      print("Error getLeadsByStatusAndCS: $e");
      return [];
    }
  }

  
}
