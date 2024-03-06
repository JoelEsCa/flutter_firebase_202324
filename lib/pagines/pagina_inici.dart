import 'package:flutter/material.dart';

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
            onPressed: logout, 
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}