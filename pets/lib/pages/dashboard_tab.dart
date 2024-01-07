import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/lista_ocorridos.dart';
import 'package:pets/components/lista_pets.dart';
import 'package:pets/components/lista_proximos.dart';
import 'package:pets/components/small_native_ad.dart';
import 'package:pets/provider/pet_provider.dart';

class DashboardTab extends HookConsumerWidget {
  final ValueNotifier<bool> showMenu;

  const DashboardTab(this.showMenu, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: RefreshIndicator(
        child: SingleChildScrollView(
          child: content(context, ref),
        ),
        onRefresh: () => ref.refresh(petsProvider.future),
      ),
    );
  }

  Widget content(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 12),
          child: const ListaPets(),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: SmallNativeAd(
            scheme: Theme.of(context).colorScheme,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          child: ListaProximos(showMenu),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          child: ListaOcorridos(showMenu),
        ),
        const SizedBox(height: 100), // Para não ficar escondido pelo FAB
      ],
    );
  }
}
