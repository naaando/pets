import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/pages/cadastro_medicacao_page.dart';
import 'package:pets/pages/home_page.dart';
import 'package:pets/pages/cadastro_pet_page.dart';
import 'package:pets/pages/welcome_page.dart';
import 'package:pets/provider/user_provider.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loggedUserProvider);

    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        // hintColor: Colors.grey.shade300,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          fillColor: Colors.grey.shade100,
          filled: true,
        ),
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        hintColor: Colors.redAccent,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          fillColor: Colors.grey.shade100,
          filled: true,
        ),
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Cuidados com pets',
        theme: theme,
        darkTheme: darkTheme,
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => const HomePage(),
          '/cadastro-pet': (BuildContext context) => const CadastroPetPage(),
          '/cadastro-vacina': (BuildContext context) =>
              const CadastroMedicacaoPage(tipoPadrao: 'vacina'),
          '/cadastro-medicacao': (BuildContext context) =>
              const CadastroMedicacaoPage(),
        },
        home: user.when(
          data: (user) => userLoaded(user),
          error: (err, stack) => Text(err.toString()),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget userLoaded(user) {
    if (user != null) {
      return const HomePage();
    }

    return WelcomePage();
  }
}
