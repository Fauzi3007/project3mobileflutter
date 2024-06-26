import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pelanggan.dart'; // Import the appropriate pelanggan model
import '../services/service.dart'; // Import any necessary service dependencies

class PelangganService {
  Future<List<Pelanggan>> fetchPelangganList() async {
    final response = await http.get(Uri.parse('$baseUrl/api/pelanggan'),
        headers: {
          'Authorization': 'Bearer ${await fetchToken()}',
          'Accept': 'application/json'
        });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Pelanggan.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load pelanggan');
    }
  }

  Future<Pelanggan> fetchPelanggan(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/pelanggan/$id'),
        headers: {
          'Authorization': 'Bearer ${await fetchToken()}',
          'Accept': 'application/json'
        });

    if (response.statusCode == 200) {
      return Pelanggan.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pelanggan');
    }
  }

  Future<void> createPelanggan(Pelanggan pelanggan) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pelanggan'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await fetchToken()}',
        'Accept': 'application/json'
      },
      body: jsonEncode(pelanggan.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create pelanggan');
    }
  }

  Future<void> updatePelanggan(String id, Pelanggan pelanggan) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pelanggan/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await fetchToken()}',
        'Accept': 'application/json'
      },
      body: jsonEncode(pelanggan.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update pelanggan');
    }
  }

  Future<void> deletePelanggan(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/pelanggan/$id'),
        headers: {
          'Authorization': 'Bearer ${await fetchToken()}',
          'Accept': 'application/json'
        });

    if (response.statusCode != 204) {
      throw Exception('Failed to delete pelanggan');
    }
  }
}
