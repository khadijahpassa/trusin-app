import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trusin_app/models/lead_list_model.dart';
import 'package:trusin_app/service/notification_service.dart';

class LeadListController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? currentUid;

  var selectedLead = Rxn<LeadModel>();
  var leadList = <LeadModel>[].obs;
  final isLoading = true.obs;

  StreamSubscription? _leadStreamSubscription;

  var statusCount = <String, int>{
    'New Customer': 0,
    'Follow Up': 0,
    'Send Quotation': 0,
    'Won': 0,
    'Rejected': 0,
  }.obs;

  void init() async {
    isLoading.value = true;
    print("🔥 INIT Controller.");

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("⚠️ UID NULL. Delay 500ms...");
      await Future.delayed(const Duration(milliseconds: 500));
      final retryUser = FirebaseAuth.instance.currentUser;
      if (retryUser == null) {
        print("⛔ UID tetap null setelah delay.");
        isLoading.value = false;
        return;
      } else {
        currentUid = retryUser.uid;
      }
    } else {
      currentUid = user.uid;
    }

    print("✅ UID Ready: $currentUid");

    _startLeadStream();
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
  }

  void _startLeadStream() {
    _leadStreamSubscription = _firestore
        .collection('customers')
        .where('createdBy', isEqualTo: currentUid)
        .snapshots()
        .listen((snapshot) {
      leadList.value =
          snapshot.docs.map((doc) => LeadModel.fromDocument(doc)).toList();

      print("📡 DATA LEAD STREAMED: ${leadList.length}");
    }, onError: (e) {
      print("🔥 ERROR DI STREAM LEADS: $e");
    });
  }

  @override
  void onClose() {
    _leadStreamSubscription?.cancel();
    super.onClose();
  }

  Stream<List<LeadModel>> get leadStream {
    if (currentUid == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection('customers')
        .where('createdBy', isEqualTo: currentUid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => LeadModel.fromDocument(doc)).toList());
  }

  void streamLeadById(String id) {
    _firestore.collection('customers').doc(id).snapshots().listen((doc) {
      if (doc.exists) {
        selectedLead.value = LeadModel.fromDocument(doc);
      }
    });
  }

  Map<String, int> calculateStatusCount() {
    final Map<String, int> result = {
      'New Customer': 0,
      'Follow Up': 0,
      'Send Quotation': 0,
      'Won': 0,
      'Rejected': 0,
    };

    for (var lead in leadList) {
      final status = lead.status;
      result[status] = (result[status] ?? 0) + 1;
    }

    return result;
  }


  Future<void> fetchLeadById(String leadId) async {
  try {
    final doc = await _firestore.collection('customers').doc(leadId).get();
    if (doc.exists) {
      selectedLead.value = LeadModel.fromDocument(doc);
      print("✅ selectedLead refreshed setelah update.");
    }
  } catch (e) {
    print("❌ Gagal fetch lead by ID: $e");
  }
}

  // Buat widget Data: hitung status per CS

  // Future<Map<String, int>> getStatusCountByCS(String csId) async {
  //   try {
  //     final snapshot = await _firestore
  //         .collection('customers')
  //         .where('createdBy', isEqualTo: csId)
  //         .get();

  //   for (var lead in leadList) {
  //     final status = lead.status ?? 'Unknown';
  //     result[status] = (result[status] ?? 0) + 1;
  //   }

  //   return result;
  // }
  // }

  Future<List<LeadModel>> getLeadsByStatusAndCS(
      String status, String csId) async {
    try {
      final snapshot = await _firestore
          .collection('customers')
          .where('status', isEqualTo: status)
          .where('createdBy', isEqualTo: csId)
          .get();

      return snapshot.docs.map((doc) => LeadModel.fromDocument(doc)).toList();
    } catch (e) {
      print("Error getLeadsByStatusAndCS: $e");
      return [];
    }
  }

  Future<void> updateReminder(
      String leadId, DateTime reminderDate, String reminderCategory) async {
    try {
      await _firestore.collection('customers').doc(leadId).update({
        'reminderDate': reminderDate,
        'reminderCategory': reminderCategory,
      });
      print('Reminder updated!');
    } catch (e) {
      print('Error update reminder: $e');
      throw e;
    }
  }

  Future<void> updateStatus(String leadId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(leadId)
          .update({'status': newStatus});

      final controller = Get.find<LeadListController>();
      controller.init();
      print('Lead ID: ${leadId} | Status Baru: $newStatus');
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui status $e');
    }
  }
  // Future<DocumentSnapshot> getLeadById(String leadId) async {
  //   return await FirebaseFirestore.instance
  //       .collection('customers')
  //       .doc(leadId)
  //       .get();
  // }

  void scheduleRemindersForCS(String csId) async {
    final leadsSnapshot = await FirebaseFirestore.instance
        .collection('customers')
        .where('createdBy', isEqualTo: csId)
        .get();

    for (var doc in leadsSnapshot.docs) {
      final lead = LeadModel.fromDocument(doc);

      // Pastikan reminderDate tidak null dan masih di masa depan
      if (lead.reminderDate.isAfter(DateTime.now())) {
        final reminderDate = (lead.reminderDate as Timestamp).toDate();

        await NotificationService.scheduleNotification(
          id: lead.id.hashCode,
          title: "Reminder Lead",
          body:
              "Reminder: ${lead.reminderCategory} - ${lead.name}",
          scheduledDate: lead.reminderDate,
        );
        print('Scheduling notification at $reminderDate for ${lead.name}');
      }
    }
  }
}