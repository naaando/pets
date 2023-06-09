import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pets/models/remedio.dart';
import 'package:pets/repository/pet_repository.dart';
import 'package:pets/repository/tipo_remedio_repository.dart';

class RemedioRepository extends ChangeNotifier {
  Map<String, Remedio> medicines = <String, Remedio>{};

  final String token;
  final Client httpClient;
  final PetRepository petRepository;
  final TipoRemedioRepository tipoRemedioRepository;

  RemedioRepository(this.httpClient, this.token, this.petRepository,
      this.tipoRemedioRepository);

  Future<Map<String, Remedio>> findAll({bool forceRefresh = false}) async {
    if (medicines.isNotEmpty && !forceRefresh) {
      return Future.value(medicines);
    }

    var animais = await petRepository.findAll();
    var tiposRemedio = await tipoRemedioRepository.findAll();

    var res = await httpClient.get(
        Uri.http('10.0.2.2:8055', 'items/remedios', {'sort': '-administrado'}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });

    print(res.body);
    var decodedJson = jsonDecode(res.body)['data'] as List<dynamic>;

    // ignore: prefer_for_elements_to_map_fromiterable
    medicines = Map<String, Remedio>.fromIterable(decodedJson,
        key: (json) => json['id'],
        value: (json) {
          return Remedio.fromJson(json,
              animal: animais[json['animal']]!,
              tipoRemedio: tiposRemedio[json['tipo_remedio']]!);
        });

    notifyListeners();

    return medicines;
  }
}
