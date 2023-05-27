import 'package:flutter/material.dart';
import 'package:pets/pages/home.dart';
import 'package:pets/pages/login.dart';
import 'package:pets/pages/welcome.dart';
import 'package:pets/states/login_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginState(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer<LoginState>(
        builder: (context, loginState, child) {
          if (!loginState.isLogged) {
            return WelcomePage();
          }

          return const HomePage(title: 'Home Page');
        },
      ),
    );
  }
}
