import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pets/models/tipo_remedio.dart';

class TipoRemedioRepository extends ChangeNotifier {
  Map<String, TipoRemedio> medicineTypes = <String, TipoRemedio>{};

  final String token;
  final Client httpClient;

  TipoRemedioRepository(this.httpClient, this.token);

  Future<TipoRemedio?> find(String id, {bool forceRefresh = false}) async {
    if (medicineTypes[id] != null && !forceRefresh) {
      return medicineTypes[id];
    }

    var res = await httpClient.get(
        Uri.http('10.0.2.2:8055', 'items/tipo_remedio/$id'),
        headers: {'Authorization': 'Bearer $token'});

    var decodedJson = jsonDecode(res.body)['data'] as dynamic;

    var medicineType = TipoRemedio.fromJson(decodedJson);
    medicineTypes[medicineType.id!] = medicineType;

    notifyListeners();

    return medicineTypes[id];
  }

  Future<Map<String, TipoRemedio>> findAll({bool forceRefresh = false}) async {
    if (medicineTypes.isNotEmpty && !forceRefresh) {
      return Future.value(medicineTypes);
    }

    var res = await httpClient.get(
        Uri.http('10.0.2.2:8055', 'items/tipo_remedio'),
        headers: {'Authorization': 'Bearer $token'});

    var decodedJson = jsonDecode(res.body)['data'] as List<dynamic>;

    // ignore: prefer_for_elements_to_map_fromiterable
    medicineTypes = Map<String, TipoRemedio>.fromIterable(decodedJson,
        key: (json) => json['id'], value: (json) => TipoRemedio.fromJson(json));

    notifyListeners();

    return medicineTypes;
  }
}
