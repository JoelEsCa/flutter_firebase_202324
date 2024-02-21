import 'package:flutter/material.dart';

class TextFieldAuth extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;

    const TextFieldAuth(
      {super.key, required this.controller, required this.obscureText, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: TextField(
          style: const TextStyle(color: Color.fromARGB(255, 154, 69, 0)),
          cursorColor: const Color.fromARGB(255, 255, 100, 0),
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 255, 205, 130),
              filled: true,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 255, 229, 190), width: 2.0),
              ),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.orange[800]),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
            ),
        ));
  }
}
