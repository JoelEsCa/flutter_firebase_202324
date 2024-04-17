import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServeiAuth {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fer login
  Future<UserCredential> loginAmbEmailIPassword(String email, password) async {

    try {
      UserCredential credencialUsuari = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );

      // Quiero saber si hay un documento en la colección usuaris que tenga el UID de la persona que se acaba de loguear con una query
      // Si no hay ningun documento con el UID de la persona que se acaba de loguear, entonces se crea un documento con el UID de la persona que se acaba de loguear
      // Si ya hay un documento con el UID de la persona que se acaba de loguear, entonces no se hace nada

      // Query
      QuerySnapshot query = await _firestore.collection("Usuaris").where("uid", isEqualTo: credencialUsuari.user!.uid).get();

      // Si ha encontrado algo, entonces no hace nada

      if (query.docs.length == 0) {
        _firestore.collection("Usuaris").doc(credencialUsuari.user!.uid).set({
          "uid": credencialUsuari.user!.uid,
          "email": email,
          "nom": "",
        });
      }

      return credencialUsuari;

    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
    
  }

  // Fer registre
  Future<UserCredential> registreAmbEmailIPassword(String email, password) async {

    try {
      UserCredential credencialUsuari = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );

      _firestore.collection("Usuaris").doc(credencialUsuari.user!.uid).set({
        "uid": credencialUsuari.user!.uid,
        "email": email,
      });

      return credencialUsuari;

    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
    
  }

  // Fer logout
  Future<void> tancarSessio() async {
    return await _auth.signOut();
  }

  User? getUsuariActual() {
    return _auth.currentUser;
  }
}