import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/lista_ocorridos.dart';
import 'package:pets/components/lista_pets.dart';
import 'package:pets/components/lista_proximos.dart';
import 'package:pets/provider/pet_provider.dart';

class DashboardTab extends HookConsumerWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: RefreshIndicator(
        child: content(context, ref),
        onRefresh: () => ref.refresh(petsProvider.future),
      ),
    );
  }

  Widget content(BuildContext context, WidgetRef ref) {
    return ListView(
      children: const [
        ListaPets(),
        ListaProximos(),
        ListaOcorridos(),
        SizedBox(height: 20), // Para não ficar escondido pelo FAB
      ],
    );
  }
}
