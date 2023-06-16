import 'package:flutter/material.dart';
import 'package:pets/http_client.dart';
import 'package:pets/models/especie.dart';

class EspecieRepository extends ChangeNotifier {
  Map<String, Especie> pets = <String, Especie>{};

  final HttpClient httpClient;

  EspecieRepository(this.httpClient);

  Future<Especie?> find(String id, {bool forceRefresh = false}) async {
    if (pets[id] != null && !forceRefresh) {
      return pets[id];
    }

    var decodedJson = await httpClient.getJson('api/especies/$id');

    var pet = Especie.fromJson(decodedJson);
    pets[pet.id] = pet;

    notifyListeners();

    return pets[id];
  }

  Future<Map<String, Especie>> findAll({bool forceRefresh = false}) async {
    if (pets.isNotEmpty && !forceRefresh) {
      return Future.value(pets);
    }

    var decodedJson = await httpClient.getJson('api/especies');

    // ignore: prefer_for_elements_to_map_fromiterable
    pets = Map<String, Especie>.fromIterable(decodedJson,
        key: (json) => json['id'], value: (json) => Especie.fromJson(json));

    notifyListeners();

    return pets;
  }
}
