import 'package:flutter/material.dart';

class BotoAuth extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const BotoAuth({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 255, 111, 54),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 25),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.orange[100],
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 4),
          )),
    );
  }
}
