import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:pets/models/espaco.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/http_client.dart';

class PetRepository extends ChangeNotifier {
  Map<String, Pet> pets = <String, Pet>{};
  final HttpClient httpClient;

  PetRepository(this.httpClient);

  Future<Pet?> find(String id, {bool forceRefresh = false}) async {
    if (pets[id] != null && !forceRefresh) {
      return pets[id];
    }

    var jsonPet = await httpClient.getJson('api/pets/$id');
    var pet = Pet.fromJson(jsonPet);
    pets[pet.id!] = pet;

    notifyListeners();

    return pets[id];
  }

  Future<Map<String, Pet>> findAll(
      {String? espacoId, bool forceRefresh = false}) async {
    if (pets.isNotEmpty && !forceRefresh) {
      return Future.value(pets);
    }

    var jsonPets = await httpClient.getJson('api/pets?espaco_id=$espacoId');

    // ignore: prefer_for_elements_to_map_fromiterable
    pets = Map<String, Pet>.fromIterable(jsonPets,
        key: (json) => json['id'], value: (json) => Pet.fromJson(json));

    notifyListeners();

    return pets;
  }

  Future save(Pet pet) async {
    Pet? savedPet;

    if (pet.id == null) {
      savedPet = await _create(pet);
    } else {
      savedPet = await _update(pet);
    }

    pets[savedPet.id!] = savedPet;

    notifyListeners();
  }

  remove(Pet pet) async {
    await httpClient.delete('api/pets/${pet.id}');

    pets.remove(pet.id);

    notifyListeners();
  }

  Future<Pet> _create(Pet pet) async {
    var jsonPet = await httpClient.postJson('api/pets', pet.toMap());
    return Pet.fromJson(jsonPet);
  }

  Future<Pet> _update(Pet pet) async {
    var petJson = await httpClient.patchJson('api/pets/${pet.id}', pet.toMap());
    return Pet.fromJson(petJson);
  }

  Future<String?> updateProfilePicture(Pet pet, XFile file) async {
    String folder = 'e242255d-91af-4886-961e-ab50d0cae3fa';

    Dio dio = httpClient.httpClient;

    var response = await dio.post('files',
        data: FormData.fromMap({
          'folder': folder,
          'file': MultipartFile.fromBytes(
            await file.readAsBytes(),
            filename: file.name,
            contentType: MediaType.parse(lookupMimeType(file.name)!),
          ),
        }));

    pet.fotoPerfil = response.data['data']['id'];
    return response.data['data']['id'];
  }
}
