import 'package:flutter/material.dart';
import 'package:pets/http_client.dart';
import 'package:pets/models/specie.dart';

class SpecieRepository extends ChangeNotifier {
  Map<String, Specie> pets = <String, Specie>{};

  final HttpClient httpClient;

  SpecieRepository(this.httpClient);

  Future<Specie?> find(String id, {bool forceRefresh = false}) async {
    if (pets[id] != null && !forceRefresh) {
      return pets[id];
    }

    var decodedJson = await httpClient.getJson('items/especie/$id');

    var pet = Specie.fromJson(decodedJson);
    pets[pet.id] = pet;

    notifyListeners();

    return pets[id];
  }

  Future<Map<String, Specie>> findAll({bool forceRefresh = false}) async {
    if (pets.isNotEmpty && !forceRefresh) {
      return Future.value(pets);
    }

    var decodedJson = await httpClient.getJson('items/especie');

    // ignore: prefer_for_elements_to_map_fromiterable
    pets = Map<String, Specie>.fromIterable(decodedJson,
        key: (json) => json['id'], value: (json) => Specie.fromJson(json));

    notifyListeners();

    return pets;
  }
}
