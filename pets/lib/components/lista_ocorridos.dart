import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/components/my_physical_shape.dart';
import 'package:pets/components/pet_avatar.dart';
import 'package:pets/components/placeholder_ocorridos.dart';
import 'package:pets/models/Medicacao/medicacao.dart';
import 'package:pets/provider/eventos_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'chip_evento.dart';
import 'skeleton_list_tile.dart';

class ListaOcorridos extends ConsumerWidget {
  final ValueNotifier<bool> showMenu;

  const ListaOcorridos(this.showMenu, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t!.dashboard_timeline,
          textAlign: TextAlign.start,
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 8),
        ref.watch(eventosProvider).when(
              data: (medicacoes) => lista(
                context,
                medicacoes.where((m) => m.completado).toList(),
              ),
              error: erro,
              loading: carregando,
            ),
      ],
    );
  }

  Column erro(Object error, StackTrace? stackTrace) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Erro ao carregar agendamentos'),
        ),
      ],
    );
  }

  Column carregando() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          child: SkeletonListTile(),
        ),
      ],
    );
  }

  Widget lista(BuildContext context, List<Medicacao> medicacoes) {
    if (medicacoes.isEmpty) {
      return PlaceholderOcorridos(showMenu);
    }

    final medicacoesComoEvento = medicacoes
        .map<MapEntry<int, Widget>>(
            (medicacao) => medicacaoComoEvento(context, medicacao))
        .toList();

    final eventosPorData = medicacoesComoEvento
      ..sort((a, b) => b.key.compareTo(a.key));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: eventosPorData.map((e) => e.value).toList(),
    );
  }

  MapEntry<int, Widget> medicacaoComoEvento(
    BuildContext context,
    Medicacao medicacao,
  ) {
    final pet = medicacao.pet!;
    String title = pet.nome;
    String subtitle = medicacao.nome;
    Jiffy date = Jiffy.parse(medicacao.quando!, isUtc: true).toLocal();

    final defaultTileColor = Theme.of(context).colorScheme.primaryContainer;

    var widget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: MyPhysicalShape(
        color: defaultTileColor,
        child: ListTile(
          leading: PetAvatar.fromPet(pet),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(date.fromNow()),
            const SizedBox(height: 4),
            ChipEvento.parse(medicacao.tipo)
          ]),
          onTap: () => Navigator.pushNamed(
            context,
            '/medicacao',
            arguments: medicacao,
          ),
        ),
      ),
    );

    return MapEntry(date.millisecondsSinceEpoch, widget);
  }
}
