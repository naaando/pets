import 'package:flutter/material.dart';
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

    var jsonPet = await httpClient.getJson('items/animais/$id');
    var pet = Pet.fromJson(jsonPet);
    pets[pet.id!] = pet;

    notifyListeners();

    return pets[id];
  }

  Future<Map<String, Pet>> findAll({bool forceRefresh = false}) async {
    if (pets.isNotEmpty && !forceRefresh) {
      return Future.value(pets);
    }

    var jsonPets = await httpClient.getJson('items/animais');

    // ignore: prefer_for_elements_to_map_fromiterable
    pets = Map<String, Pet>.fromIterable(jsonPets,
        key: (json) => json['id'], value: (json) => Pet.fromJson(json));

    notifyListeners();

    return pets;
  }

  save(Pet pet) async {
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
    await httpClient.delete('items/animais/${pet.id}');

    pets.remove(pet.id);

    notifyListeners();
  }

  Future<Pet> _create(Pet pet) async {
    var jsonPet = await httpClient.postJson('items/animais', pet.toMap());
    return Pet.fromJson(jsonPet);
  }

  Future<Pet> _update(Pet pet) async {
    var petJson =
        await httpClient.patchJson('items/animais/${pet.id}', pet.toMap());
    return Pet.fromJson(petJson);
  }
}
