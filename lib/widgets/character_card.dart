import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character.dart';

/// Tarjeta visual que muestra información básica de un personaje.
///
/// Este widget muestra la imagen, el nombre y la especie de un personaje.
/// Además, permite ejecutar una acción cuando el usuario toca la tarjeta.
///
/// Usado generalmente dentro de listas de personajes.
class CharacterCard extends StatelessWidget {
  /// Modelo con la información del personaje a mostrar.
  final Character character;

  /// Función que se ejecuta cuando el usuario toca la tarjeta.
  final VoidCallback onTap;

  /// Crea un widget [CharacterCard].
  ///
  /// Requiere un [Character] y un callback [onTap] para manejar la interacción.
  const CharacterCard({
    super.key,
    required this.character,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Acción al presionar la tarjeta
      onTap: onTap,

      // Define el radio para animación ripple del InkWell
      borderRadius: BorderRadius.circular(16),

      child: Container(
        // Espaciado externo respecto a otros widgets
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),

        // Espaciado interno para el contenido
        padding: const EdgeInsets.all(12),

        // Estilo visual de la tarjeta
        decoration: BoxDecoration(
          color: const Color(0xFF2C313A),
          borderRadius: BorderRadius.circular(16),
        ),

        child: Row(
          children: [
            // Imagen del personaje con bordes redondeados
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                character.image,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 16),

            // Información textual del personaje
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre del personaje
                Text(
                  character.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                // Especie del personaje
                Text(
                  character.species,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
