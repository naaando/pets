import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/main_tab_bar.dart';
import 'package:pets/components/user_app_bar.dart';
import 'package:pets/pages/dashboard_tab.dart';
import 'package:pets/pages/pets_tab.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: const UserAppBar(),
            body: const TabBarView(
              children: [
                DashboardTab(),
                PetsTab(),
              ],
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Container(
                color: Colors.red,
                padding: const EdgeInsets.only(top: 10),
                child: MainTabBar(),
              ),
            )));
  }
}
