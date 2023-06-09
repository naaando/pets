import 'package:flutter/material.dart';
import 'package:pets/http_client.dart';
import 'package:pets/models/remedio.dart';
import 'package:pets/repository/pet_repository.dart';
import 'package:pets/repository/tipo_remedio_repository.dart';

class RemedioRepository extends ChangeNotifier {
  Map<String, Remedio> medicines = <String, Remedio>{};

  final HttpClient httpClient;
  final PetRepository petRepository;
  final TipoRemedioRepository tipoRemedioRepository;

  RemedioRepository(
      this.httpClient, this.petRepository, this.tipoRemedioRepository);

  Future<Map<String, Remedio>> findAll({bool forceRefresh = false}) async {
    if (medicines.isNotEmpty && !forceRefresh) {
      return Future.value(medicines);
    }

    var animais = await petRepository.findAll();
    var tiposRemedio = await tipoRemedioRepository.findAll();

    var decodedJson = await httpClient
        .getJson('items/remedios', queryParameters: {'sort': '-administrado'});

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
