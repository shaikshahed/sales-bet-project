import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream of user changes
  Stream<User?> authStateChanges() => _auth.authStateChanges();

Future<User?> signIn(String email, String password) async {
    try {
      print("Attempting sign-in with '$email' / '$password'");
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Sign-in success: ${cred.user?.uid}");
      return cred.user;
    } on FirebaseAuthException catch (e) {
      print("Sign-in error: ${e.code}, ${e.message}");
      rethrow;
    }
  }



 Future<User?> register(String name, String email, String password) async {
    try {
      print("Attempting register with $email");
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Firebase register success: ${cred.user?.uid}");
      final user = cred.user;

      if (user != null) {
        await _db.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'credits': 1000,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      return user;
    } on FirebaseAuthException catch (e) {
      print("Register error: ${e.code}, ${e.message}");
      rethrow;
    }
  }

  Future<void> signOut() => _auth.signOut();

  User? currentUser() => _auth.currentUser;
}
