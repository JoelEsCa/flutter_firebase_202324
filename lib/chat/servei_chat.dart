
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_202324/models/missatge.dart';

class ServeiChat {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsuaris() {

    return _firestore.collection("Usuaris").snapshots().map((event) {

      return event.docs.map((document) {

        final usuari = document.data();
        return usuari;
      }).toList();
    });
  }

  Future<void> enviarMissatge(String idReceptor, String missatge) async {
      
      final String idUsuariActual = _auth.currentUser!.uid;
      final String emailUsuariActual = _auth.currentUser!.email!;
      final Timestamp timestamp = Timestamp.now();

    Missatge nouMissatge = Missatge(
      idAutor: idUsuariActual,
      emailAutor: emailUsuariActual,
      idReceptor: idReceptor,
      missatge: missatge,
      timestamp: timestamp,
    );

    //Construir l'ID de la sala de caht d'aquest missatge
    List<String> idsUsuaris = [idUsuariActual, idReceptor];
    idsUsuaris.sort();
    final String idSalaChat = idsUsuaris.join('_');
    
  await _firestore.collection("Salas_chat").doc(idSalaChat).collection("Missatges").add(nouMissatge.retornaMapaMissatge()); 

  }
}