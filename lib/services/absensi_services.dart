import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/absensi.dart'; // Import the appropriate absensi model
import '../services/service.dart'; // Import any necessary service dependencies

class AbsensiService {
  Future<List<Absensi>> fetchAbsensiList() async {
    final response = await http.get(Uri.parse('$baseUrl/api/absensi'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Absensi.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load absensi');
    }
  }

  Future<Absensi> fetchAbsensi(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/absensi/$id'));

    if (response.statusCode == 200) {
      return Absensi.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load absensi');
    }
  }

  Future<void> createAbsensi(Absensi absensi) async {
    final response = await http.post(
      Uri.parse('$baseUrl/absensi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(absensi.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create absensi');
    }
  }

  Future<void> updateAbsensi(int id, Absensi absensi) async {
    final response = await http.put(
      Uri.parse('$baseUrl/absensi/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(absensi.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update absensi');
    }
  }

  Future<void> deleteAbsensi(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/absensi/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete absensi');
    }
  }
}
