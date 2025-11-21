

import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  Color getColor() {
    switch (character.status) {
      case "Alive":
        return Colors.green;
      case "Dead":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F232B),
      appBar: AppBar(
        title: Text(character.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF24282F),
        iconTheme: const IconThemeData(color: Colors.white) //Cambiar el color de la flecha
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(character.image, height: 300, fit: BoxFit.cover),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFF1F232B),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    character.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Status Badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: getColor(),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      character.status,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text("Información",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),

                  const SizedBox(height: 16),

                  infoRow("Species", character.species),
                  infoRow("Gender", character.gender),
                  infoRow("Origen", character.origin),
                  infoRow("Location", character.location),

                  const SizedBox(height: 30),

                  const Text("Aparece en...",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    children: character.episodes
                        .map((e) => Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2C313A),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                e.split("/").last,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white70, fontSize: 16)),
          Text(value,
              style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}
