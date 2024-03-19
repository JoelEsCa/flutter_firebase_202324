import 'package:flutter/material.dart';
import 'package:flutter_firebase_202324/auth/servei_auth.dart';
import 'package:flutter_firebase_202324/chat/servei_chat.dart';

class PaginaInici extends StatelessWidget {
  PaginaInici({super.key});

  final ServeiAuth _serveiAuth = ServeiAuth();
  final ServeiChat _serveiChat = ServeiChat();

  void logout() {
    //final serveiAuth = ServeiAuth();

    _serveiAuth.tancarSessio();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pàgina inici"),
        actions: [
          IconButton(
            onPressed: logout, 
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: _construeixLlistaUsuaris(),
    );
  }

  Widget _construeixLlistaUsuaris() {

    return StreamBuilder(
      stream: _serveiChat.getUsuaris(), 
      builder: (context, snapshot) {

        // Mirar si hi ha errror.
        if (snapshot.hasError) {

          return const Text("Error");
        }

        // Esperem que es carreguin les dades.
        if (snapshot.connectionState == ConnectionState.waiting) {

          return const Text("Carregant dades...");
        }

        // Es retornen les dades.
        return ListView(
          children: snapshot.data!.map<Widget>(
            (dadesUsuari) => _construeixItemUsuari(dadesUsuari, context)
          ).toList(),
        );
      },
    );
  }

  Widget _construeixItemUsuari(Map<String, dynamic> dadesUsuari, BuildContext context) {

    if (dadesUsuari["email"] == _serveiAuth.getUsuariActual()!.email) {

      return Container();
    }
    return Text(dadesUsuari["email"]);
  }
}
