
import 'package:cloud_firestore/cloud_firestore.dart';

class ServeiChat {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUsuaris() {

    return _firestore.collection("Usuaris").snapshots().map((event) {

      return event.docs.map((document) {

        final usuari = document.data();
        return usuari;
      }).toList();
    });
  }
}