// ignore_for_file: non_constant_identifier_names
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> fetchToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');

  if (token != null) {
    return token;
  } else {
    print('Token not found');
  }
  return null;
}

Future<String?> fetchUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('id');

  if (token != null) {
    return token;
  } else {
    print('Token not found');
  }
  return null;
}

var PROTOCOL = 'https';
var HOST = 'shining-verified-mantis.ngrok-free.app';
var baseUrl = '$PROTOCOL://$HOST';
