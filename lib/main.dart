import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/pages/characters_page.dart';

void main() {
  runApp(const RickApp());
}

class RickApp  extends StatelessWidget {
  const RickApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blueAccent, //Asignando paleta de colores
      ),
      home: const CharactersPage(),
    );
  }
}
