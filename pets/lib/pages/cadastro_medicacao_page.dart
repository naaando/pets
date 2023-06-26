import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/medicacao.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/medicacao_provider.dart';
import 'package:pets/provider/pet_provider.dart';
import 'package:intl/intl.dart';
import 'package:pets/provider/user_provider.dart';

class CadastroMedicacaoPage extends HookConsumerWidget {
  const CadastroMedicacaoPage({super.key});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(loggedUserProvider).asData!.value!;

    var medicacao = useRef<Medicacao>(
        (ModalRoute.of(context)!.settings.arguments as Medicacao?) ??
            Medicacao());

    var title = 'Nova medicacao';
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
    // Dont watch pets cause it will cause a rebuild
    Map<String, Pet> pets =
        ref.read(petsProvider).asData?.value ?? <String, Pet>{};

    final dataController = makeController(medicacao.value.quando);

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
                    onSaved: (newValue) =>
                        medicacao.value.nome = newValue ?? medicacao.value.nome,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: medicacao.value.fabricante,
                    decoration: const InputDecoration(
                      hintText: 'Fabricante',
                      labelText: 'Fabricante',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Fabricante é obrigatório';
                      }
                      return null;
                    },
                    onSaved: (newValue) => medicacao.value.fabricante =
                        newValue ?? medicacao.value.fabricante,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: medicacao.value.veterinario,
                    decoration: const InputDecoration(
                      hintText: 'Veterinário',
                      labelText: 'Veterinário',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veterinário é obrigatório';
                      }
                      return null;
                    },
                    onSaved: (newValue) => medicacao.value.veterinario =
                        newValue ?? medicacao.value.veterinario,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: dataController,
                      decoration: const InputDecoration(
                        hintText: 'Data',
                        labelText: 'Data',
                        suffixIcon: Icon(Icons.alarm_on_rounded),
                      ),
                      readOnly: true,
                      onSaved: (newValue) {
                        medicacao.value.quando =
                            prepareDate(newValue) ?? medicacao.value.quando;
                      },
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (date != null) {
                          medicacao.value.quando = date.toIso8601String();
                          dataController.text = DateFormat().format(date);
                        }
                      }),
                ],
              ),
            )));
  }

  List<DropdownMenuItem<String>> petsDropdown(Map<String, Pet> pets) {
    return pets.values
        .map((v) => DropdownMenuItem(
              value: v.id,
              child: v.imagem != null
                  ? Row(children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(v.fotoPerfilUrl.toString()),
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

  TextEditingController makeController(prop) {
    return useTextEditingController(
        text: prop != null
            ? DateFormat().format(DateTime.tryParse(prop as String)!)
            : null);
  }

  String? prepareDate(newValue) {
    if (newValue == null || newValue.isEmpty) {
      return null;
    }

    DateTime? date = DateTime.tryParse(newValue);
    if (date == null) {
      return null;
    }

    return date.toIso8601String();
  }
}
