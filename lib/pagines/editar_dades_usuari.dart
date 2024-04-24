import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_202324/auth/servei_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditarDadesUsuari extends StatefulWidget {
  const EditarDadesUsuari({super.key});

  @override
  State<EditarDadesUsuari> createState() => EditarDadesUsuariState();
}

class EditarDadesUsuariState extends State<EditarDadesUsuari> {
  File? _imatgeSeleccionadaApp;
  Uint8List? _imatgeSeleccionadaWeb;
  bool _imatgeApuntPerPujar = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  void recargarPagina() {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => super.widget,
    ),
  );
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

    Reference ref =
        FirebaseStorage.instance.ref().child("$idUsuari/avatar/$idUsuari");

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
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError) {
          return const Icon(Icons.person);
        }

        return Center(
          child: Container(
            width: 600,
            height: 600,
            child: Image.network(
              snapshot.data!,
              errorBuilder: (context, error, stackTrace) {
                return const Text("Error al carregar la imatge.");
              },
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Padding getMail() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, top: 20.0), // Ajusta los valores según tus necesidades
      child: Text(ServeiAuth()
              .getUsuariActual()!
              .email!
              .toString() // Ajusta el tamaño de la fuente según tus necesidades
          ),
    );
  }

  final TextEditingController nomController = TextEditingController();

  Widget? nomUsuari() {
    return FutureBuilder(
      future: getNom(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        print(snapshot.data.toString());

        String nom = (snapshot.data != null) ? snapshot.data.toString() : "";
        nomController.text = nom;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
                decoration: const InputDecoration(
                  hintText: "Introdueix el teu nom",
                  labelText: "Nom",
                ),
                controller: nomController),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Con el usuario logeado, le asignamos el nombre que ha introducido
                  final String idUsuari = ServeiAuth().getUsuariActual()!.uid;
                  _firestore.collection("Usuaris").doc(idUsuari).update({
                    "nom": nomController.text,
                  }).then((_) {
                    print('Nombre actualizado con éxito');
                  }).catchError((error) {
                    print('Error al actualizar el nombre: $error');
                  });
                });
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  Future<String> getNom() async {
    final String idUsuari = ServeiAuth().getUsuariActual()!.uid;
    String nom = "";

    var doc = await _firestore.collection("Usuaris").doc(idUsuari).get();
    if (doc.exists && doc.data() != null) {
      nom = doc.data()!["nom"] ?? "";
    }

    return nom;
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
          getMail(),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: nomUsuari(),
          ),
          const SizedBox(height: 20.0),

          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
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

                const SizedBox(width: 10.0),

                //Botó per pujer la imatge seleccionada al filePicker
                GestureDetector(
                    onTap: () async {
                      if (_imatgeApuntPerPujar) {
                        bool imatePujadaCorrectamente =
                            await pujarImatgePerUsuari();

                        if (imatePujadaCorrectamente) {
                          //setState(() {
                            //mostrarImatge();
                          //} );
                          recargarPagina();
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
              ],
            ),
          ),

          const SizedBox(height: 20.0),

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
