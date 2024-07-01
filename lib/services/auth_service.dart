import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../services/service.dart'; // Import any necessary service dependencies
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

Future<String> loginService(String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/api/auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final token = jsonDecode(response.body)['access_token'];
    final idUser = jsonDecode(response.body)['id_user'];
    final idPegawai = jsonDecode(response.body)['id_pegawai'];
    final roleUser = jsonDecode(response.body)['hak_akses'];
    if (kDebugMode) {
      print('User ID: $idUser');
      print('Pegawai ID: $idPegawai');
      print('User Role: $roleUser');
      print('Token: $token');
    }
    await _secureStorage.write(key: 'id_user', value: idUser.toString());
    await _secureStorage.write(key: 'id_pegawai', value: idPegawai.toString());
    await _secureStorage.write(key: 'role', value: roleUser.toString());
    await _secureStorage.write(key: 'access_token', value: token);

    return 'Login successful!';
  } else {
    return 'Login failed. Please check your credentials.';
  }
}

Future<String> logoutService() async {
  final token = await _secureStorage.read(key: 'access_token');

  final response = await http.post(
    Uri.parse('$baseUrl/api/auth/logout'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    await _secureStorage.delete(key: 'access_token');
    return 'Logout successful!';
  } else {
    return 'Logout failed.';
  }
}
