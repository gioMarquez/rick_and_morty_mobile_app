import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

/// Clase que maneja las llamadas a la API de Rick and Morty.
class RickApi {
  /// Obtiene una lista de personajes desde la API.
  ///
  /// Parámetros:
  /// - [page]: Número de página a consultar (obligatorio).
  /// - [name]: Filtra personajes por nombre (opcional).
  /// - [status]: Filtra personajes por estado ("Alive", "Dead", "unknown") (opcional).
  ///
  /// Retorna un [Future] que resuelve en un [Map] con:
  /// - "characters": Lista de objetos [Character] obtenidos.
  /// - "hasMore": Booleano que indica si hay más páginas disponibles.
  static Future<Map<String, dynamic>> getCharacters({
    required int page,
    String? name,
    String? status,
  }) async {
    // Construye los parámetros de la query, incluyendo solo los que tienen valor
    final query = {
      "page": "$page",
      if (name != null && name.isNotEmpty) "name": name,
      if (status != null && status.isNotEmpty) "status": status,
    };

    // Construye la URI con HTTPS hacia el endpoint de personajes
    final uri = Uri.https("rickandmortyapi.com", "/api/character/", query);

    // Realiza la petición GET a la API
    final response = await http.get(uri);

    // Si el código HTTP no es 200, devuelve lista vacía y sin más páginas
    if (response.statusCode != 200) {
      return {"characters": [], "hasMore": false};
    }

    // Decodifica la respuesta JSON
    final json = jsonDecode(response.body);

    // Maneja el caso de error "no results"
    if (json is Map && json.containsKey("error")) {
      return {"characters": [], "hasMore": false};
    }

    // Convierte la lista de resultados en objetos Character
    final characters =
        (json["results"] as List).map((e) => Character.fromJson(e)).toList();

    // Retorna los personajes y si hay una página siguiente
    return {
      "characters": characters,
      "hasMore": json["info"]["next"] != null,
    };
  }
}
