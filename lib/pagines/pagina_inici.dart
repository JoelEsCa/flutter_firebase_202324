import 'package:flutter/material.dart';
import 'package:flutter_firebase_202324/auth/servei_auth.dart';

class PaginaInici extends StatelessWidget {
  const PaginaInici({super.key});

 void logout() {

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pàgina inici"),
        actions: [
          IconButton(
            onPressed: () {
               final serveiAuth = ServeiAuth();
                serveiAuth.tancarSessio();
            }, 
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}