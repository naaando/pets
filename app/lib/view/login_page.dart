import 'package:flutter/material.dart';
import 'package:petIdApp/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Faça login'),
            Consumer<UserProvider>(
              builder: (context, user, child) => Text(
                '${user.loggedIn}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            RaisedButton(
              child: Text('Entrar'),
              onPressed: () {
                var userService = context.read<UserProvider>();
                userService.login();
              },
            ),
          ],
        ),
      ),
    );
  }
}
