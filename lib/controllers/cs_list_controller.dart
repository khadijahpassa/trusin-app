import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:trusin_app/controllers/auth_controller.dart';
import 'package:trusin_app/models/cs_list_model.dart';

class CSListController extends GetxController {
  // tampung data yang sudah di-stream
  var csList = <CSModel>[].obs;
  Rx<CSModel?> selectedCS = Rx<CSModel?>(null);
  var searchQuery = ''.obs;
  // _csStream = sumber data stream-nya, yang berasal dari Firebase Firestore.
  Stream<List<CSModel>>? _csStream;

  StreamSubscription? _subscription;

  @override
  void onInit() {
    super.onInit();
    final company = Get.find<AuthController>().currentCompany.value;
    if (company.isNotEmpty) {
      listenToCS(company);
    }
  }

// Untuk panggil stream saat dapat company
  void listenToCS(String company) {
    _subscription?.cancel();
    _csStream = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'customer_service')
        .where('company', isEqualTo: company)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => CSModel.fromMap(doc.data())).toList());

    _subscription = _csStream!.listen((data) {
       print('🔄 Data CS masuk: ${data.length}');
      csList.value = data;
    });
  }

  @override
  void onClose() {
    _subscription?.cancel(); // biar gak memory leak
    super.onClose();
  }

  //PENCARIAN CASE-INSENSITIVE (BUAT SEARCH BAR NAMA CS)
  void setSearchQuery(String value) {
    searchQuery.value = value.toLowerCase();
  }

//GETTER UNTUK HASIL FILTER
  List<CSModel> get filteredCsList {
    if (searchQuery.isEmpty) {
      return csList;
    } else {
      return csList
          .where((cs) => cs.name.toLowerCase().contains(searchQuery.value))
          .toList();
    }
  }
}
