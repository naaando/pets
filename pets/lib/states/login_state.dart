import 'package:flutter/material.dart';
import 'package:pets/models/usuario.dart';

class LoginState extends ChangeNotifier {
  User? user;
  get isLogged => user != null;

  void login() {
    user = User();
    notifyListeners();
  }
}