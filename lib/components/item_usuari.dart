import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_202324/auth/servei_auth.dart';

class ItemUsuari extends StatelessWidget {
  final String emailUsuari;
  final void Function()? onTap;

  ItemUsuari({super.key, required this.emailUsuari, required this.onTap});

  final ServeiAuth _serveiAuth = ServeiAuth();

  Future<String> getImatgePerfil() async {

    final String idUsuari = ServeiAuth().getUsuariActual()!.uid;

    Reference ref = FirebaseStorage.instance.ref().child("$idUsuari/avatar/$idUsuari");

    try {
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      return "";
    }
  }
  
  Widget mostrarImatge() {
    return FutureBuilder(
      future: getImatgePerfil(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError) {
          return const Icon(Icons.person);
        }

        if (snapshot.data == "") {
          return const Icon(Icons.person);
        } else {
          return Image.network(
            snapshot.data!,
            errorBuilder: (context, error, stackTrace) {
              return const Text("Error al carregar la imatge.");
            },
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
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            mostrarImatge(),
            const SizedBox(width: 10),
            Text(emailUsuari),
          ],
        
        )
      ),
    );
  }
}