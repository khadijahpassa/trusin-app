// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:trusin_app/model/lead_list_model.dart';

// Future<List<LeadModel>> fetchRemindersForUser(String companyName, String csId) async {
//   final snapshot = await FirebaseFirestore.instance
//     .collection('customers')
//     .where('companyName', isEqualTo: companyName)
//     .where('createdBy', isEqualTo: csId)
//     .where('reminderDate', isGreaterThan: Timestamp.now())
//     .get();

//   return snapshot.docs.map((doc) => LeadModel.fromFirestore(doc)).toList();
// }

