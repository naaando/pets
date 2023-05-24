import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  bool loggedIn = false;

  void login() {
    loggedIn = true;
    notifyListeners();
  }
}
