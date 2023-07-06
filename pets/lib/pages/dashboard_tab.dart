import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/fab_actions.dart';
import 'package:pets/components/lista_ocorridos.dart';
import 'package:pets/components/lista_pets.dart';
import 'package:pets/components/lista_proximos.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';

class DashboardTab extends HookConsumerWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: content(context, ref), floatingActionButton: const FabActions());
  }

  Widget content(BuildContext context, WidgetRef ref) {
    var themeData = Theme.of(context).copyWith(
        cardTheme: CardTheme.of(context).copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: Colors.grey[200],
      elevation: 0,
    ));

    return Theme(
        data: themeData,
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'Seus pets',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            ListaPets(),
            SizedBox(height: 18),
            ListaProximos(),
            ListaOcorridos(),
            SizedBox(height: 80), // Para não ficar escondido pelo FAB
          ],
        ));
  }
}
