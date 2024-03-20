import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaginaChat extends StatefulWidget {
  const PaginaChat({super.key});

  @override
  State<PaginaChat> createState() => _PaginaChatState();
}

class _PaginaChatState extends State<PaginaChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pàgina chat"),
      ),
      body: Column(
        children: [
          //Zona Missatges
          Expanded(child: _construirLlistaMissatges()),

          //Zona Escriure missatge
          _construirZonaInputUsuari(),
        ]
      ),);
  }

  Widget _construirLlistaMissatges() {
    return Container();
  }

  Widget _construirZonaInputUsuari() {
    return Container();
  }

}