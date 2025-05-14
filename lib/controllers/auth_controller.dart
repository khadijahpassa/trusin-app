import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:trusin_app/controllers/cs_list_controller.dart';
import 'package:trusin_app/model/user_model.dart';

enum UsernameCheckState {
  idle,
  checking,
  available,
  taken,
}

enum AuthState {
  initial,
  loading,
  success,
  failure,
  unauthenticated,
  pendingApproval,
  authenticated
}

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isEditing = false.obs;
  var currentRole = ''.obs; // Obs untuk menyimpan role pengguna
  // State utama login & auth / Menyimpan status autentikasi
  var authState = AuthState.initial.obs;
  // Status pengecekan USERNAME
  var usernameCheckState = UsernameCheckState.idle.obs;

  bool get isUsernameTaken =>
      usernameCheckState.value == UsernameCheckState.taken;

  // LOGIN
  Future<void> login(String usernameOrEmail, String password) async {
    authState.value = AuthState.loading;

    try {
      QuerySnapshot snapshot;

      // Cek apakah input usernameOrEmail berupa email atau username
      if (usernameOrEmail.contains('@')) {
        // Jika berupa email, cari berdasarkan email
        snapshot = await _firestore
            .collection('users')
            .where('email', isEqualTo: usernameOrEmail)
            .limit(1)
            .get();
      } else {
        // Jika berupa username, cari berdasarkan username
        snapshot = await _firestore
            .collection('users')
            .where('username', isEqualTo: usernameOrEmail)
            .limit(1)
            .get();
      }

      // Cek apakah dokumen ditemukan
      if (snapshot.docs.isEmpty) {
        authState.value = AuthState.failure;
        Get.snackbar("Gagal Login", "Akun tidak ditemukan.");
        return;
      }

      final doc = snapshot.docs.first;
      //karena pake QuerySnapshot, dan doc.data itu sendiri punya data
      //dalam bentuk Map<String, dynamic>,
      //jadi tambahin as Map<String, dynamic>
      final userData = doc.data() as Map<String, dynamic>;
      final email = userData['email'];
      final role = (userData['role'] ?? '').toString().toLowerCase();
      final status = (userData['status'] ?? '').toString().toLowerCase();
      // Setelah login berhasil dan data user diambil
      final company = userData['company'] ?? ''; // Ambil dari Firestore

      currentRole.value = role;

      // Panggil fetchCS dengan parameter company
      Get.find<CSListController>().listenToCS(company);

      // Login ke Firebase Auth
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Cek status approval
      if (role != 'superadmin' && status != 'approved') {
        authState.value = AuthState.pendingApproval;
        Get.snackbar("Login Error", "Akunmu belum diverifikasi oleh admin");
        return;
      }

      authState.value = AuthState.authenticated;
    } catch (e) {
      authState.value = AuthState.failure;
      Get.snackbar("Login Error", "Terjadi kesalahan saat login.");
    }
  }

  // CEK USERNAME
  Future<bool> checkUsernameAvailability(String username) async {
    usernameCheckState.value = UsernameCheckState.checking;

    final snapshot = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    final available = snapshot.docs.isEmpty;
    usernameCheckState.value =
        available ? UsernameCheckState.available : UsernameCheckState.taken;

    return available;
  }

  // CEK STATUS APPROVAL
  Future<void> checkApprovalStatus() async {
    final user = _auth.currentUser;
    if (user == null) {
      authState.value = AuthState.unauthenticated;
      return;
    }

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    final data = userDoc.data();

    final role = (data?['role'] ?? '').toString().toLowerCase();
    final status = (data?['status'] ?? '').toString().toLowerCase();

    currentRole.value = role;

    if (role != 'superadmin' && status != 'approved') {
      authState.value = AuthState.pendingApproval;
      Get.snackbar("Login Error", "Akunmu belum diverifikasi oleh admin");
    } else {
      authState.value = AuthState.authenticated;
    }
  }

  // GET DATA USER (name & displayRole)
  // var displayName = ''.obs;
  // var displayRole = ''.obs;

  var currentUser = Rxn<UserModel>();

  Future<void> fetchCurrentUserData() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    final data = doc.data();
    if (data != null) {
      // displayName.value = data['name'] ?? '';
      // displayRole.value = data['displayRole'] ?? '';
      currentUser.value = UserModel.fromMap(data);
    }
  }

  // GET DATA COMPANY SUPERVISOR (untuk diinsert ke field company register CS)
  var currentCompany = ''.obs; // Menyimpan company supervisor yang sedang login

  // Ambil company saat supervisor login
  Future<void> fetchSupervisorCompany() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    // Ambil data user dari Firestore
    final doc = await _firestore.collection('users').doc(user.uid).get();
    final data = doc.data();

    if (data != null && data['role'] == 'supervisor') {
      currentCompany.value =
          data['company']; // Ambil company dari data supervisor
    }
  }
}
