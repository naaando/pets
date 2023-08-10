import 'package:dio/dio.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/components/datetime_form_field.dart';
import 'package:pets/components/pet_dropdown_menu_item_child.dart';
import 'package:pets/models/medicacao.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/medicacao_provider.dart';
import 'package:pets/provider/pet_provider.dart';

class MedicacaoPage extends HookConsumerWidget {
  final String tipoPadrao;

  const MedicacaoPage({
    super.key,
    this.tipoPadrao = 'medicacao',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var medicacaoRouterArg =
        (ModalRoute.of(context)!.settings.arguments as Medicacao?);

    var medicacao =
        useState<Medicacao>(medicacaoRouterArg ?? Medicacao(tipo: tipoPadrao));
    medicacao.value.deveCompletar();

    var proximaData = useState<String?>(null);

    var title = medicacao.value.id != null
        ? 'Editando ${medicacao.value.tipoExtenso}'
        : 'Nova ${medicacao.value.tipoExtenso}';

    var formKey = useRef(GlobalKey<FormState>());

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: barActions(context, ref, formKey.value, medicacao.value),
          ),
          body: body(
            context,
            ref,
            formKey.value,
            title,
            medicacao,
            proximaData,
          ),
          floatingActionButton: saveButton(
            context,
            ref,
            formKey.value,
            medicacao,
            proximaData.value,
          ),
        ),
        onWillPop: () async => true);
  }

  FloatingActionButton? saveButton(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormState> formKey,
    ValueNotifier<Medicacao> medicacao,
    String? proximaData,
  ) {
    return FloatingActionButton(
      onPressed: () {
        formKey.currentState!.save();

        if (formKey.currentState!.validate()) {
          ref
              .read(medicacoesProvider.notifier)
              .save(
                medicacao.value,
                proximaData,
              )
              .then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Salvo!')),
            );

            Navigator.of(context).pop();
          }).onError((DioException error, stackTrace) {
            debugPrint(error.toString());
            var msg = error.response?.data['message'] ?? error.message;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro ao salvar!\n\n$msg')),
            );
          });
        }
      },
      tooltip: 'Salvar',
      child: const Icon(Icons.check),
    );
  }

  List<Widget> barActions(BuildContext context, WidgetRef ref,
      GlobalKey<FormState> formKey, Medicacao medicacao) {
    if (medicacao.id != null) {
      return [
        IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => showDeleteAlert(context, ref, medicacao))
      ];
    }

    return [];
  }

  Widget body(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormState> formKey,
    String title,
    ValueNotifier<Medicacao> medicacao,
    ValueNotifier<String?> proximaData,
  ) {
    // Dont watch pets cause it will cause a rebuild
    Map<String, Pet> pets =
        ref.read(petsProvider).asData?.value ?? <String, Pet>{};

    final dataController = useTextEditingController(
      text: medicacao.value.quando,
    );

    return Form(
      key: formKey,
      child: ListView(
        children: [
          conteudoPrincipal(medicacao, pets, dataController),
          outrasInformacoes(medicacao),
          repetir(medicacao, proximaData),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  conteudoPrincipal(medicacao, pets, dataController) {
    return ExpansionTile(
      title: const Text('Principal'),
      leading: const Icon(Icons.event),
      initiallyExpanded: true,
      childrenPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      children: [
        DropdownButtonFormField<String>(
          value: medicacao.value.tipo,
          decoration: const InputDecoration(
            hintText: 'Tipo',
            labelText: 'Tipo',
          ),
          items: const [
            DropdownMenuItem(
              value: 'medicacao',
              child: Text('Medicação'),
            ),
            DropdownMenuItem(
              value: 'vacina',
              child: Text('Vacina'),
            ),
            DropdownMenuItem(
              value: 'vermifugo',
              child: Text('Vermífugo'),
            )
          ],
          onChanged: (String? value) =>
              medicacao.value.tipo = value ?? 'medicacao',
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<Pet?>(
          value: medicacao.value.pet,
          decoration: const InputDecoration(
            hintText: 'Animal',
            labelText: 'Animal',
          ),
          items: petsDropdown(medicacao.value.pet, pets),
          onChanged: (Pet? value) {
            medicacao.value.petId = value?.id;
            medicacao.value.pet = value;
          },
          validator: (value) => value == null ? 'Animal é obrigatório' : null,
        ),
        const SizedBox(height: 20),
        TextFormField(
          initialValue: medicacao.value.nome,
          decoration: const InputDecoration(
            hintText: 'Nome',
            labelText: 'Nome',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Nome é obrigatório';
            }
            return null;
          },
          onSaved: (newValue) => medicacao.value.nome = newValue ?? '',
        ),
        const SizedBox(height: 20),
        DateTimeFormField(
          controller: dataController,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          decoration: const InputDecoration(
            hintText: 'Data',
            labelText: 'Data',
            prefixText: 'Em ',
            suffixIcon: Icon(Icons.alarm_on_rounded),
          ),
          onDateChanged: (dateTime) {
            medicacao.value.quando = dateTime?.toIso8601String();
            medicacao.notifyListeners();
          },
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  List<Widget> quandoDataForPassadoExibirProximaData(
    ValueNotifier<Medicacao> medicacao,
    ValueNotifier<String?> proximaData,
  ) {
    final proximaDoseController = useTextEditingController(
      text: proximaData.value ?? '',
    );

    if (medicacao.value.quando is! String) {
      return [];
    }

    if (Jiffy.parse(medicacao.value.quando!, isUtc: true)
        .toLocal()
        .isAfter(Jiffy.now())) {
      return [];
    }

    return [
      const SizedBox(height: 20),
      DateTimeFormField(
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        controller: proximaDoseController,
        decoration: const InputDecoration(
          hintText: 'Próxima dose',
          labelText: 'Próxima dose',
          helperText: 'Em branco se não houver próxima dose',
          prefixText: 'Em ',
          suffixIcon: Icon(Icons.alarm_add_rounded),
        ),
        onDateChanged: (dateTime) =>
            proximaData.value = dateTime?.toIso8601String(),
      )
    ];
  }

  List<DropdownMenuItem<Pet?>> petsDropdown(
    Pet? currentPet,
    Map<String, Pet> pets,
  ) {
    if (currentPet != null && currentPet.id != null) {
      pets.update(currentPet.id!, (value) => currentPet);
    }

    return pets.values
        .map((pet) => DropdownMenuItem(
              value: pet,
              child: PetDropdownMenuItemChild(pet),
            ))
        .toList()
      ..insert(
          0,
          const DropdownMenuItem(
            value: null,
            child: Text('Desconhecido'),
          ));
  }

  showDeleteAlert(BuildContext context, WidgetRef ref, Medicacao medicacao) {
    AlertDialog alert = AlertDialog(
      title: const Text("Excluir medicação"),
      content: Text("Você tem certeza que deseja excluir ${medicacao.nome}?"),
      actions: [
        TextButton(
          child: const Text("Cancelar"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text("Excluir"),
          onPressed: () {
            ref.read(medicacoesProvider.notifier).remove(medicacao);
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  outrasInformacoes(medicacao) {
    return ExpansionTile(
      title: const Text('Outras informações'),
      leading: const Icon(Icons.dataset),
      childrenPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      children: [
        TextFormField(
          initialValue: medicacao.value.fabricante,
          decoration: const InputDecoration(
            hintText: 'Fabricante',
            labelText: 'Fabricante',
          ),
          onSaved: (newValue) => medicacao.value.fabricante = newValue ?? '',
        ),
        const SizedBox(height: 20),
        TextFormField(
          initialValue: medicacao.value.veterinario,
          decoration: const InputDecoration(
            hintText: 'Veterinário',
            labelText: 'Veterinário',
          ),
          onSaved: (newValue) => medicacao.value.veterinario = newValue ?? '',
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  repetir(medicacao, proximaData) {
    var repetidor = useState({});

    return ExpansionTile(
      title: const Text('Repetir'),
      leading: const Icon(Icons.alarm),
      childrenPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      children: [
        Row(
          children: [
            Expanded(
                child: TextFormField(
              initialValue: repetidor.value['repetir_em.intervalo'],
              decoration: const InputDecoration(
                hintText: 'Intervalo',
                labelText: 'Intervalo',
              ),
              onChanged: (value) {
                repetidor.value['repetir_em.intervalo'] = value;
                repetidor.value = {...repetidor.value};
              },
            )),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 60,
                child: DropdownButtonFormField(
                  value: repetidor.value['repetir_em.tipo'],
                  items: ['minutos', 'horas', 'dias']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    repetidor.value['repetir_em.tipo'] = value;
                    repetidor.value = {...repetidor.value};
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
                child: TextFormField(
              initialValue: repetidor.value['durante.intervalo'],
              decoration: const InputDecoration(
                hintText: 'Durante',
                labelText: 'Durante',
              ),
              onChanged: (value) {
                repetidor.value['durante.intervalo'] = value;
                repetidor.value = {...repetidor.value};
              },
            )),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 60,
                child: DropdownButtonFormField(
                  value: repetidor.value['durante.tipo'],
                  items: ['vezes', 'horas', 'dias', 'mes']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    repetidor.value['durante.tipo'] = value;
                    repetidor.value = {...repetidor.value};
                  },
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        ...debugHorarios(
          medicacao,
          repetidor.value['repetir_em.intervalo'],
          repetidor.value['repetir_em.tipo'],
          repetidor.value['durante.intervalo'],
          repetidor.value['durante.tipo'],
        ),
      ],
    );
  }

  debugHorarios(
    medicacao,
    String? repetirEmIntervalo,
    String? repetirEmTipo,
    String? duranteIntervalo,
    String? duranteTipo,
  ) {
    var filled = [
      medicacao.value.quando,
      repetirEmIntervalo,
      repetirEmTipo,
      duranteIntervalo,
      duranteTipo
    ].every((element) => element is String && element != '');

    if (!filled) {
      return [];
    }

    var quando = Jiffy.parse(medicacao.value.quando, isUtc: true).toLocal();

    var last = quando.addDuration(Duration(
      days: int.parse(duranteIntervalo!),
    ));

    var list = <Jiffy>[];

    var current = quando;
    while (current.isBefore(last)) {
      list.add(current);
      current = current.add(
        hours: int.parse(repetirEmIntervalo!),
      );
    }

    return list.map((Jiffy date) => Text(date.yMMMEdjm));
  }
}
