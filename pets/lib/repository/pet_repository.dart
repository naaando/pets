import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:pets/models/pet.dart';

class PetRepository extends ChangeNotifier {
  Map<String, Pet>? pets;

  final String token;
  final Client httpClient;

  PetRepository(this.httpClient, this.token);

  Future<Pet?> find(String id, {bool forceRefresh = false}) async {
    if (pets?[id] != null && !forceRefresh) {
      return pets?[id];
    }

    var res = await httpClient.get(
        Uri.http('10.0.2.2:8055', 'items/animais/$id'),
        headers: {'Authorization': 'Bearer $token'});

    var decodedJson = jsonDecode(res.body)['data'] as dynamic;

    var pet = Pet.fromJson(decodedJson);
    pets![pet.id] = pet;

    notifyListeners();
    return pets?[id];
  }

  Future<Map<String, Pet>> findAll({bool forceRefresh = false}) async {
    if (pets != null && !forceRefresh) {
      return Future.value(pets);
    }

    var res = await httpClient.get(Uri.http('10.0.2.2:8055', 'items/animais'),
        headers: {'Authorization': 'Bearer $token'});

    var decodedJson = jsonDecode(res.body)['data'] as List<dynamic>;

    // ignore: prefer_for_elements_to_map_fromiterable
    pets = Map<String, Pet>.fromIterable(decodedJson,
        key: (json) => json['id'], value: (json) => Pet.fromJson(json));

    notifyListeners();
    return pets ?? <String, Pet>{};
  }

  create(Pet pet) async {
    var res = await httpClient.post(
        Uri.http('10.0.2.2:8055', 'items/animais/${pet.id}'),
        headers: {'Authorization': 'Bearer $token'},
        body: pet.toJson());

    var decodedJson = jsonDecode(res.body)['data'] as dynamic;
    pets![pet.id] = Pet.fromJson(decodedJson);
  }

  save(Pet pet) async {
    var res = await httpClient.post(
        Uri.http('10.0.2.2:8055', 'items/animais/${pet.id}'),
        headers: {'Authorization': 'Bearer $token'},
        body: pet.toJson());

    var decodedJson = jsonDecode(res.body)['data'] as dynamic;
    pets![pet.id] = Pet.fromJson(decodedJson);
  }

  delete(Pet pet) async {
    await httpClient.delete(
        Uri.http('10.0.2.2:8055', 'items/animais/${pet.id}'),
        headers: {'Authorization': 'Bearer $token'});

    pets?.remove(pet.id);
  }
}
