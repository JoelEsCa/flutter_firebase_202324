import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_202324/auth/servei_auth.dart';
import 'package:image_picker/image_picker.dart';

class EditarDadesUsuari extends StatefulWidget {
  const EditarDadesUsuari({super.key});

  @override
  State<EditarDadesUsuari> createState() => EditarDadesUsuariState();
}

class EditarDadesUsuariState extends State<EditarDadesUsuari> {
  File? _imatgeSeleccionadaApp;
  Uint8List? _imatgeSeleccionadaWeb;
  bool _imatgeApuntPerPujar = false;

  Future<void> _triaImatge() async {
    final ImagePicker _picker = ImagePicker();
    XFile? imatge = await _picker.pickImage(source: ImageSource.gallery);

    if (imatge != null) {
      // Si l'App s'executa en un dispositiu movil
      if (!kIsWeb) {
        File arxiuSeleccionat = File(imatge.path);

        setState(() {
          _imatgeSeleccionadaApp = arxiuSeleccionat;
          _imatgeApuntPerPujar = true;
        });
      }

      if (kIsWeb) {
        Uint8List arxiuSeleccionat = await imatge.readAsBytes();

        setState(() {
          _imatgeSeleccionadaWeb = arxiuSeleccionat;
          _imatgeApuntPerPujar = true;
        });
      }
    }
  }

  Future<bool> pujarImatgePerUsuari() async {
    String idUsuari = ServeiAuth().getUsuariActual()!.uid;

    Reference ref =
        FirebaseStorage.instance.ref().child("$idUsuari/avatar/$idUsuari");

    // Agafem l'imagine de la variable que la tingui (la de la web o la de la app)

    if (_imatgeSeleccionadaApp != null) {
      try {
        await ref.putFile(_imatgeSeleccionadaApp!);
        return true;
      } catch (e) {
        return false;
      }
    }

    if (_imatgeSeleccionadaWeb != null) {
      try {
        await ref.putData(_imatgeSeleccionadaWeb!);
        return true;
      } catch (e) {
        return false;
      }
    }

    return false;
  }

  Future<String> getImatgePerfil() async {

    final String idUsuari = ServeiAuth().getUsuariActual()!.uid;

    Reference ref = FirebaseStorage.instance.ref().child("$idUsuari/avatar/$idUsuari");

    try {
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      return "";
    }
  }

  Widget mostrarImatge() {

    return FutureBuilder(
      future: getImatgePerfil(),
    builder: (context, snapshot) {

      if(snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
        return const Icon(Icons.person);
      }

      return Image.network(
      snapshot.data!, 
      errorBuilder: (context, error, stackTrace) {
        return const Text("Error al carregar la imatge.");
      },);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar dades usuari'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Botó per obrir el FilePicker
          GestureDetector(
              onTap: _triaImatge, // Removed the parentheses
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                ),
                child: const Text("Tria imatge"),
              )),

          //Botó per pujer la imatge seleccionada al filePicker

          GestureDetector(
              onTap: () async {
                if (_imatgeApuntPerPujar) {
                  bool imatePujadaCorrectamente = await pujarImatgePerUsuari();

                  if (imatePujadaCorrectamente) {
                    setState(() {
                      mostrarImatge();
                    });
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                ),
                child: const Text("Puja imatge"),
              )),

          // Visor del resultat del filePicker

          Container(
            child: _imatgeSeleccionadaWeb == null &&
                    _imatgeSeleccionadaApp == null
                ? Container()
                : kIsWeb
                    ? Image.memory(_imatgeSeleccionadaWeb!, fit: BoxFit.fill)
                    : Image.file(_imatgeSeleccionadaApp!, fit: BoxFit.fill),
          ),

          //Visor del resutlat de carrregar la imatge de firebase storage
          Container(
            child: mostrarImatge(),
          )
        ],
      ))),
    );
  }
}
