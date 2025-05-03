import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical/Models/doctor.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      } else {
        throw Exception(e.message ?? 'Authentication failed');
      }
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Check if user is already logged in
  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
