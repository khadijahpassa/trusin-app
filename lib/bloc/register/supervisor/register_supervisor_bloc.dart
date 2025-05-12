import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register_supervisor_event.dart';
import 'register_supervisor_state.dart';

class RegisterSupervisorBloc extends Bloc<RegisterSupervisorEvent, RegisterSupervisorState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RegisterSupervisorBloc() : super(RegisterSupervisorInitial()) {
    on<RegisterSupervisorSubmitted>(_onRegisterSupervisorSubmitted);
  }

  Future<void> _onRegisterSupervisorSubmitted(
    RegisterSupervisorSubmitted event,
    Emitter<RegisterSupervisorState> emit,
  ) async {
    emit(RegisterSupervisorLoading());
    try {
      // 1. Buat akun di Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // 2. Simpan data user di Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': event.name,
        'email': event.email,
        'phone': event.phone,
        'company': event.company,
        'companyType': event.companyType,
        'username': event.username,
        'password': event.password,
        'role': 'supervisor',
        'displayRole': event.displayRole,
        'status': 'pending', // Harus disetujui super admin
      });

      emit(RegisterSupervisorSuccess());
    } catch (e) {
      emit(RegisterSupervisorFailure(error: e.toString()));
    }
  }
}
