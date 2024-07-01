import 'package:flutter/material.dart';
import '.././services/auth_service.dart';

class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final message = await loginService(email, password);
      _errorMessage = message;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      final message = await logoutService();
      _errorMessage = message;
    } catch (e) {
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}
