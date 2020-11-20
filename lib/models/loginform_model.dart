import 'package:flutter/material.dart';

// model class for login form details
class LoginFormModel extends ChangeNotifier {
  String email;
  String password;

  // getters
  String get getEmail => this.email;
  String get getPassword => this.password;
  // setters
  set setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  set setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  // string version of model object
  @override
  String toString() {
    return "Login Form Model: [ Email: " +
        this.email.toString() +
        ", Password: " +
        this.password.toString() +
        " ]";
  }
}
