import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_202324/auth/login_o_registre.dart';
import 'package:flutter_firebase_202324/auth/portal_auth.dart';
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
      home: PortalAuth(),
    );
  }
}

/*
1) Tenir el Node.js instal·lat.
2) npm install -g firebase-tools
3) Fer login a Firebase: firebase login
    - Si dona error de l'arxiu firebase.ps1, canviar-li el nom (o esborrar-lo
    i tornar a fer login).
    - Si tornem a fer firebase login, ens diu en quin compte estem.
    - Si vulguéssim canviar el compte, fem firebase logout.

4) Fer: dart pub global activate flutterfire_cli
5) Vincular projecte local amb projecte Firebase de la Consola.
    - flutterfire configure

6) Incloure les llibreries de Firebase que vulguem utilitzar.
    - flutter pub add firebase_auth
    - flutter pub add firebase_core

*/