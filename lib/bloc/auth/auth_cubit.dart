import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthState {
  initial,
  loading,
  success,
  failure,
  usernameTaken,
  usernameAvailable,
  unauthenticated,
  pendingApproval,
  authenticated
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? currentRole;

  // LOGIN
  Future<void> login(String username, String password) async {
    emit(AuthState.loading);

    try {
      // Cari user by username
      final snapshot = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        emit(AuthState.failure);
        return;
      }

      final userData = snapshot.docs.first.data();
      final email = userData['email'];
      final role = (userData['role'] ?? '').toString().toLowerCase();
      final status = (userData['status'] ?? '').toString().toLowerCase();

      currentRole = role;

      // Login ke Firebase Auth
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kalau belum di-approve
      if (role != 'superadmin' && status != 'approved') {
        emit(AuthState.pendingApproval);
        return;
      }

      // Sudah approved atau superadmin
      emit(AuthState.authenticated);
    } catch (e) {
      emit(AuthState.failure);
    }
  }

  // CEK USERNAME
  Future<bool> checkUsernameAvailability(String username) async {
    emit(AuthState.loading);

    final snapshot = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    final isAvailable = snapshot.docs.isEmpty;

    if (isAvailable) {
      emit(AuthState.usernameAvailable);
    } else {
      emit(AuthState.usernameTaken);
    }

    return isAvailable;
  }

  // CEK APPROVAL STATUS (dipanggil dari splash screen atau waiting screen)
  Future<void> checkApprovalStatus() async {
    final user = _auth.currentUser;
    if (user == null) {
      emit(AuthState.unauthenticated);
      return;
    }

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    final data = userDoc.data();

    final role = (data?['role'] ?? '').toString().toLowerCase();
    final status = (data?['status'] ?? '').toString().toLowerCase();

    currentRole = role;

    if (role != 'superadmin' && status != 'approved') {
      emit(AuthState.pendingApproval);
    } else {
      emit(AuthState.authenticated);
    }
  }

  // LOGOUT
  // Future<void> logout() async {
  //   await _auth.signOut();
  //   currentRole = null;
  //   emit(AuthState.unauthenticated);
  // }
}
