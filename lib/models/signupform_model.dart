import 'package:flutter/material.dart';

class SignupFormModel extends ChangeNotifier {
  String email;
  String password;
  String confirmPassword;

  String get getEmail => this.email;
  String get getPassword => this.password;
  String get getConfirmPassowrd => this.confirmPassword;
  set setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  set setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  set setConfirmPassword(String confirmPassword) {
    this.confirmPassword = confirmPassword;
    notifyListeners();
  }

  @override
  String toString() {
    return "Signup Form Model: [ Email: " +
        this.email.toString() +
        ", Password: " +
        this.password.toString() +
        ", Confirm Password: " +
        this.confirmPassword.toString() +
        " ]";
  }
}
