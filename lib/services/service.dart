// ignore_for_file: non_constant_identifier_names
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> fetchToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token != null) {
    return token;
  } else {
    print('Token not found');
  }
  return null;
}

var PROTOCOL = 'http';
var HOST = '10.0.2.2:8000';
var baseUrl = '$PROTOCOL://$HOST';
