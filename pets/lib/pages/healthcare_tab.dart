import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/models/remedio.dart';
import 'package:pets/provider/remedio_provider.dart';

class HealthCareTab extends HookConsumerWidget {
  const HealthCareTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var remedios = ref.watch(remediosProvider);

    return Scaffold(
        body: remedios.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => throw err,
      data: (remedios) => body(context, remedios),
    ));
  }

  Widget body(BuildContext context, Map<String, Remedio> remedios) {
    var headerStyle = Theme.of(context).textTheme.titleLarge;

    var remediosAgendados = remedios.values
        .where((element) => element.administrado == null)
        .toList();

    var remediosAdministrados = remedios.values
        .where((element) => element.administrado != null)
        .toList();

    var remediosAgendadosSection = remediosAgendados.isNotEmpty
        ? [
            Text(
              'Remédios agendados',
              style: headerStyle,
            ),
            const SizedBox(height: 10),
            ...remediosAgendados.map((e) => remedioItem(context, e)).toList(),
          ]
        : [];

    var divider =
        remediosAgendados.isNotEmpty && remediosAdministrados.isNotEmpty
            ? [const Divider(color: Colors.grey)]
            : [];

    var remediosAdministradosSection = remediosAdministrados.isNotEmpty
        ? [
            Text(
              'Histórico de remédios administrados',
              style: headerStyle,
            ),
            const SizedBox(height: 10),
            ...remediosAdministrados
                .map((e) => remedioItem(context, e))
                .toList(),
          ]
        : [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        const SizedBox(height: 10),
        ...remediosAgendadosSection,
        ...divider,
        ...remediosAdministradosSection,
      ]),
    );
  }

  Widget remedioItem(context, Remedio remedio) {
    var animalNome = remedio.animal?.nome ?? '';
    var remedioNome = remedio.nome ?? '';
    var dose = remedio.dose;
    var totalDoses = remedio.tipoRemedio?.doses;

    var administrado = Jiffy.parse(remedio.administrado!).fromNow();

    var title = Text(remedioNome);

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          leading: CircleAvatar(
            foregroundImage:
                NetworkImage(remedio.animal!.fotoPerfilUrl.toString()),
            child: Text(animalNome.toUpperCase().substring(0, 2)),
          ),
          title: title,
          tileColor: Colors.red.shade50,
          subtitle: Text(animalNome),
          trailing: Text('$administrado\nDose $dose de $totalDoses',
              textAlign: TextAlign.end),
        ));
  }
}
