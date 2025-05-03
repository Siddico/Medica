import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical/Models/doctor.dart';
import 'package:medical/Utils/session_manager.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the current Firebase user
  User? get currentUser => _auth.currentUser;

  // Check if user is logged in
  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  // Login with email and password
  Future<Doctor> login(String email, String password) async {
    try {
      // Sign in with Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get doctor details from Firestore
      DocumentSnapshot doctorDoc =
          await _firestore
              .collection('doctors')
              .doc(userCredential.user!.uid)
              .get();

      if (doctorDoc.exists) {
        Map<String, dynamic> data = doctorDoc.data() as Map<String, dynamic>;

        // Create Doctor object from Firestore data
        return Doctor(
          fullName: data['fullName'] ?? '',
          email: data['email'] ?? '',
          specialization: data['specialization'] ?? '',
          experience: data['experienceYears'] ?? '',
          password: '', // We don't store or return the password
        );
      } else {
        throw Exception('Doctor profile not found');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Invalid email or password');
      } else if (e.code == 'user-disabled') {
        throw Exception('This account has been disabled');
      } else {
        throw Exception(e.message ?? 'Authentication failed');
      }
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      // Check if the email exists in Firestore
      QuerySnapshot userDocs =
          await _firestore
              .collection('doctors')
              .where('email', isEqualTo: email)
              .limit(1)
              .get();

      // Send password reset email using Firebase Auth
      await _auth.sendPasswordResetEmail(email: email);

      // For security reasons, we don't tell the user if the email exists or not
      // We just send the reset email if the account exists, or do nothing if it doesn't
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw Exception('The email address is not valid');
      } else if (e.code == 'user-not-found') {
        // For security reasons, we don't tell the user the email doesn't exist
        // Instead, we just say the reset link was sent (even though it wasn't)
      } else {
        throw Exception(e.message ?? 'Failed to send reset email');
      }
    } catch (e) {
      throw Exception('Failed to send reset email: ${e.toString()}');
    }
  }

  // Confirm password reset with code from email
  Future<void> confirmPasswordReset(String code, String newPassword) async {
    try {
      // Use Firebase Auth to confirm the password reset
      await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password is too weak');
      } else if (e.code == 'invalid-action-code') {
        throw Exception('The reset link is invalid or has expired');
      } else {
        throw Exception(e.message ?? 'Failed to reset password');
      }
    } catch (e) {
      throw Exception('Failed to reset password: ${e.toString()}');
    }
  }

  // Check if reset code is valid
  Future<bool> checkActionCode(String code) async {
    try {
      // Verify the password reset code
      await _auth.verifyPasswordResetCode(code);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-action-code') {
        throw Exception('The reset link is invalid or has expired');
      } else {
        throw Exception(e.message ?? 'Failed to verify reset link');
      }
    } catch (e) {
      throw Exception('Failed to verify reset link: ${e.toString()}');
    }
  }

  // Update password for logged in user
  Future<void> updatePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('No user is currently logged in');
      }

      // Re-authenticate user before changing password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password is too weak');
      } else if (e.code == 'requires-recent-login') {
        throw Exception('Please log in again before changing your password');
      } else if (e.code == 'wrong-password') {
        throw Exception('Current password is incorrect');
      } else {
        throw Exception(e.message ?? 'Failed to update password');
      }
    } catch (e) {
      throw Exception('Failed to update password: ${e.toString()}');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await SessionManager.clearUserLoginState();
  }
}
