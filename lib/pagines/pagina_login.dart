import 'package:flutter/material.dart';
import 'package:flutter_firebase_202324/components/text_field_auth.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({super.key});

  @override
  State<PaginaLogin> createState() => _PaginaLoginState();

}

class _PaginaLoginState extends State<PaginaLogin> {

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 183, 189),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              const Icon(
                Icons.fireplace,
                size: 120,
                color: Color.fromARGB(255, 255, 240, 218),
              ),

              //FRASE
              const Text(
                'Benvingut/da de nou',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 255, 240, 218),
                  fontWeight: FontWeight.bold,
                ),
              ),

              //Text divisori
              const Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 255, 240, 218),
                  )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        "Fes login",
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
              //Textfield email
              TextFieldAuth(controller: controllerEmail, obscureText: false, hintText: "Email"),

              //Textfield password
              TextFieldAuth(controller: controllerPassword, obscureText: true, hintText: "Password"),


              //No estás registrat?

              //Botó de login
            ],
          ),
        ));
  }
}
