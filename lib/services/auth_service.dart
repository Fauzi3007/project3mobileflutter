import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../services/service.dart'; // Import any necessary service dependencies
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

Future<String> login(String email, String password) async {
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
    print('Token: $token');
    await _secureStorage.write(key: 'access_token', value: token);

    return 'Login successful!';
  } else {
    return 'Login failed. Please check your credentials.';
  }
}

Future<String> me() async {
  final token = await _secureStorage.read(key: 'access_token');
  print('Token: $token');

  final me = await http.get(
    Uri.parse('$baseUrl/api/auth/me'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  print('Response status: ${me.statusCode}');
  print('Response body: ${me.body}');

  if (me.statusCode == 200) {
    final idUser = jsonDecode(me.body)['id'];
    final roleUser = jsonDecode(me.body)['role'];
    if (kDebugMode) {
      print('User ID: $idUser');
    }
    await _secureStorage.write(key: 'id', value: idUser.toString());
    await _secureStorage.write(key: 'role', value: roleUser.toString());

    return 'Fetch data successful!';
  } else {
    return 'Fetch data failed. Please check your credentials.';
  }
}

Future<String> logout() async {
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
