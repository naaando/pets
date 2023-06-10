import 'package:flutter/material.dart';
import 'package:pets/http_client.dart';
import 'package:pets/models/espaco.dart';

class EspacoRepository extends ChangeNotifier {
  Map<String, Espaco> data = <String, Espaco>{};

  final HttpClient httpClient;

  EspacoRepository(this.httpClient);

  Future<Espaco?> find(String id, {bool forceRefresh = false}) async {
    if (data[id] != null && !forceRefresh) {
      return data[id];
    }

    var decodedJson = await httpClient.getJson('items/espaco/$id');

    var pet = Espaco.fromJson(decodedJson);
    data[pet.id] = pet;

    notifyListeners();

    return data[id];
  }

  Future<Map<String, Espaco>> findAll({bool forceRefresh = false}) async {
    if (data.isNotEmpty && !forceRefresh) {
      return Future.value(data);
    }

    var decodedJson = await httpClient.getJson('items/espaco');

    // ignore: prefer_for_elements_to_map_fromiterable
    data = Map<String, Espaco>.fromIterable(decodedJson,
        key: (json) => json['id'], value: (json) => Espaco.fromJson(json));

    notifyListeners();

    return data;
  }
}
