// ignore_for_file: non_constant_identifier_names
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

Future<String?> fetchToken() async {
  String? token = await _secureStorage.read(key: 'access_token');

  if (token != null) {
    return token;
  } else {
    print('Token not found');
    return null;
  }
}

Future<int?> fetchUserId() async {
  String? userIdStr = await _secureStorage.read(key: 'id');

  if (userIdStr != null) {
    return int.tryParse(userIdStr);
  } else {
    print('User ID not found');
    return null;
  }
}

const String PROTOCOL = 'https';
const String HOST = 'shining-verified-mantis.ngrok-free.app';
const String baseUrl = '$PROTOCOL://$HOST';
