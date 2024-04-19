import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_202324/auth/servei_auth.dart';
import 'package:flutter_firebase_202324/chat/servei_chat.dart';
import 'package:flutter_firebase_202324/components/bombolla_missatge.dart';

class PaginaChat extends StatefulWidget {
  final String emailAmbQuiParlem;
  final String idReceptor;

  const PaginaChat(
      {super.key, required this.emailAmbQuiParlem, required this.idReceptor});

  @override
  State<PaginaChat> createState() => _PaginaChatState();
}

class _PaginaChatState extends State<PaginaChat> {
  final TextEditingController controllerMensaje = TextEditingController();
  final ScrollController controllerScroll = ScrollController();

  final ServeiChat _serveiChat = ServeiChat();
  final ServeiAuth _serveiAuth = ServeiAuth();
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => ferScrollCapAvall(),
      );
    });

    Future.delayed(
      const Duration(milliseconds: 500),
      () => ferScrollCapAvall(),
    );
  }

  void ferScrollCapAvall() {
    controllerScroll.animateTo(
      controllerScroll.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void enviarMissatge() async {
    if (controllerMensaje.text.isNotEmpty) {
      await _serveiChat.enviarMissatge(
          widget.idReceptor, controllerMensaje.text);
      print(controllerMensaje.text);
      controllerMensaje.clear();
    }
    ferScrollCapAvall();
  }

  Widget ambQuiParlem() {
    return FutureBuilder(
      future: _serveiChat.getUsuariPerEmail(widget.emailAmbQuiParlem),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final String? nomUsuari = snapshot.data['nom'];
          if (nomUsuari != null && nomUsuari != "") {
            return Text('Chat amb ${nomUsuari}');
          } else {
            return Text('Chat amb ${widget.emailAmbQuiParlem}');
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ambQuiParlem(),
      ),
      body: Column(children: [
        //Zona Missatges
        Expanded(child: _construirLlistaMissatges()),

        //Zona Escriure missatge
        _construirZonaInputUsuari(),
      ]),
    );
  }

  Widget _construirLlistaMissatges() {
    String idUsuariActual = _serveiAuth.getUsuariActual()!.uid;

    return StreamBuilder(
        stream: _serveiChat.getMissatges(idUsuariActual, widget.idReceptor),
        builder: (context, snapshot) {
          //Cas que hi hagi error
          if (snapshot.hasError) {
            return const Text("Error carregant missatges");
          }
          //Estar encara carregant les dades

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Carregant missatges...");
          }

          // Retornar dades (ListView)

          return ListView(
            controller: controllerScroll,
            children: snapshot.data!.docs
                .map((document) => _construirItemMissatge(document))
                .toList(),
          );
        });
  }

  Widget _construirItemMissatge(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //Saber si el mostrem a l'esquerra o a la dreta
    bool esUsuariActual = data["idAutor"] == _serveiAuth.getUsuariActual()!.uid;

    var alineament =
        esUsuariActual ? Alignment.centerRight : Alignment.centerLeft;
    var colorFons = esUsuariActual ? Colors.green[200] : Colors.amber[222];

    return Container(
      alignment: alineament,
      child: BombollaMissatge(
          colorBombolla: colorFons ?? Colors.amber,
          missatge: data["missatge"],
          timeStamp: data["timestamp"]),
    );
  }

  Widget _construirZonaInputUsuari() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
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
              )),
        ],
      ),
    );
  }
}
