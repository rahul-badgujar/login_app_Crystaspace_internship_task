import 'package:flutter/material.dart';

class LoginFormModel extends ChangeNotifier {
  String email;
  String password;

  String get getEmail => this.email;
  String get getPassword => this.password;
  set setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  set setPassword(String password) {
    this.password = password;
    notifyListeners();
  }
}
