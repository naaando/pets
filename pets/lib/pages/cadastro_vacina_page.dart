import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/models/vacina.dart';
import 'package:pets/provider/pet_provider.dart';
import 'package:intl/intl.dart';
import 'package:pets/provider/user_provider.dart';
import 'package:pets/provider/vacina_provider.dart';

class CadastroVacinaPage extends HookConsumerWidget {
  const CadastroVacinaPage({super.key});

  salvar(Vacina vacina, GlobalKey<FormState> formKey, BuildContext context,
      WidgetRef ref) {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      ref.read(vacinasProvider.notifier).save(vacina).then((value) {
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

    var vacina = useRef<Vacina>(
        (ModalRoute.of(context)!.settings.arguments as Vacina?) ?? Vacina());

    var title = vacina.value.id != null ? 'Editando vacina' : 'Nova vacina';
    var formKey = useRef(GlobalKey<FormState>());

    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: barActions(context, ref, formKey.value, vacina.value),
            ),
            body: body(context, ref, formKey.value, title, vacina),
            floatingActionButton:
                saveButton(context, ref, formKey.value, vacina)),
        onWillPop: () async => true);
  }

  FloatingActionButton? saveButton(BuildContext context, WidgetRef ref,
      GlobalKey<FormState> formKey, ObjectRef<Vacina> vacina) {
    return FloatingActionButton(
      onPressed: () => salvar(vacina.value, formKey, context, ref),
      tooltip: 'Salvar',
      child: const Icon(Icons.check),
    );
  }

  List<Widget> barActions(BuildContext context, WidgetRef ref,
      GlobalKey<FormState> formKey, Vacina vacina) {
    if (vacina.id != null) {
      return [
        IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => showDeleteAlert(context, ref, vacina))
      ];
    }

    return [];
  }

  Widget body(BuildContext context, WidgetRef ref, GlobalKey<FormState> formKey,
      String title, ObjectRef<Vacina> vacina) {
    // Dont watch pets cause it will cause a rebuild
    Map<String, Pet> pets =
        ref.read(petsProvider).asData?.value ?? <String, Pet>{};

    final dataController = makeController(vacina.value.quando);

    return SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  DropdownButtonFormField(
                    value: vacina.value.petId,
                    decoration: const InputDecoration(
                      hintText: 'Animal',
                      labelText: 'Animal',
                    ),
                    items: petsDropdown(pets),
                    onChanged: (value) => vacina.value.petId = value,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: vacina.value.nome,
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
                        vacina.value.nome = newValue ?? vacina.value.nome,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: vacina.value.fabricante,
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
                    onSaved: (newValue) => vacina.value.fabricante =
                        newValue ?? vacina.value.fabricante,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: vacina.value.veterinario,
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
                    onSaved: (newValue) => vacina.value.veterinario =
                        newValue ?? vacina.value.veterinario,
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
                        vacina.value.quando =
                            prepareDate(newValue) ?? vacina.value.quando;
                      },
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (date != null) {
                          vacina.value.quando = date.toIso8601String();
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

  showDeleteAlert(BuildContext context, WidgetRef ref, Vacina vacina) {
    AlertDialog alert = AlertDialog(
      title: const Text("Excluir vacina"),
      content: Text("Você tem certeza que deseja excluir ${vacina.nome}?"),
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
            ref.read(vacinasProvider.notifier).remove(vacina);
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
