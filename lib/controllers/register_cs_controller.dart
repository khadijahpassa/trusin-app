import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterCsController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      // 1. Buat akun di Firebase Auth
      UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Ambil UID (User ID) unik dari akun Firebase Auth yang baru dibuat
      final user = userCredential.user;
      if (user == null) {
        throw Exception("User tidak ditemukan setelah registrasi");
      }
      String uid = user.uid;

      // 2. Simpan data ke Firestore
      await _firestore.collection('users').doc(uid).set({
        'id': uid,
        'name': name,
        'email': email,
        'phone': phone ?? '',
        'company': company,
        'username': '', // Kosong dulu, bisa diisi nanti oleh CS
        'role': 'customer_service',
        'displayRole': 'Customer Service',
        'status': 'approved',
      });

      isLoading.value = false;
      await _auth.signOut();
      Get.snackbar('Berhasil', 'Akun Customer Service berhasil dibuat');
      Get.offAllNamed('/supervisor-home');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Gagal', 'Terjadi kesalahan: ${e.toString()}');
    }
  }
}
