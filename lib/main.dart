import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_202324/auth/login_o_registre.dart';
import 'package:flutter_firebase_202324/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginORegistre(),
    );
  }
}

/**
  1 ) Tenir node.js instal·lat.
  2) Instal·lar Firebase CLI: npm install -g firebase-tools
  3) Iniciar sessió amb Firebase: firebase login
       - Si dona error el archivo firebase.ps1, cambiarle el nombre o borrarlo
       - Si torna a fer firebase login, veurem en que compte estem registrar
       - Si volem canviar de compte, fem firebase logout
  4) Fer dart pub global activate flutterfire_cli
  5) Vincular projecte local al projecte firebase de la consola: flutterfire configure
  6) Incloure les llibreries de Firebase que vulguem utilitzar.
    - flutter pub add firebase_auth
    - flutter pub add firebase_core
 */
