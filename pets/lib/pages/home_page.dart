import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/main_tab_bar.dart';
import 'package:pets/components/user_app_bar.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/pages/dashboard_tab.dart';
import 'package:pets/pages/onboarding_page.dart';
import 'package:pets/pages/pets_tab.dart';
import 'package:pets/provider/pet_provider.dart';

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
    return Scaffold(
      appBar: const UserAppBar(),
      body: const TabBarView(
        children: [
          DashboardTab(),
          PetsTab(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 6),
        margin: const EdgeInsets.all(6),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: MainTabBar(),
      ),
    );
  }

  Widget emptyPetList() {
    return const OnboardingPage();
  }
}
