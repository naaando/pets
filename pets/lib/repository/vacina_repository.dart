import 'package:pets/http_client.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/models/vacina.dart';

class VacinaRepository {
  final HttpClient httpClient;

  VacinaRepository(this.httpClient);

  Future<Vacina?> find(String id, {bool forceRefresh = false}) async {
    var jsonVacina = await httpClient.getJson('api/vacinas/$id');
    return Vacina.fromJson(jsonVacina);
  }

  Future<Map<String, Vacina>> findAll(
      {String? petId, bool forceRefresh = false}) async {
    var jsonVacinas = await httpClient.getJson('api/vacinas?pet_id=$petId');

    // ignore: prefer_for_elements_to_map_fromiterable
    return Map<String, Vacina>.fromIterable(jsonVacinas,
        key: (json) => json['id'].toString(),
        value: (json) => Vacina.fromJson(json));
  }

  Future save(Vacina vacina) async {
    Vacina? savedVacina;

    if (vacina.id == null) {
      savedVacina = await _create(vacina);
    } else {
      savedVacina = await _update(vacina);
    }

    return savedVacina;
  }

  remove(Vacina vacina) async {
    await httpClient.delete('api/vacinas/${vacina.id}');
  }

  Future<Vacina> _create(Vacina vacina) async {
    var jsonVacina = await httpClient.postJson('api/vacinas', vacina.toJson());
    return Vacina.fromJson(jsonVacina);
  }

  Future<Vacina> _update(Vacina vacina) async {
    var petJson =
        await httpClient.patchJson('api/vacinas/${vacina.id}', vacina.toJson());
    return Vacina.fromJson(petJson);
  }
}
