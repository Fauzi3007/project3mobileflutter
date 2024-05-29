import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cuti.dart'; // Import the appropriate cuti model
import '../services/service.dart'; // Import any necessary service dependencies

class CutiService {
  Future<List<Cuti>> fetchCutiList() async {
    final response = await http.get(Uri.parse('$baseUrl/api/cuti'), headers: {
      'Authorization': 'Bearer ${await fetchToken()}',
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Cuti.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load cuti');
    }
  }

  Future<Cuti> fetchCuti(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/cuti/$id'),
        headers: {
          'Authorization': 'Bearer ${await fetchToken()}',
          'Accept': 'application/json'
        });
    if (response.statusCode == 200) {
      return Cuti.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load cuti');
    }
  }

  Future<void> createCuti(Cuti cuti) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cuti'),
      headers: {
        'Authorization': 'Bearer ${await fetchToken()}',
        'Accept': 'application/json'
      },
      body: jsonEncode(cuti.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create cuti');
    }
  }

  Future<void> updateCuti(int id, Cuti cuti) async {
    final response = await http.put(
      Uri.parse('$baseUrl/cuti/$id'),
      headers: {
        'Authorization': 'Bearer ${await fetchToken()}',
        'Accept': 'application/json'
      },
      body: jsonEncode(cuti.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update cuti');
    }
  }

  Future<void> deleteCuti(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/cuti/$id'),
        headers: {
          'Authorization': 'Bearer ${await fetchToken()}',
          'Accept': 'application/json'
        });

    if (response.statusCode != 204) {
      throw Exception('Failed to delete cuti');
    }
  }
}
