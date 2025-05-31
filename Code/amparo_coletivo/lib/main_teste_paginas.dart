import 'package:flutter/material.dart';
import 'pages/about_ong_page.dart'; // Caminho ajustado conforme estrutura

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ONG App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AboutOngPage(),
    );
  }
}
