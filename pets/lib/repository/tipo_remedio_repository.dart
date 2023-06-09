import 'package:flutter/material.dart';
import 'package:pets/http_client.dart';
import 'package:pets/models/tipo_remedio.dart';

class TipoRemedioRepository extends ChangeNotifier {
  Map<String, TipoRemedio> medicineTypes = <String, TipoRemedio>{};

  final HttpClient httpClient;

  TipoRemedioRepository(this.httpClient);

  Future<TipoRemedio?> find(String id, {bool forceRefresh = false}) async {
    if (medicineTypes[id] != null && !forceRefresh) {
      return medicineTypes[id];
    }

    var decodedJson = await httpClient.getJson('items/tipo_remedio/$id');

    var medicineType = TipoRemedio.fromJson(decodedJson);
    medicineTypes[medicineType.id!] = medicineType;

    notifyListeners();

    return medicineTypes[id];
  }

  Future<Map<String, TipoRemedio>> findAll({bool forceRefresh = false}) async {
    if (medicineTypes.isNotEmpty && !forceRefresh) {
      return Future.value(medicineTypes);
    }

    var decodedJson = await httpClient.getJson('items/tipo_remedio');

    // ignore: prefer_for_elements_to_map_fromiterable
    medicineTypes = Map<String, TipoRemedio>.fromIterable(decodedJson,
        key: (json) => json['id'], value: (json) => TipoRemedio.fromJson(json));

    notifyListeners();

    return medicineTypes;
  }
}
