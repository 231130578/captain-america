import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _username = '';
  String _password = '';
  bool _isAuthenticated = false;

  String get username => _username;
  String get password => _password;
  bool get isAuthenticated => _isAuthenticated;

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  Future<bool> login() async {
    // Simulasi login
    await Future.delayed(const Duration(seconds: 1));

    if (_username == 'admin' && _password == 'admin') {
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _isAuthenticated = false;
    _username = '';
    _password = '';
    notifyListeners();
  }
}
