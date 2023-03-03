import 'package:firebase_auth/firebase_auth.dart';
class Authentification{

  static Future signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim()
    );
  }

  static Future<UserCredential> signUp(String email, String password) async {
    print('-------------------------------');
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim()
    );
  }

  static Future resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
  }
}