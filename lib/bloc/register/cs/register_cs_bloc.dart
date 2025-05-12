import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register_cs_event.dart';
import 'register_cs_state.dart';

class RegisterCsBloc extends Bloc<RegisterCsEvent, RegisterCsState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RegisterCsBloc() : super(RegisterCsInitial()) {
    on<RegisterCsSubmitted>(_onRegisterCsSubmitted);
  }

  Future<void> _onRegisterCsSubmitted(
    RegisterCsSubmitted event,
    Emitter<RegisterCsState> emit,
  ) async {
    emit(RegisterCsLoading());
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
        'username': event.username,
        'password': event.password,
        'role': 'Customer Service',
        'status': 'pending', // Harus disetujui supervisor
      });

      emit(RegisterCsSuccess());
    } catch (e) {
      emit(RegisterCsFailure(error: e.toString()));
    }
  }
}
