import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterSupervisorController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Status umum
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var errorMessage = ''.obs;


  Future<void> registerSupervisor({
    required String name,
    required String email,
    required String phone,
    required String company,
    required String companyType,
    required String username,
    required String password,
    required String displayRole,
  }) async {
    isLoading.value = true;
    isSuccess.value = false;
    errorMessage.value = '';

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'company': company,
        'companyType': companyType,
        'username': username,
        'role': 'supervisor',
        'displayRole': displayRole,
        'status': 'pending',
      });

      isSuccess.value = true;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

}
