import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';

class PetPage extends ConsumerWidget {
  static const String routeName = '/pet';

  const PetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pet = ModalRoute.of(context)!.settings.arguments as Pet;
    var title = pet.nome;

    return Scaffold(
      // appBar: PetsAppBar(
      //   title: title,
      // ),
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => showDeleteAlert(context, ref, pet))
        ],
      ),
      body: body(context, ref, title, pet),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FormState form = Form.of(context);

          if (form.validate()) {
            form.save();
          }
        },
        tooltip: 'Salvar',
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget body(BuildContext context, WidgetRef ref, String title, Pet pet) {
    return SingleChildScrollView(
        child: Form(
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
          ),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: pet.especie,
            decoration: const InputDecoration(
              hintText: 'Espécie do animal',
              labelText: 'Espécie',
            ),
            readOnly: true,
          ),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: pet.raca,
            decoration: const InputDecoration(
              hintText: 'Raça do animal',
              labelText: 'Raça',
            ),
          ),
        ],
      ),
    )));
  }

  Widget petImage(context, WidgetRef ref, Pet pet) {
    Widget thumbWidget;
    // ref.read(petRepositoryProvider);

    if (pet.fotoPerfil != null) {
      thumbWidget = Image.network(
        pet.fotoPerfilUrl.toString(),
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
            // ref.read(petProvider(pet.id)).updateFotoPerfil(image.path);
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
            ref.read(petRepositoryProvider).delete(pet);
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
}
