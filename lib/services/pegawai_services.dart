import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pegawai.dart';
import '../services/service.dart';

class PegawaiService {
  Future<List<Pegawai>> fetchPegawaiList() async {
    final response = await http.get(Uri.parse('$baseUrl/api/pegawai'),
        headers: {
          'Authorization': 'Bearer ${await fetchToken()}',
          'Accept': 'application/json'
        });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Pegawai.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load pegawai');
    }
  }

  Future<List> fetchJabatanCabang(String id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/api/jabatanDanCabang/$id'), headers: {
      'Authorization': 'Bearer ${await fetchToken()}',
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load jabatan cabang');
    }
  }

  Future<Pegawai> fetchPegawai(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/pegawai/$id'),
        headers: {
          'Authorization': 'Bearer ${await fetchToken()}',
          'Accept': 'application/json'
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Pegawai.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load pegawai');
    }
  }

  Future<void> createPegawai(Pegawai pegawai) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pegawai'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await fetchToken()}',
      },
      body: jsonEncode(pegawai.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create pegawai');
    }
  }

  Future<void> updatePegawai(String id, Pegawai pegawai) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pegawai/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await fetchToken()}',
      },
      body: jsonEncode(pegawai.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update pegawai');
    }
  }

  Future<void> deletePegawai(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/pegawai/$id'),
        headers: {
          'Authorization': 'Bearer ${await fetchToken()}',
          'Accept': 'application/json'
        });

    if (response.statusCode != 204) {
      throw Exception('Failed to delete pegawai');
    }
  }
}
