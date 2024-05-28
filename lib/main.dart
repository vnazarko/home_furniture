import 'package:flutter/material.dart';
import 'package:home_furniture/pages/catalog.dart';
import 'package:home_furniture/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      

      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/catalog': (context) => CatalogPage(),
      }
    );
  }
}
