import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_setup/wigdets/toast.dart';

class Firebaseauthservice {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signupwithemailandpassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: "the email  is already in use");
      } else {
        showToast(message: 'an error occurred:${e.code}');
      }
    }
    return null;
  }

  Future<User?> signinwithemailandpassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user not found" || e.code == "wrong password") {
        showToast(message: "invalid email or password");
      } else {
        showToast(message: "an error occurred:${e.code}");
      }
    }
    return null;
  }
}
