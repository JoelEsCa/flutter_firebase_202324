import 'package:flutter/material.dart';
import 'package:flutter_firebase_202324/components/buto_auth.dart';
import 'package:flutter_firebase_202324/components/text_field_auth.dart';

class PaginaRegistre extends StatefulWidget {
  const PaginaRegistre({super.key});

  @override
  State<PaginaRegistre> createState() => _PaginaRegistreState();
}

class _PaginaRegistreState extends State<PaginaRegistre> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerEmail = TextEditingController();
    final TextEditingController controllerPassword = TextEditingController();
    final TextEditingController controllerConfirmarPassword =
        TextEditingController();

    void ferRegistre() {}

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 183, 189),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    const Icon(
                      Icons.fireplace,
                      size: 120,
                      color: Color.fromARGB(255, 255, 240, 218),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    //FRASE
                    const Text(
                      'Creació de compte',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 240, 218),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    //Text divisori
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Expanded(
                              child: Divider(
                            thickness: 1,
                            color: Color.fromARGB(255, 255, 240, 218),
                          )),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                "Registra't",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 240, 218),
                                ),
                              )),
                          Expanded(
                              child: Divider(
                            thickness: 1,
                            color: Color.fromARGB(255, 255, 240, 218),
                          )),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //Textfield email
                    TextFieldAuth(
                        controller: controllerEmail,
                        obscureText: false,
                        hintText: "Email"),

                    const SizedBox(
                      height: 10,
                    ),

                    //Textfield password
                    TextFieldAuth(
                        controller: controllerPassword,
                        obscureText: true,
                        hintText: "Password"),

                    const SizedBox(
                      height: 10,
                    ),

                    //Textfield confirm password
                    TextFieldAuth(
                        controller: controllerConfirmarPassword,
                        obscureText: true,
                        hintText: "Confirm Password"),
                    //No estás registrat?

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Ja tens compte?"),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: const Text("Inicia Sesió",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue))),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    //Botó de registre
                    BotoAuth(
                      text: "Registra't",
                      onTap: ferRegistre,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
