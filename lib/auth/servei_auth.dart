import 'package:firebase_auth/firebase_auth.dart';

class ServeiAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fer login
  Future<UserCredential> loginambEmailIPassword(String email, password) async {
    try {
      UserCredential credencialUsuari = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
          print(credencialUsuari);
      return credencialUsuari;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Fer register

  Future<UserCredential> registerambEmailIPassword(String email, password) async {
    try {
      UserCredential credencialUsuari = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credencialUsuari;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Fer logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
