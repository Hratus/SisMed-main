import 'package:flutter/material.dart';
import 'pages/PrincipalPage.dart'; // Certifique-se de que o caminho esteja correto

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrincipalPage(), // Chamando a tela principal
    );
  }
}

