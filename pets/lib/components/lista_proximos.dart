import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/components/my_physical_shape.dart';
import 'package:pets/components/pet_avatar.dart';
import 'package:pets/components/placeholder_proximos.dart';
import 'package:pets/models/medicacao.dart';
import 'package:pets/provider/eventos_provider.dart';

import 'chip_evento.dart';
import 'skeleton_list_tile.dart';

class ListaProximos extends ConsumerWidget {
  final ValueNotifier<bool> showMenu;

  const ListaProximos(this.showMenu, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Agendados',
          textAlign: TextAlign.start,
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 8),
        ref.watch(eventosProvider).when(
              data: (medicacoes) => lista(
                context,
                medicacoes.where((m) => !m.completado).toList(),
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
      return PlaceholderProximos(showMenu);
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
    String? thumbUrl = pet.imagem != null ? pet.imagemUri.toString() : null;
    String title = pet.nome;
    String subtitle = medicacao.nome;
    Jiffy date = Jiffy.parse(medicacao.quando!, isUtc: true).toLocal();
    bool isPast = date.isAfter(Jiffy.now());

    final scheme = Theme.of(context).colorScheme;
    final defaultTileColor = Theme.of(context).colorScheme.primary;
    Color tileColor = isPast ? defaultTileColor : Colors.yellow.shade700;

    var widget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: MyPhysicalShape(
        color: tileColor,
        child: ListTile(
          leading: PetAvatar.fromPet(pet),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(date.fromNow()),
                  const SizedBox(height: 4),
                  ChipEvento.parse(medicacao.tipo),
                ],
              ),
              const SizedBox(width: 8),
              IconButton.outlined(
                padding: const EdgeInsets.all(8),
                onPressed: () {},
                icon: const Icon(Icons.check),
                color: scheme.primary,
              ),
            ],
          ),
          onTap: () => Navigator.pushNamed(
            context,
            '/proxima-medicacao',
            arguments: medicacao,
          ),
        ),
      ),
    );

    return MapEntry(date.millisecondsSinceEpoch, widget);
  }
}
