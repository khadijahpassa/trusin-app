import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterCsController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Status umum
  var isLoading = false.obs;

  Future<void> registerCS({
    required String name,
    required String email,
    String? phone,
    required String company,
    required String password,
  }) async {
    isLoading.value = true;

    try {
      // 1. Buat akun di Firebase
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Simpan data ke Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone ?? '',
        'company': company,
        'password': password,
        'role': 'Customer Service',
        'status': 'approved', // langsung approved karena dibuat spv
      });

      isLoading.value = false;
      Get.snackbar('Berhasil', 'Akun Customer Service berhasil dibuat');
      Get.offAllNamed('/supervisor-home');//navigasi ke halaman lain
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Gagal', 'Terjadi kesalahan: ${e.toString()}');
    }
  }
}
