import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/form_state_provider.dart';
import 'package:pets/provider/pet_provider.dart';
import 'package:intl/intl.dart';
import 'package:pets/provider/user_provider.dart';

class NovaVacinaPage extends HookConsumerWidget {
  const NovaVacinaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(loggedUserProvider).asData!.value!;

    Pet pet = (ModalRoute.of(context)!.settings.arguments as Pet?) ??
        Pet(
          espacoId: user.espacoAtivoId,
        );

    var title = pet.nome.isNotEmpty ? pet.nome : 'Novo evento';
    var formKey = ref.watch(petFormStateProvider);

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: barActions(context, ref, pet, formKey),
          ),
          body: body(context, ref, formKey, title, pet),
        ),
        onWillPop: () async => true);
  }

  FloatingActionButton? saveButton(BuildContext context, WidgetRef ref,
      GlobalKey<FormState> formKey, Pet pet) {
    var isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return null;
    }

    return FloatingActionButton(
      onPressed: () {
        formKey.currentState!.save();
        if (formKey.currentState!.validate()) {
          ref.read(petsProvider.notifier).save(pet).then((value) {
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

  List<Widget> barActions(BuildContext context, WidgetRef ref, Pet pet,
      GlobalKey<FormState> formKey) {
    if (pet.id != null) {
      return [
        IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => showDeleteAlert(context, ref, pet))
      ];
    }

    return [
      IconButton(
          icon: const Icon(Icons.check),
          onPressed: () => Navigator.of(context).pop())
    ];
  }

  TextEditingController makeController(prop) {
    return useTextEditingController(
        text: prop != null
            ? DateFormat().format(DateTime.tryParse(prop as String)!)
            : null);
  }

  Widget body(BuildContext context, WidgetRef ref, GlobalKey<FormState> formKey,
      String title, Pet pet) {
    // Dont watch pets cause it will cause a rebuild
    Map<String, Pet> pets =
        ref.read(petsProvider).asData?.value ?? <String, Pet>{};

    final administradoEmController = makeController(pet.nascimento);
    final agendadoParaController = makeController(pet.nascimento);

    return SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  DropdownButtonFormField(
                    value: pet.mae,
                    decoration: const InputDecoration(
                      hintText: 'Animal',
                      labelText: 'Animal',
                    ),
                    items: petsDropdown(pets),
                    onChanged: (value) => pet.mae = value,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: '',
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
                    onSaved: (newValue) => pet.nome = newValue ?? pet.nome,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      initialValue: '1',
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        hintText: 'Dose',
                        labelText: 'Dose',
                        suffixIcon: Icon(Icons.vaccines),
                      ),
                      onSaved: (newValue) => {}
                      // pet.observacoes = newValue ?? pet.observacoes,
                      ),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: agendadoParaController,
                      decoration: const InputDecoration(
                        hintText: 'Agendado para',
                        labelText: 'Agendado para',
                        suffixIcon: Icon(Icons.alarm_on_rounded),
                      ),
                      readOnly: true,
                      onSaved: (newValue) {
                        pet.nascimento =
                            prepareDate(newValue) ?? pet.nascimento;
                      },
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (date != null) {
                          pet.nascimento = date.toIso8601String();
                          administradoEmController.text =
                              DateFormat().format(date);
                        }
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: administradoEmController,
                      decoration: const InputDecoration(
                        hintText: 'Administrado em',
                        labelText: 'Administrado em',
                        suffixIcon: Icon(Icons.alarm_on_rounded),
                      ),
                      readOnly: true,
                      onSaved: (newValue) {
                        pet.nascimento =
                            prepareDate(newValue) ?? pet.nascimento;
                      },
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (date != null) {
                          pet.nascimento = date.toIso8601String();
                          administradoEmController.text =
                              DateFormat().format(date);
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

  Widget petImage(context, WidgetRef ref, Pet pet) {
    Widget thumbWidget;
    final fotoPerfilUrl = useState(pet.fotoPerfilUrl.toString());

    if (pet.imagem != null) {
      thumbWidget = Image.network(
        fotoPerfilUrl.value,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      );
    } else {
      thumbWidget = Container(
          color: Colors.grey[300],
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Icon(
            Icons.upload_rounded,
            color: Colors.grey[400],
            size: MediaQuery.of(context).size.width / 6,
          ));
    }

    return InkWell(
        child: SizedBox.square(
          dimension: MediaQuery.of(context).size.width * 0.5,
          child: ClipOval(child: thumbWidget),
        ),
        onTap: () async {
          var image =
              await ImagePicker().pickImage(source: ImageSource.gallery);

          if (image != null) {
            var newId = await ref
                .read(petsProvider.notifier)
                .updateProfilePicture(pet, image);

            pet.imagem = newId;
            fotoPerfilUrl.value = pet.fotoPerfilUrl.toString();
          }
        });
  }

  showDeleteAlert(BuildContext context, WidgetRef ref, Pet pet) {
    AlertDialog alert = AlertDialog(
      title: const Text("Excluir animal"),
      content: Text("Você tem certeza que deseja excluir ${pet.nome}?"),
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
            ref.read(petsProvider.notifier).remove(pet);
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
