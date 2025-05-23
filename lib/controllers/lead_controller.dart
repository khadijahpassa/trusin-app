// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:trusin_app/models/lead_model.dart';

// class LeadController extends GetxController {
//   var leadList = <LeadModel>[].obs;
//   var statusCount = getInitialStatusMap().obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchStatusCounts(); 
//     fetchLeads(); 
//   }

//   void fetchLeads() {
//     FirebaseFirestore.instance
//       .collection('customers')
//       .snapshots()
//       .listen((snapshot) {
//         leadList.value = mapSnapshotToLeads(snapshot);
//         print("Total Leads: ${leadList.length}");
//       });
//   }

//   Stream<List<LeadModel>> getLeadsByStatusStream(String status) {
//     return FirebaseFirestore.instance
//       .collection('customers')
//       .where('status', isEqualTo: status)
//       .snapshots()
//       .map(mapSnapshotToLeads);
//   }

//   void fetchStatusCounts() {
//     FirebaseFirestore.instance
//       .collection('customers')
//       .snapshots()
//       .listen((snapshot) {
//         final temp = getInitialStatusMap();

//         for (var doc in snapshot.docs) {
//           final status = doc['status'] ?? 'New Customer';
//           if (temp.containsKey(status)) {
//             temp[status] = temp[status]! + 1;
//           }
//         }

//         statusCount.value = temp;
//       });
//   }

//   // Helper static functions
//   static Map<String, int> getInitialStatusMap() => {
//     'New Customer': 0,
//     'Follow Up': 0,
//     'Send Quotation': 0,
//     'Won': 0,
//     'Rejected': 0,
//   };

//   static List<LeadModel> mapSnapshotToLeads(QuerySnapshot snapshot) {
//     return snapshot.docs
//       .map((doc) => LeadModel.fromMap(doc.data()! as Map<String, dynamic>))
//       .toList();
//   }
// }
