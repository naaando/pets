import 'package:pets/http_client.dart';
import 'package:pets/models/medicacao.dart';

class MedicacaoRepository {
  final HttpClient httpClient;

  MedicacaoRepository(this.httpClient);

  Future<Medicacao?> find(String id, {bool forceRefresh = false}) async {
    var jsonMedicacao = await httpClient.getJson('api/medicacoes/$id');
    return Medicacao.fromJson(jsonMedicacao);
  }

  Future<Map<String, Medicacao>> findAll({
    String? petId,
    bool forceRefresh = false,
  }) async {
    var jsonMedicacaos =
        await httpClient.getJson('api/medicacoes?pet_id=$petId');

    // ignore: prefer_for_elements_to_map_fromiterable
    return Map<String, Medicacao>.fromIterable(jsonMedicacaos,
        key: (json) => json['id'].toString(),
        value: (json) => Medicacao.fromJson(json));
  }

  Future<Medicacao?> save(Medicacao medicacao) async {
    Medicacao? savedMedicacao;

    if (medicacao.id == null) {
      savedMedicacao = await _create(medicacao);
    } else {
      savedMedicacao = await _update(medicacao);
    }

    return savedMedicacao;
  }

  remove(Medicacao medicacao) async {
    await httpClient.delete('api/medicacoes/${medicacao.id}');
  }

  Future<Medicacao> _create(Medicacao medicacao) async {
    var jsonMedicacao =
        await httpClient.postJson('api/medicacoes', medicacao.toJson());
    return Medicacao.fromJson(jsonMedicacao);
  }

  Future<Medicacao> _update(Medicacao medicacao) async {
    var petJson = await httpClient.patchJson(
        'api/medicacoes/${medicacao.id}', medicacao.toJson());
    return Medicacao.fromJson(petJson);
  }
}
