import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pegawai.dart';
import '../services/service.dart';

class PegawaiService {
  Future<List<Pegawai>> fetchPegawaiList() async {
    final response = await http.get(Uri.parse('$baseUrl/api/pegawai'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Pegawai.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load pegawai');
    }
  }

  Future<Pegawai> fetchPegawai(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/pegawai/$id'));

    if (response.statusCode == 200) {
      return Pegawai.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pegawai');
    }
  }

  Future<void> createPegawai(Pegawai pegawai) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pegawai'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(pegawai.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create pegawai');
    }
  }

  Future<void> updatePegawai(int id, Pegawai pegawai) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pegawai/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(pegawai.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update pegawai');
    }
  }

  Future<void> deletePegawai(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/pegawai/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete pegawai');
    }
  }
}