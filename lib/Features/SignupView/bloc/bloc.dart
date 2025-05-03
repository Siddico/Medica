import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/Features/SignupView/bloc/states_doctor.dart';
import 'package:medical/Utils/session_manager.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signupWithEmail({
    required String fullName,
    required String email,
    required String specialization,
    required String experienceYears,
    required String password,
  }) async {
    emit(SignupLoading());
    try {
      log('Starting signup process...');

      // Validate inputs
      if (fullName.isEmpty ||
          email.isEmpty ||
          specialization.isEmpty ||
          experienceYears.isEmpty ||
          password.isEmpty) {
        log('Validation failed: Empty fields');
        emit(SignupFailure('All fields are required'));
        return;
      }

      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        log('Validation failed: Invalid email format');
        emit(SignupFailure('Invalid email format'));
        return;
      }

      if (password.length < 6) {
        log('Validation failed: Password too short');
        emit(SignupFailure('Password must be at least 6 characters'));
        return;
      }

      // Check if Firestore is accessible before creating the user
      try {
        await _firestore.collection('doctors').limit(1).get();
        log('Firestore connection verified');
      } catch (firestoreConnectionError) {
        log('Error connecting to Firestore: $firestoreConnectionError');
        emit(
          SignupFailure(
            'Cannot connect to database. Please check your internet connection.',
          ),
        );
        return;
      }

      log('Creating user with Firebase Auth...');
      // Create user with email and password
      UserCredential userCredential;
      try {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } catch (authError) {
        log('Error creating user: $authError');
        if (authError is FirebaseAuthException) {
          switch (authError.code) {
            case 'email-already-in-use':
              emit(SignupFailure('This email is already registered'));
              break;
            case 'invalid-email':
              emit(SignupFailure('The email address is not valid'));
              break;
            case 'operation-not-allowed':
              emit(SignupFailure('Email/password accounts are not enabled'));
              break;
            case 'weak-password':
              emit(SignupFailure('The password is too weak'));
              break;
            case 'network-request-failed':
              emit(
                SignupFailure('Network error. Please check your connection'),
              );
              break;
            default:
              emit(SignupFailure(authError.message ?? 'Authentication failed'));
          }
        } else {
          emit(
            SignupFailure('Failed to create account: ${authError.toString()}'),
          );
        }
        return;
      }

      if (userCredential.user == null) {
        log('User creation failed: user is null');
        emit(SignupFailure('Failed to create user account'));
        return;
      }

      log('User created successfully with UID: ${userCredential.user?.uid}');

      // Create a more detailed doctor document
      Map<String, dynamic> doctorData = {
        'fullName': fullName,
        'email': email,
        'specialization': specialization,
        'experienceYears': experienceYears,
        'createdAt': FieldValue.serverTimestamp(),
        'userId': userCredential.user!.uid,
        'profileComplete': true,
        'lastLogin': FieldValue.serverTimestamp(),
      };

      // Store doctor details in Firestore
      log('Storing doctor details in Firestore...');
      try {
        // First, ensure the collection exists
        CollectionReference doctorsCollection = _firestore.collection(
          'doctors',
        );

        // Set the document with the user's UID
        await doctorsCollection.doc(userCredential.user!.uid).set(doctorData);

        log('Doctor details stored successfully in Firestore');

        // Save login state to shared preferences
        await SessionManager.saveUserLoginState(
          userId: userCredential.user!.uid,
          email: email,
          name: fullName,
          role: 'doctor',
        );
        log('User login state saved to shared preferences');

        // Only emit success after Firestore operation completes
        emit(SignupSuccess());
        log('SignupSuccess state emitted');
      } catch (firestoreError) {
        log('Error storing doctor details in Firestore: $firestoreError');

        // Try one more time with a delay
        try {
          await Future.delayed(Duration(seconds: 1));
          await _firestore
              .collection('doctors')
              .doc(userCredential.user!.uid)
              .set(doctorData);
          log(
            'Doctor details stored successfully in Firestore on second attempt',
          );

          // Save login state to shared preferences
          await SessionManager.saveUserLoginState(
            userId: userCredential.user!.uid,
            email: email,
            name: fullName,
            role: 'doctor',
          );
          log('User login state saved to shared preferences on second attempt');

          emit(SignupSuccess());
          return;
        } catch (secondAttemptError) {
          log('Error on second attempt: $secondAttemptError');

          // If Firestore fails, we should still have the authentication account
          // but we need to inform the user of the partial failure
          emit(
            SignupFailure(
              'Account created but failed to save profile details. Please try logging in.',
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.code} - ${e.message}');
      String errorMessage = 'An error occurred during signup';

      // Provide more specific error messages
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password accounts are not enabled';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak';
          break;
        case 'network-request-failed':
          errorMessage = 'Network error. Please check your connection';
          break;
        default:
          errorMessage = e.message ?? errorMessage;
      }

      emit(SignupFailure(errorMessage));
    } catch (e) {
      log('Unexpected error during signup: $e');
      emit(SignupFailure('An unexpected error occurred. Please try again.'));
    }
  }
}
