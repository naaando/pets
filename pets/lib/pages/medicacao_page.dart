import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/components/datetime_form_field.dart';
import 'package:pets/components/pet_dropdown_menu_item_child.dart';
import 'package:pets/models/Medicacao/medicacao.dart';
import 'package:pets/models/Medicacao/repetidor.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/medicacao_provider.dart';
import 'package:pets/provider/pet_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MedicacaoPage extends HookConsumerWidget {
  final String tipoPadrao;

  const MedicacaoPage({
    super.key,
    this.tipoPadrao = 'medicacao',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicacaoRouterArg =
        (ModalRoute.of(context)!.settings.arguments as Medicacao?);

    final medicacaoOriginal = medicacaoRouterArg?.copyWith(
          completado: medicacaoRouterArg.deveCompletar(),
        ) ??
        Medicacao(tipo: tipoPadrao);

    final medicacao = useState<Medicacao>(medicacaoOriginal);

    final proximaData = useState<String?>(null);

    final title = medicacao.value.id != null
        ? AppLocalizations.of(context)!
            .shared_editing(medicacao.value.tipoExtenso.toLowerCase())
        : AppLocalizations.of(context)!
            .shared_new(medicacao.value.tipoExtenso.toLowerCase());

    final formKey = useRef(GlobalKey<FormState>());

    return WillPopScope(
      onWillPop: () => pedirParaSalvarDialog(
        context,
        medicacaoOriginal,
        medicacao,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: barActions(
            context,
            ref,
            formKey.value,
            medicacao.value,
          ),
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
    );
  }

  Future<bool> pedirParaSalvarDialog(
    BuildContext context,
    Medicacao? medicacaoRouterArg,
    ValueNotifier<Medicacao> medicacao,
  ) async {
    if (medicacaoRouterArg == medicacao.value) {
      return true;
    }

    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.shared_exit_without_saving,
        ),
        content: Text(
          AppLocalizations.of(context)!.shared_exit_without_saving_message,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(true);
            },
            child: Text(
              AppLocalizations.of(context)!.shared_exit_without_saving_confirm,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(false);
            },
            child: Text(
              AppLocalizations.of(context)!.shared_exit_without_saving_abort,
            ),
          ),
        ],
      ),
    );
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

        if (!formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.shared_invalid_fields),
            ),
          );

          return;
        }

        ref
            .read(medicacoesProvider.notifier)
            .save(
              medicacao.value,
              proximaData,
            )
            .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.shared_saved),
            ),
          );

          Navigator.of(context).pop();
        }).onError((DioException error, stackTrace) {
          debugPrint(error.toString());
          var msg = error.response?.data['message'] ?? error.message;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.shared_error_while_saving(msg),
              ),
            ),
          );
        });
      },
      tooltip: AppLocalizations.of(context)!.shared_save,
      child: const Icon(Icons.check),
    );
  }

  List<Widget> barActions(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormState> formKey,
    Medicacao medicacao,
  ) {
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

    return Form(
      key: formKey,
      child: ListView(
        children: [
          conteudoPrincipal(context, medicacao, pets),
          outrasInformacoes(context, medicacao),
          if (kDebugMode) repetir(context, medicacao, proximaData),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  ExpansionTile conteudoPrincipal(
    BuildContext context,
    ValueNotifier<Medicacao> medicacao,
    Map<String, Pet> pets,
  ) {
    return ExpansionTile(
      title: Text(AppLocalizations.of(context)!.medicine_main),
      leading: const Icon(Icons.event),
      initiallyExpanded: true,
      childrenPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      children: [
        DropdownButtonFormField<String>(
          value: medicacao.value.tipo,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.medicine_type,
            labelText: AppLocalizations.of(context)!.medicine_type,
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
          onChanged: (String? value) {
            medicacao.value =
                medicacao.value.copyWith(tipo: value ?? 'medicacao');
          },
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<Pet?>(
          value: medicacao.value.pet,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.medicine_animal,
            labelText: AppLocalizations.of(context)!.medicine_animal,
          ),
          items: petsDropdown(context, medicacao.value.pet, pets),
          onChanged: (Pet? value) {
            medicacao.value = medicacao.value.copyWith(petId: value?.id);
            medicacao.value = medicacao.value.copyWith(pet: value);
          },
          validator: (value) => value == null
              ? AppLocalizations.of(context)!.medicine_animal_required
              : null,
        ),
        const SizedBox(height: 20),
        TextFormField(
          initialValue: medicacao.value.nome,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.medicine_name,
            labelText: AppLocalizations.of(context)!.medicine_name,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.medicine_name_required;
            }
            return null;
          },
          onChanged: (newValue) {
            medicacao.value = medicacao.value.copyWith(nome: newValue);
          },
        ),
        const SizedBox(height: 20),
        DateTimeFormField(
          initialValue: medicacao.value.quando,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.medicine_date,
            labelText: AppLocalizations.of(context)!.medicine_date,
            prefixText: AppLocalizations.of(context)!.medicine_prefix_on,
            suffixIcon: Icon(Icons.alarm_on_rounded),
          ),
          onDateChanged: (dateTime) {
            medicacao.value =
                medicacao.value.copyWith(quando: dateTime?.toIso8601String());
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.medicine_date_required;
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  List<Widget> quandoDataForPassadoExibirProximaData(
    BuildContext context,
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
        initialValue: proximaData.value,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.medicine_next_dose,
          labelText: AppLocalizations.of(context)!.medicine_next_dose,
          helperText: AppLocalizations.of(context)!.medicine_next_dose_optional,
          prefixText: AppLocalizations.of(context)!.medicine_prefix_on,
          suffixIcon: Icon(Icons.alarm_add_rounded),
        ),
        onDateChanged: (dateTime) =>
            proximaData.value = dateTime?.toIso8601String(),
      )
    ];
  }

  List<DropdownMenuItem<Pet?>> petsDropdown(
    BuildContext context,
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
        DropdownMenuItem(
          value: null,
          child: Text(AppLocalizations.of(context)!.shared_unknown),
        ),
      );
  }

  void showDeleteAlert(
    BuildContext context,
    WidgetRef ref,
    Medicacao medicacao,
  ) {
    AlertDialog alert = AlertDialog(
      title: Text(AppLocalizations.of(context)!.medicine_delete),
      content: Text(
        AppLocalizations.of(context)!.medicine_delete_content(medicacao.nome),
      ),
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context)!.shared_cancel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(AppLocalizations.of(context)!.shared_exclude),
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

  Widget outrasInformacoes(
    BuildContext context,
    ValueNotifier<Medicacao> medicacao,
  ) {
    return ExpansionTile(
      title: Text(AppLocalizations.of(context)!.medicine_other_info),
      leading: const Icon(Icons.dataset),
      childrenPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      children: [
        TextFormField(
          initialValue: medicacao.value.atributos.fabricante,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.medicine_producer,
            labelText: AppLocalizations.of(context)!.medicine_producer,
          ),
          onChanged: (newValue) {
            medicacao.value =
                medicacao.value.copyWith.atributos(fabricante: newValue);
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          initialValue: medicacao.value.atributos.veterinario,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.medicine_veterinary,
            labelText: AppLocalizations.of(context)!.medicine_veterinary,
          ),
          onChanged: (newValue) {
            medicacao.value =
                medicacao.value.copyWith.atributos(veterinario: newValue);
          },
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget repetir(
    BuildContext context,
    ValueNotifier<Medicacao> medicacao,
    ValueNotifier<String?> proximaData,
  ) {
    repetidor() => medicacao.value.atributos.repetidor;

    atualizaRepetidor(Repetidor repetidor) {
      medicacao.value =
          medicacao.value.copyWith.atributos(repetidor: repetidor);
    }

    return ExpansionTile(
      title: const Text('Repetir'),
      leading: const Icon(Icons.alarm),
      childrenPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                initialValue: repetidor().intervaloValor,
                decoration: const InputDecoration(
                  hintText: 'Intervalo',
                  labelText: 'Intervalo',
                ),
                onChanged: (value) {
                  atualizaRepetidor(
                    repetidor().copyWith(intervaloValor: value),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 60,
                child: DropdownButtonFormField(
                  value: repetidor().intervaloTipo,
                  items: ['horas', 'dias']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    atualizaRepetidor(
                      repetidor().copyWith(intervaloTipo: value),
                    );
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
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                initialValue: repetidor().duranteValor,
                decoration: const InputDecoration(
                  hintText: 'Durante',
                  labelText: 'Durante',
                ),
                onChanged: (value) {
                  atualizaRepetidor(
                    repetidor().copyWith(duranteValor: value),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 60,
                child: DropdownButtonFormField(
                  value: repetidor().duranteTipo,
                  items: ['vezes', 'dias', 'meses']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    atualizaRepetidor(
                      repetidor().copyWith(duranteTipo: value),
                    );
                  },
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            const TableRow(children: [
              Text('Quando'),
            ]),
            ...debugHorarios(
              medicacao,
              repetidor().intervaloValor,
              repetidor().intervaloTipo,
              repetidor().duranteValor,
              repetidor().duranteTipo,
            ).map((e) => TableRow(children: [e])).toList(),
          ],
        ),
      ],
    );
  }

  List debugHorarios(
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

    return list.map((Jiffy date) => Text(date.yMMMEdjm)).toList();
  }
}
