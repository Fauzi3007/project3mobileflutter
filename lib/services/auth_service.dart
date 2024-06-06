import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'service.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);

    final me = await http.get(
      Uri.parse('$baseUrl/api/auth/me'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (me.statusCode == 200) {
      final user = jsonDecode(me.body);
      await prefs.setString('id', jsonEncode(user['id']));
      await prefs.setString('id', jsonEncode(user['hak_akses']));
    }

    return 'Login successful!';
  } else {
    return 'Login failed. Please check your credentials.';
  }
}

Future logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');

  final response = await http.post(
    Uri.parse('$baseUrl/api/auth/logout'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    prefs.remove('access_token');
    return 'Logout successful!';
  } else {
    return 'Logout failed.';
  }
}