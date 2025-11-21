import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class RickApi {
  static Future<Map<String, dynamic>> getCharacters(int page) async {
    final url = Uri.parse(
      "https://rickandmortyapi.com/api/character/?page=$page",
    );

    final res = await http.get(url);
    final data = jsonDecode(res.body);

    final List results = data['results'];

    return {
      "characters": results.map((e) => Character.fromJson(e)).toList(),
      "hasMore": data['info']['next'] != null,
    };
  }
}
