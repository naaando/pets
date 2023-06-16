import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/pets_app_bar.dart';
import 'package:pets/models/user.dart';
import 'package:pets/pages/healthcare_tab.dart';
import 'package:pets/pages/pets_tab.dart';
import 'package:pets/provider/espaco_provider.dart';
import 'package:pets/provider/user_provider.dart';

class HomePage extends HookConsumerWidget {
  static const String routeName = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PetsAppBar(),
          body: TabBarView(
            children: [
              PetsTab(),
              // HealthCareTab(),
              Icon(Icons.health_and_safety),
              Icon(Icons.store),
              // Icon(Icons.person_search), Adoção
            ],
          ),
        ));
  }
}
