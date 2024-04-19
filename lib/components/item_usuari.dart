import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_202324/auth/servei_auth.dart';
import 'package:flutter_firebase_202324/chat/servei_chat.dart';

class ItemUsuari extends StatelessWidget {
  final String emailUsuari;
  final void Function()? onTap;

  ItemUsuari({super.key, required this.emailUsuari, required this.onTap});

  final ServeiAuth _serveiAuth = ServeiAuth();
  final ServeiChat _serveiChat = ServeiChat();

  Future<String> getImatgePerfil() async {
    final usuari = await _serveiChat.getUsuariPerEmail(emailUsuari);
    final String idUsuari = usuari['uid'];

    Reference ref =
        FirebaseStorage.instance.ref().child("$idUsuari/avatar/$idUsuari");

    try {
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      return "";
    }
  }

  Widget mostrarImatge() {
    return FutureBuilder(
      future: Future.wait([
        getImatgePerfil(),
        _serveiChat.getUsuariPerEmail(emailUsuari),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError ||
            snapshot.data == null) {
          return const Icon(Icons.person, size: 50);
        }

        final imatgePerfil = snapshot.data?[0] as String;
        final usuari = snapshot.data?[1];

        if (imatgePerfil == null || imatgePerfil == "") {
          return const Icon(Icons.person, size: 50);
        } else {
          return Container(
            width: 50,
            height: 50,
            child: Image.network(
              imatgePerfil,
              errorBuilder: (context, error, stackTrace) {
                return const Text("Error al carregar la imatge.");
              },
              fit: BoxFit.cover,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 25,
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              mostrarImatge(),
              const SizedBox(width: 10),
              Text(emailUsuari),
            ],
          )),
    );
  }
}
