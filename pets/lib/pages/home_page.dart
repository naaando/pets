import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/pets_bottom_navigation_bar.dart';
import 'package:pets/components/user_app_bar.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/pages/dashboard_tab.dart';
import 'package:pets/pages/onboarding_page.dart';
import 'package:pets/provider/pet_provider.dart';

import 'pets_list_tab.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pets = ref.watch(petsProvider);

    return DefaultTabController(
      length: 2,
      child: pets.when(
        loading: loading,
        error: error,
        data: loaded,
      ),
    );
  }

  Widget loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget error(Object obj, StackTrace trace) {
    return const Scaffold(
      body: Center(
        child: Text('Erro ao carregar pets'),
      ),
    );
  }

  Widget loaded(Map<String, Pet> pets) {
    if (pets.isEmpty) {
      return emptyPetList();
    }

    return defaultView();
  }

  Widget defaultView() {
    return const Scaffold(
      appBar: UserAppBar(),
      body: TabBarView(
        children: [
          DashboardTab(),
          PetsListTab(),
        ],
      ),
      bottomNavigationBar: PetsBottomNavigationBar(),
    );
  }

  Widget emptyPetList() {
    return const OnboardingPage();
  }
}
