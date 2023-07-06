import 'package:dio/dio.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/datetime_form_field.dart';
import 'package:pets/models/medicacao.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/medicacao_provider.dart';
import 'package:pets/provider/pet_provider.dart';

class ProximaMedicacaoPage extends HookConsumerWidget {
  final String tipoPadrao;

  const ProximaMedicacaoPage({super.key, this.tipoPadrao = 'medicacao'});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var medicacaoRouterArg =
        (ModalRoute.of(context)!.settings.arguments as Medicacao?);

    final medicacaoInicial = medicacaoRouterArg ?? Medicacao(tipo: tipoPadrao);
    var medicacao = useRef<Medicacao>(Medicacao.proximaDose(medicacaoInicial));

    var tipo = medicacao.value.tipo;

    var title = 'Próxima ${tipoTexto(tipo)}';
    var formKey = useRef(GlobalKey<FormState>());

    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: barActions(context, ref, formKey.value, medicacao.value),
            ),
            body: body(context, ref, formKey.value, title, medicacao),
            floatingActionButton:
                saveButton(context, ref, formKey.value, medicacao)),
        onWillPop: () async => true);
  }

  salvar(Medicacao medicacao, GlobalKey<FormState> formKey,
      BuildContext context, WidgetRef ref) {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      ref.read(medicacoesProvider.notifier).save(medicacao).then((value) {
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
  }

  FloatingActionButton? saveButton(BuildContext context, WidgetRef ref,
      GlobalKey<FormState> formKey, ObjectRef<Medicacao> medicacao) {
    return FloatingActionButton(
      onPressed: () => salvar(medicacao.value, formKey, context, ref),
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

  Widget body(BuildContext context, WidgetRef ref, GlobalKey<FormState> formKey,
      String title, ObjectRef<Medicacao> medicacao) {
    // Dont watch pets because it will cause a rebuild
    Map<String, Pet> pets =
        ref.read(petsProvider).asData?.value ?? <String, Pet>{};

    final dataController =
        useTextEditingController(text: medicacao.value.quando);
    final proximaDoseController =
        useTextEditingController(text: medicacao.value.proximaDose);

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              DropdownButtonFormField(
                value: medicacao.value.petId,
                decoration: const InputDecoration(
                  hintText: 'Animal',
                  labelText: 'Animal',
                ),
                items: petsDropdown(pets),
                onChanged: (value) => medicacao.value.petId = value,
                validator: (value) =>
                    value == null ? 'Animal é obrigatório' : null,
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
              TextFormField(
                initialValue: medicacao.value.fabricante,
                decoration: const InputDecoration(
                  hintText: 'Fabricante',
                  labelText: 'Fabricante',
                ),
                onSaved: (newValue) =>
                    medicacao.value.fabricante = newValue ?? '',
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: medicacao.value.veterinario,
                decoration: const InputDecoration(
                  hintText: 'Veterinário',
                  labelText: 'Veterinário',
                ),
                onSaved: (newValue) =>
                    medicacao.value.veterinario = newValue ?? '',
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
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: medicacao.value.doseAtual.toString(),
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Dose atual',
                  labelText: 'Dose atual',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Dosagem é obrigatório';
                  }
                  return null;
                },
                onSaved: (newValue) => medicacao.value.doseAtual =
                    int.tryParse(newValue ?? '') ?? 1,
              ),
              const SizedBox(height: 20),
              DateTimeFormField(
                controller: proximaDoseController,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                decoration: const InputDecoration(
                  hintText: 'Próxima dose',
                  labelText: 'Próxima dose',
                  helperText: 'Deixe em branco se não houver',
                  prefixText: 'Em ',
                  suffixIcon: Icon(Icons.alarm_add_rounded),
                ),
                onDateChanged: (dateTime) =>
                    medicacao.value.proximaDose = dateTime?.toIso8601String(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> petsDropdown(Map<String, Pet> pets) {
    return pets.values
        .map((v) => DropdownMenuItem(
              value: v.id,
              child: v.imagem != null
                  ? Row(children: [
                      CircleAvatar(
                        backgroundImage:
                            FastCachedImageProvider(v.imagemUrl.toString()),
                      ),
                      const SizedBox(width: 8),
                      Text(v.nome)
                    ])
                  : Text(v.nome),
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

  String tipoTexto(tipo) {
    switch (tipo) {
      case 'vacina':
        return 'vacina';
      default:
        return 'medicação';
    }
  }
}
