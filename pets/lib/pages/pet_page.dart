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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PetPage extends HookConsumerWidget {
  const PetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final user = ref.watch(loggedUserProvider).asData!.value!;

    final petFromRoute = (ModalRoute.of(context)!.settings.arguments as Pet?) ??
        Pet(
          espacoId: user.espacoAtivoId,
        );

    final pet = useState(petFromRoute);

    final title = pet.value.id != null ? pet.value.nome : t!.petsNewPet;
    final formKey = ref.watch(petFormStateProvider);
    final petImgFile = useState<XFile?>(null);

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions:
              barActions(context, ref, pet.value, formKey, petImgFile.value),
        ),
        body: body(context, ref, formKey, title, pet, petImgFile),
        floatingActionButton: formKey.currentState?.validate() == true
            ? FloatingActionButton(
                onPressed: () => save(
                  context,
                  ref,
                  formKey,
                  pet.value,
                  petImgFile.value,
                ),
                tooltip: t!.sharedSave,
                child: const Icon(Icons.check),
              )
            : null,
      ),
      onWillPop: () async {
        if (petFromRoute == pet.value) {
          return true;
        }

        return await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(t!.sharedExitWithoutSaving),
            content: Text(
              t.sharedExitWithoutSavingMessage,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pop(true); // dismisses only the dialog and returns false
                },
                child: Text(
                  t.sharedExitWithoutSavingConfirm,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pop(false); // dismisses only the dialog and returns true
                },
                child: Text(t.sharedExitWithoutSavingAbort),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> barActions(
    BuildContext context,
    WidgetRef ref,
    Pet pet,
    GlobalKey<FormState> formKey,
    XFile? petImgFile,
  ) {
    if (pet.id != null) {
      return [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => showDeleteAlert(
            context,
            ref,
            pet,
          ),
        ),
      ];
    }

    return [
      IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ];
  }

  Widget body(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormState> formKey,
    String title,
    ValueNotifier<Pet> pet,
    ValueNotifier<XFile?> petImgFile,
  ) {
    final t = AppLocalizations.of(context);

    // Dont watch pets cause it will cause a rebuild
    Map<String, Pet> pets =
        ref.read(petsProvider).asData?.value ?? <String, Pet>{};

    Map<String, Especie> especie =
        ref.watch(especiesProvider).asData?.value ?? <String, Especie>{};

    return SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(12),
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
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.pets),
                      hintText: t!.petsAnimalName,
                      labelText: t.petsName,
                    ),
                    onChanged: (newValue) {
                      pet.value = pet.value.copyWith(nome: newValue);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return t.petsNameRequired;
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: pet.value.especieId,
                    decoration: InputDecoration(
                      hintText: t.petsAnimalType,
                      labelText: t.petsType,
                    ),
                    items: especie.entries
                        .map((v) => DropdownMenuItem(
                              value: v.value.id,
                              child: Text(v.value.nome),
                            ))
                        .toList(),
                    onChanged: (value) {
                      pet.value = pet.value.copyWith(especieId: value);
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: pet.value.raca,
                    decoration: InputDecoration(
                      hintText: t.petsAnimalBreed,
                      labelText: t.petsBreed,
                    ),
                    onChanged: (newValue) {
                      pet.value = pet.value.copyWith(raca: newValue);
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: pet.value.sexo,
                    decoration: InputDecoration(
                      hintText: t.petsGender,
                      labelText: t.petsGender,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'macho',
                        child: Text(t.sharedMale),
                      ),
                      DropdownMenuItem(
                        value: 'femea',
                        child: Text(t.sharedFemale),
                      ),
                    ],
                    onChanged: (value) {
                      pet.value = pet.value.copyWith(sexo: value);
                    },
                  ),
                  const SizedBox(height: 20),
                  DateTimeFormField(
                    initialValue: pet.value.nascimento,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    decoration: InputDecoration(
                      hintText: t.petsBirthDate,
                      labelText: t.petsBirthDate,
                    ),
                    onDateChanged: (dateTime) {
                      pet.value = pet.value.copyWith(
                        nascimento: dateTime?.toIso8601String(),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  DateTimeFormField(
                    initialValue: pet.value.castracao,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    decoration: InputDecoration(
                      hintText: t.petsCastrationDate,
                      labelText: t.petsCastrationDate,
                    ),
                    onDateChanged: (dateTime) {
                      pet.value = pet.value.copyWith(
                        castracao: dateTime?.toIso8601String(),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: pet.value.maeId,
                    decoration: InputDecoration(
                      hintText: t.petsMother,
                      labelText: t.petsMother,
                    ),
                    items: femalePetsDropdown(context, pets),
                    onChanged: (value) {
                      pet.value = pet.value.copyWith(maeId: value);
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                      value: pet.value.paiId,
                      decoration: InputDecoration(
                        hintText: t.petsFather,
                        labelText: t.petsFather,
                      ),
                      items: malePetsDropdown(context, pets),
                      onChanged: (value) {
                        pet.value = pet.value.copyWith(paiId: value);
                      }),
                  const SizedBox(height: 20),
                  DateTimeFormField(
                    initialValue: pet.value.falecimento,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    decoration: InputDecoration(
                      hintText: t.petsDeathDate,
                      labelText: t.petsDeathDate,
                    ),
                    onDateChanged: (dateTime) {
                      pet.value = pet.value.copyWith(
                        falecimento: dateTime?.toIso8601String(),
                      );
                    },
                  ),
                ],
              ),
            )));
  }

  List<DropdownMenuItem<String>> malePetsDropdown(
      BuildContext context, Map<String, Pet> pets) {
    final t = AppLocalizations.of(context);

    return pets.values
        .where((animal) => animal.sexo == 'macho')
        .map((pet) => DropdownMenuItem(
              value: pet.id,
              child: PetDropdownMenuItemChild(pet),
            ))
        .toList()
      ..insert(
          0,
          DropdownMenuItem(
            value: null,
            child: Text(t!.sharedUnknown),
          ));
  }

  List<DropdownMenuItem<String>> femalePetsDropdown(
      BuildContext context, Map<String, Pet> pets) {
    final t = AppLocalizations.of(context);

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
        DropdownMenuItem(
          value: null,
          child: Text(t!.sharedUnknown),
        ),
      );
  }

  Widget petImage(
    BuildContext context,
    WidgetRef ref,
    Pet pet,
    ValueNotifier<XFile?> petImgFile,
  ) {
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

  showDeleteAlert(
    BuildContext context,
    WidgetRef ref,
    Pet pet,
  ) {
    final t = AppLocalizations.of(context);

    AlertDialog alert = AlertDialog(
      title: Text(t!.petsConfirmDelete),
      content: Text(t.petsConfirmDeleteContent(pet.nome)),
      actions: [
        TextButton(
          child: Text(t.sharedCancel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(t.sharedExclude),
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

  void save(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormState> formKey,
    Pet pet,
    XFile? petImgFile,
  ) {
    final t = AppLocalizations.of(context);

    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) {
      return;
    }

    ref.read(petsProvider.notifier).save(pet, petImgFile).then((savedPet) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t!.sharedSaved)),
      );

      Navigator.of(context).pop();
    }).onError((DioException error, stackTrace) {
      debugPrint(error.toString());
      var msg = error.response?.data['message'] ?? error.message;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t!.sharedErrorWhileSaving(msg))),
      );
    });
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
