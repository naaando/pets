import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:pets/pages/home.dart';
import 'package:pets/pages/pet.dart';
import 'package:pets/pages/welcome.dart';
import 'package:pets/provider/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider.notifier);

    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          fillColor: Colors.grey.shade100,
          filled: true,
        ),
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          fillColor: Colors.grey.shade100,
          filled: true,
        ),
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Adaptive Theme Demo',
        theme: theme,
        darkTheme: darkTheme,
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => const HomePage(),
          '/pet': (BuildContext context) => const PetPage(),
        },
        home: StreamBuilder(
          stream: user.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return WelcomePage();
            }
          },
        ),
      ),
    );
  }
}
