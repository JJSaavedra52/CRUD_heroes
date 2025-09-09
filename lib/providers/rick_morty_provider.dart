import 'dart:convert';
import 'package:http/http.dart' as http;

class RickMortyProvider/* extends ChangeNotifier */ {
  static const baseURL = "rickandmortyapi.com";

  static Future<dynamic> getOnDisplayCharacters([int pagina = 1]) async {
    final url = Uri.https(baseURL,"api/character", {
      'page': pagina.toString(),
    });
    final response = await http.get(url);
    final decodeData = jsonDecode(response.body) as Map<String, dynamic>;
    return decodeData['results'];
  }

  static Future<dynamic> getOnDisplayLocations([int pagina = 1]) async {
    final url = Uri.https(baseURL,"api/location", {
      'page': pagina.toString(),
    });
    final response = await http.get(url);
    final decodeData = jsonDecode(response.body) as Map<String, dynamic>;
    return decodeData['results'];
  }

  static Future<dynamic> getOnDisplayEpisode([int pagina = 1]) async {
    final url = Uri.https(baseURL,"api/episode", {
      'page': pagina.toString(),
    });
    final response = await http.get(url);
    final decodeData = jsonDecode(response.body) as Map<String, dynamic>;
    return decodeData['results'];
  }
}