import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets/components/datetime_form_field.dart';
import 'package:pets/components/pet_dropdown_menu_item_child.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/models/especie.dart';
import 'package:pets/provider/form_state_provider.dart';
import 'package:pets/provider/pet_provider.dart';
import 'package:pets/provider/especie_provider.dart';
import 'package:pets/provider/user_provider.dart';

class PetPage extends HookConsumerWidget {
  const PetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(loggedUserProvider).asData!.value!;

    var petFromRoute = (ModalRoute.of(context)!.settings.arguments as Pet?) ??
        Pet(
          espacoId: user.espacoAtivoId,
        );

    var pet = useState(petFromRoute);

    var title = pet.value.id != null ? pet.value.nome : 'Novo animal';
    var formKey = ref.watch(petFormStateProvider);
    final petImgFile = useState<XFile?>(null);

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: barActions(context, ref, pet.value, formKey),
          ),
          body: body(context, ref, formKey, title, pet, petImgFile),
          floatingActionButton:
              saveButton(context, ref, formKey, pet.value, petImgFile),
        ),
        onWillPop: () async => true);
  }

  FloatingActionButton? saveButton(BuildContext context, WidgetRef ref,
      GlobalKey<FormState> formKey, Pet pet, ValueNotifier<XFile?> petImgFile) {
    var isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return null;
    }

    return FloatingActionButton(
      onPressed: () {
        formKey.currentState!.save();
        if (formKey.currentState!.validate()) {
          ref.read(petsProvider.notifier).save(pet).then((savedPet) {
            if (petImgFile.value != null) {
              ref
                  .read(petsProvider.notifier)
                  .updateProfilePicture(savedPet, petImgFile.value!)
                  .then((value) => pet.imagem = value);
            }

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

  Widget body(BuildContext context, WidgetRef ref, GlobalKey<FormState> formKey,
      String title, ValueNotifier<Pet> pet, ValueNotifier<XFile?> petImgFile) {
    // Dont watch pets cause it will cause a rebuild
    Map<String, Pet> pets =
        ref.read(petsProvider).asData?.value ?? <String, Pet>{};

    Map<String, Especie> especie =
        ref.watch(especiesProvider).asData?.value ?? <String, Especie>{};

    final nascimentoController =
        useTextEditingController(text: pet.value.nascimento);
    final castracaoController =
        useTextEditingController(text: pet.value.castracao);
    final falecimentoController =
        useTextEditingController(text: pet.value.falecimento);

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
                    pet.value,
                    petImgFile,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: pet.value.nome,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.pets),
                      hintText: 'Nome do animal',
                      labelText: 'Nome',
                    ),
                    onSaved: (newValue) => pet.value.nome = newValue!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome é obrigatório';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: pet.value.especieId,
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
                    onChanged: (value) => pet.value.especieId = value,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: pet.value.raca,
                    decoration: const InputDecoration(
                      hintText: 'Raça do animal',
                      labelText: 'Raça',
                    ),
                    onSaved: (newValue) => pet.value.raca = newValue!,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: pet.value.sexo,
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
                    onChanged: (value) => pet.value.sexo = value,
                  ),
                  const SizedBox(height: 20),
                  DateTimeFormField(
                    controller: nascimentoController,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    decoration: const InputDecoration(
                      hintText: 'Data de nascimento',
                      labelText: 'Data de nascimento',
                    ),
                    onDateChanged: (dateTime) {
                      pet.value.nascimento = dateTime?.toIso8601String();
                      pet.notifyListeners();
                    },
                  ),
                  const SizedBox(height: 20),
                  DateTimeFormField(
                    controller: castracaoController,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    decoration: const InputDecoration(
                      hintText: 'Data de castração (aproximada)',
                      labelText: 'Data de castração (aproximada)',
                    ),
                    onDateChanged: (dateTime) {
                      pet.value.castracao = dateTime?.toIso8601String();
                      pet.notifyListeners();
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: pet.value.maeId,
                    decoration: const InputDecoration(
                      hintText: 'Mãe',
                      labelText: 'Mãe',
                    ),
                    items: femalePetsDropdown(pets),
                    onChanged: (value) => pet.value.maeId = value,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: pet.value.paiId,
                    decoration: const InputDecoration(
                      hintText: 'Pai',
                      labelText: 'Pai',
                    ),
                    items: malePetsDropdown(pets),
                    onChanged: (value) => pet.value.paiId = value,
                  ),
                  const SizedBox(height: 20),
                  DateTimeFormField(
                    controller: falecimentoController,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    decoration: const InputDecoration(
                      hintText: 'Data de óbito',
                      labelText: 'Data de óbito',
                    ),
                    onDateChanged: (dateTime) {
                      pet.value.falecimento = dateTime?.toIso8601String();
                      pet.notifyListeners();
                    },
                  ),
                ],
              ),
            )));
  }

  List<DropdownMenuItem<String>> malePetsDropdown(Map<String, Pet> pets) {
    return pets.values
        .where((animal) => animal.sexo == 'macho')
        .map((pet) => DropdownMenuItem(
              value: pet.id,
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

  List<DropdownMenuItem<String>> femalePetsDropdown(Map<String, Pet> pets) {
    return pets.values
        .where((animal) => animal.sexo == 'femea')
        .map(
          (pet) => DropdownMenuItem(
            value: pet.id,
            child: PetDropdownMenuItemChild(pet),
          ),
        )
        .toList()
      ..insert(
        0,
        const DropdownMenuItem(
          value: null,
          child: Text('Desconhecido'),
        ),
      );
  }

  Widget petImage(
      context, WidgetRef ref, Pet pet, ValueNotifier<XFile?> petImgFile) {
    Widget thumbWidget;
    if (petImgFile.value != null) {
      thumbWidget = Image.file(
        File(petImgFile.value!.path),
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      );
    } else if (pet.imagem != null) {
      thumbWidget = Image.network(
        pet.imagemUri.toString(),
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

          petImgFile.value = image;
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
