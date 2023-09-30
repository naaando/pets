import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/menu.dart';
import 'package:pets/components/pets_bottom_navigation_bar.dart';
import 'package:pets/components/user_app_bar.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/pages/dashboard_tab.dart';
import 'package:pets/pages/onboarding_page.dart';
import 'package:pets/provider/pet_provider.dart';
import 'package:pets/translate.dart';

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
        data: (pets) => loaded(pets),
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
    return Scaffold(
      body: Center(
        child: Text(
          t().errorWhileLoadingGeneric(
            t().pets.toLowerCase(),
          ),
        ),
      ),
    );
  }

  Widget loaded(Map<String, Pet> pets) {
    if (pets.isEmpty) {
      return const OnboardingPage();
    }

    return defaultView();
  }

  Widget defaultView() {
    final showMenu = useState(false);
    toggle() => showMenu.value = !showMenu.value;

    return Scaffold(
      appBar: const UserAppBar(),
      body: Stack(
        children: [
          TabBarView(
            children: [
              DashboardTab(showMenu),
              const PetsListTab(),
            ],
          ),
          showMenu.value ? Menu(showMenu) : const SizedBox(),
        ],
      ),
      bottomNavigationBar: const PetsBottomNavigationBar(),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: toggle,
        child: showMenu.value ? const Icon(Icons.close) : const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
