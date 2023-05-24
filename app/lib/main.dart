import 'package:flutter/material.dart';
import 'package:petIdApp/providers/user_provider.dart';
import 'package:petIdApp/view/login_page.dart';
import 'package:petIdApp/view/pet_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return userProvider.loggedIn ? PetPage() : LoginPage();
        },
      ),
    );
  }
}
