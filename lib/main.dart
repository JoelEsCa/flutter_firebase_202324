import 'package:flutter/material.dart';
import 'package:flutter_firebase_202324/pagines/pagina_login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginaLogin(),
    );
  }
}
