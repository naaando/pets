import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pets/models/specie.dart';

class SpecieRepository extends ChangeNotifier {
  Map<String, Specie> pets = <String, Specie>{};

  final String token;
  final Client httpClient;

  SpecieRepository(this.httpClient, this.token);

  Future<Specie?> find(String id, {bool forceRefresh = false}) async {
    if (pets[id] != null && !forceRefresh) {
      return pets[id];
    }

    var res = await httpClient.get(
        Uri.http('10.0.2.2:8055', 'items/especie/$id'),
        headers: {'Authorization': 'Bearer $token'});

    var decodedJson = jsonDecode(res.body)['data'] as dynamic;

    var pet = Specie.fromJson(decodedJson);
    pets[pet.id] = pet;

    notifyListeners();

    return pets[id];
  }

  Future<Map<String, Specie>> findAll({bool forceRefresh = false}) async {
    if (pets.isNotEmpty && !forceRefresh) {
      return Future.value(pets);
    }

    var res = await httpClient.get(Uri.http('10.0.2.2:8055', 'items/especie'),
        headers: {'Authorization': 'Bearer $token'});

    var decodedJson = jsonDecode(res.body)['data'] as List<dynamic>;

    // ignore: prefer_for_elements_to_map_fromiterable
    pets = Map<String, Specie>.fromIterable(decodedJson,
        key: (json) => json['id'], value: (json) => Specie.fromJson(json));

    notifyListeners();

    return pets;
  }
}
