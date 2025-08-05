import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _loggedIn = false;
  String? _token;
  String? _error;

  bool get loggedIn => _loggedIn;
  String? get token => _token;
  String? get error => _error;

  Future<bool> login(String username, String password) async {
    _error = null;
    // Simulación de login: demo/1234
    if (username == 'demo' && password == '1234') {
      _loggedIn = true;
      _token = 'fake-token';
      notifyListeners();
      return true;
    } else {
      _error = 'Usuario o contraseña incorrectos';
      _loggedIn = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _loggedIn = false;
    _token = null;
    notifyListeners();
  }
}