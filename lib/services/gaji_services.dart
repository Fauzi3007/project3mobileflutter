import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/gaji.dart'; // Import the appropriate gaji model
import '../services/service.dart'; // Import any necessary service dependencies

class GajiService {
  Future<List<Gaji>> fetchGajiList() async {
    final response = await http.get(Uri.parse('$baseUrl/api/gaji'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Gaji.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load gaji');
    }
  }

  Future<Gaji> fetchGaji(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/gaji/$id'));

    if (response.statusCode == 200) {
      return Gaji.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load gaji');
    }
  }

  Future<void> createGaji(Gaji gaji) async {
    final response = await http.post(
      Uri.parse('$baseUrl/gaji'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(gaji.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create gaji');
    }
  }

  Future<void> updateGaji(int id, Gaji gaji) async {
    final response = await http.put(
      Uri.parse('$baseUrl/gaji/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(gaji.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update gaji');
    }
  }

  Future<void> deleteGaji(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/gaji/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete gaji');
    }
  }
}
