import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_202324/auth/login_o_registre.dart';
import 'package:flutter_firebase_202324/pagines/pagina_inici.dart';

class PortalAuth extends StatelessWidget {
  const PortalAuth({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            return const PaginaInici();
          } else {
            return const LoginORegistre();
          }
        },
      ),
    );
  }
}