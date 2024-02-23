import 'package:flutter/material.dart';
import 'package:flutter_firebase_202324/pagines/pagina_login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginaLogin(),
    );
  }
}

/**
 * 1 ) Tenir node.js instal·lat.
 * 2) Instal·lar Firebase CLI: npm install -g firebase-tools
 * 3) Iniciar sessió amb Firebase: firebase login
 *  - Si dona error el archivo firebase.ps1, cambiarle el nombre o borrarlo
 */
