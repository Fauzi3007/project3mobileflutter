import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/gaji.dart';
import '../services/service.dart';

class GajiService {
  Future<List<Gaji>> fetchGajiList() async {
    final response = await http.get(Uri.parse('$baseUrl/api/gaji'), headers: {
      'Authorization': 'Bearer ${await fetchToken()}',
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Gaji.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load gaji');
    }
  }

  Future<Gaji> fetchGaji(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/gaji/$id'),
        headers: {
          'Authorization': 'Bearer ${await fetchToken()}',
          'Accept': 'application/json'
        });

    if (response.statusCode == 200) {
      return Gaji.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load gaji');
    }
  }

  Future<void> createGaji(Gaji gaji) async {
    final response = await http.post(
      Uri.parse('$baseUrl/gaji'),
      headers: {
        'Authorization': 'Bearer ${await fetchToken()}',
        'Accept': 'application/json'
      },
      body: jsonEncode(gaji.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create gaji');
    }
  }

  Future<void> updateGaji(String id, Gaji gaji) async {
    final response = await http.put(
      Uri.parse('$baseUrl/gaji/$id'),
      headers: {
        'Authorization': 'Bearer ${await fetchToken()}',
        'Accept': 'application/json'
      },
      body: jsonEncode(gaji.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update gaji');
    }
  }

  Future<void> deleteGaji(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/gaji/$id'),
        headers: {
          'Authorization': 'Bearer ${await fetchToken()}',
          'Accept': 'application/json'
        });

    if (response.statusCode != 204) {
      throw Exception('Failed to delete gaji');
    }
  }
}
