import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaginaChat extends StatefulWidget {

  final String emailAmbQuiParlem;
  const PaginaChat({super.key, 
  required this.emailAmbQuiParlem});

  @override
  State<PaginaChat> createState() => _PaginaChatState();
}

class _PaginaChatState extends State<PaginaChat> {

  final TextEditingController controllerMensaje = TextEditingController();

    void enviarMissatge() {
    if(controllerMensaje.text.isNotEmpty) {
      print(controllerMensaje.text);
      controllerMensaje.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat amb ${widget.emailAmbQuiParlem}'),
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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(children: [
         Expanded(
          child: TextField(
            controller: controllerMensaje,
            decoration: InputDecoration(
              fillColor: Colors.amber[200],
              filled: true,
              hintText: 'Escriu un missatge...',
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: enviarMissatge, 
          icon: const Icon(Icons.send),
          color: Colors.white,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          )
        ),
      ],),
    );
  }

}