import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/models/especie.dart';
import 'package:pets/provider/form_state_provider.dart';
import 'package:pets/provider/pet_provider.dart';
import 'package:pets/provider/especie_provider.dart';
import 'package:intl/intl.dart';
import 'package:pets/provider/user_provider.dart';

class PetPage extends HookConsumerWidget {
  static const String routeName = '/pet';

  const PetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider).asData!.value!;

    Pet pet = (ModalRoute.of(context)!.settings.arguments as Pet?) ??
        Pet(
          espacoId: user.espacoAtivoId,
        );

    var title = pet.nome.isNotEmpty ? pet.nome : 'Novo animal';
    var formKey = ref.watch(petFormStateProvider);

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: barActions(context, ref, pet, formKey),
          ),
          body: body(context, ref, formKey, title, pet),
          floatingActionButton: saveButton(context, ref, formKey, pet),
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
          icon: const Icon(Icons.cancel),
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

    Map<String, Especie> especie =
        ref.watch(especiesProvider).asData?.value ?? <String, Especie>{};

    final nascimentoController = makeController(pet.nascimento);
    final castracaoController = makeController(pet.castracao);
    final obitoController = makeController(pet.obito);

    return SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  petImage(
                    context,
                    ref,
                    pet,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: pet.nome,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.pets),
                      hintText: 'Nome do animal',
                      labelText: 'Nome',
                    ),
                    onSaved: (newValue) => pet.nome = newValue!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: pet.especieId,
                    decoration: const InputDecoration(
                      hintText: 'Espécie do animal',
                      labelText: 'Espécie',
                    ),
                    items: especie.entries
                        .map((v) => DropdownMenuItem(
                              value: v.value.id,
                              child: Text(v.value.nome),
                            ))
                        .toList(),
                    onChanged: (value) => pet.especieId = value,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: pet.raca,
                    decoration: const InputDecoration(
                      hintText: 'Raça do animal',
                      labelText: 'Raça',
                    ),
                    onSaved: (newValue) => pet.raca = newValue!,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: pet.sexo,
                    decoration: const InputDecoration(
                      hintText: 'Sexo',
                      labelText: 'Sexo',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'macho',
                        child: Text('Masculino'),
                      ),
                      DropdownMenuItem(
                        value: 'femea',
                        child: Text('Feminino'),
                      ),
                    ],
                    onChanged: (value) => pet.sexo = value,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: nascimentoController,
                      decoration: const InputDecoration(
                        hintText: 'Data de nascimento',
                        labelText: 'Data de nascimento',
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
                          nascimentoController.text = DateFormat().format(date);
                        }
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: castracaoController,
                      decoration: const InputDecoration(
                        hintText: 'Data de castração (aproximada)',
                        labelText: 'Data de castração (aproximada)',
                      ),
                      readOnly: true,
                      onSaved: (newValue) {
                        pet.castracao = prepareDate(newValue) ?? pet.castracao;
                      },
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (date != null) {
                          pet.castracao = date.toIso8601String();
                          castracaoController.text = DateFormat().format(date);
                        }
                      }),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: pet.mae,
                    decoration: const InputDecoration(
                      hintText: 'Mãe',
                      labelText: 'Mãe',
                    ),
                    items: femalePetsDropdown(pets),
                    onChanged: (value) => pet.mae = value,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: pet.pai,
                    decoration: const InputDecoration(
                      hintText: 'Pai',
                      labelText: 'Pai',
                    ),
                    items: malePetsDropdown(pets),
                    onChanged: (value) => pet.pai = value,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: obitoController,
                      decoration: const InputDecoration(
                        hintText: 'Data de óbito',
                        labelText: 'Data de óbito',
                      ),
                      readOnly: true,
                      onSaved: (newValue) {
                        pet.obito = prepareDate(newValue) ?? pet.obito;
                      },
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (date != null) {
                          pet.obito = date.toIso8601String();
                          obitoController.text = DateFormat().format(date);
                        }
                      }),
                ],
              ),
            )));
  }

  List<DropdownMenuItem<String>> malePetsDropdown(Map<String, Pet> pets) {
    return pets.values
        .where((animal) => animal.sexo == 'masculino')
        .map((v) => DropdownMenuItem(
              value: v.id,
              child: Text(v.nome),
            ))
        .toList()
      ..insert(
          0,
          const DropdownMenuItem(
            value: null,
            child: Text('Desconhecido'),
          ));
  }

  List<DropdownMenuItem<String>> femalePetsDropdown(Map<String, Pet> pets) {
    return pets.values
        .where((animal) => animal.sexo == 'feminino')
        .map((v) => DropdownMenuItem(
              value: v.id,
              child: Text(v.nome),
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
