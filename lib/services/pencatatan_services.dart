import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pencatatan.dart'; // Import the appropriate pencatatan model
import '../services/service.dart'; // Import any necessary service dependencies

class PencatatanService {
  Future<List<Pencatatan>> fetchPencatatanList() async {
    final response = await http.get(Uri.parse('$baseUrl/api/pencatatan'),
        headers: {
          'Authorization': 'Bearer ${await fetchToken()}',
          'Accept': 'application/json'
        });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Pencatatan.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load pencatatan');
    }
  }

  Future<Pencatatan> fetchPencatatan(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/pencatatan/$id'),
        headers: {
          'Authorization': 'Bearer ${await fetchToken()}',
          'Accept': 'application/json'
        });

    if (response.statusCode == 200) {
      return Pencatatan.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pencatatan');
    }
  }

  Future<void> createPencatatan(Pencatatan pencatatan) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pencatatan'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await fetchToken()}',
        'Accept': 'application/json'
      },
      body: jsonEncode(pencatatan.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create pencatatan');
    }
  }

  Future<void> updatePencatatan(int id, Pencatatan pencatatan) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pencatatan/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await fetchToken()}',
        'Accept': 'application/json'
      },
      body: jsonEncode(pencatatan.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update pencatatan');
    }
  }

  Future<void> deletePencatatan(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/pencatatan/$id'),
        headers: {
          'Authorization': 'Bearer ${await fetchToken()}',
          'Accept': 'application/json'
        });

    if (response.statusCode != 204) {
      throw Exception('Failed to delete pencatatan');
    }
  }
}
