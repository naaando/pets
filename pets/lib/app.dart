import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/pages/medicacao_page.dart';
import 'package:pets/pages/home_page.dart';
import 'package:pets/pages/pet_page.dart';
import 'package:pets/pages/welcome_page.dart';
import 'package:pets/provider/user_provider.dart';
import 'package:pets/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loggedUserProvider);

    return MaterialApp(
      title: 'Pets',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const HomePage(),
        '/cadastro-pet': (BuildContext context) => const PetPage(),
        '/cadastro-vacina': (BuildContext context) =>
            const MedicacaoPage(tipoPadrao: 'vacina'),
        '/medicacao': (BuildContext context) => const MedicacaoPage(),
        '/proxima-medicacao': (BuildContext context) => const MedicacaoPage(),
      },
      home: user.when(
        data: (user) => userLoaded(user),
        error: (err, stack) => Text(err.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  Widget userLoaded(user) {
    if (user == null) {
      return WelcomePage();
    }
    return const HomePage();
  }
}
