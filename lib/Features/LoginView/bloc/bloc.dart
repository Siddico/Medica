import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical/Features/LoginView/auth.dart';
import 'package:medical/Features/LoginView/bloc/states.dart';
import 'package:medical/Models/doctor.dart';
import 'package:medical/Utils/session_manager.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit({required this.authRepository}) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final Doctor doctor = await authRepository.login(email, password);

      // Get the current user from Firebase Auth
      final User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Save login state to shared preferences
        await SessionManager.saveUserLoginState(
          userId: currentUser.uid,
          email: doctor.email,
          name: doctor.fullName,
          role: 'doctor',
        );
      }

      emit(LoginSuccess(doctor));
    } catch (e) {
      emit(LoginFailure("Invalid email or password"));
    }
  }
}
