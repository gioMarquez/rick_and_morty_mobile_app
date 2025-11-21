import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character.dart';

/// Página que muestra los detalles completos de un personaje.
///
/// Esta pantalla despliega la imagen, nombre, estado, información general
/// (origen, especie, género, ubicación) y los episodios en los que aparece.
/// Recibe un objeto [Character] desde la pantalla principal.
class CharacterDetailPage extends StatelessWidget {
  /// Personaje cuyo detalle se mostrará.
  final Character character;

  /// Crea una nueva pantalla de detalles para un personaje.
  const CharacterDetailPage({super.key, required this.character});

  /// Retorna un color según el estado del personaje.
  ///
  /// - Alive → Verde
  /// - Dead → Rojo
  /// - Unknown u otros → Gris
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

      /// AppBar que muestra el nombre del personaje y un botón de retroceso.
      appBar: AppBar(
        title: Text(
          character.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF24282F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      /// El contenido completo es desplazable.
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Imagen superior del personaje.
            Image.network(
              character.image,
              height: 300,
              fit: BoxFit.cover,
            ),

            /// Contenedor principal con la información.
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFF1F232B),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Nombre del personaje.
                  Text(
                    character.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Etiqueta visual del estado (Alive, Dead, Unknown).
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

                  /// Sección de información general.
                  const Text(
                    "Información",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Fila de información: especie, género, origen, ubicación.
                  infoRow("Species", character.species),
                  infoRow("Gender", character.gender),
                  infoRow("Origen", character.origin),
                  infoRow("Location", character.location),

                  const SizedBox(height: 30),

                  /// Sección de episodios.
                  const Text(
                    "Aparece en...",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Lista de episodios en un grid flexible.
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: character.episodes.map((e) {
                      final ep = e.split("/").last;

                      return SizedBox(
                        width: 80, // Hacer todos los cuadros iguales
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C313A),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(1, 2),
                              )
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "EP $ep",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Construye una fila con el nombre del atributo y su valor.
  ///
  /// Útil para mostrar información como "Species: Human" o "Gender: Male".
  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
