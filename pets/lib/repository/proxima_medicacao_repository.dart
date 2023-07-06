import 'package:pets/http_client.dart';
import 'package:pets/models/medicacao.dart';

class ProximaMedicacaoRepository {
  final HttpClient httpClient;

  ProximaMedicacaoRepository(this.httpClient);

  Future<Medicacao?> find(String id, {bool forceRefresh = false}) async {
    var jsonMedicacao = await httpClient.getJson('api/proximas-medicacoes/$id');
    return Medicacao.fromJson(jsonMedicacao);
  }

  Future<Map<String, Medicacao>> findAll({bool forceRefresh = false}) async {
    var jsonMedicacaos = await httpClient.getJson('api/proximas-medicacoes');

    // ignore: prefer_for_elements_to_map_fromiterable
    return Map<String, Medicacao>.fromIterable(jsonMedicacaos,
        key: (json) => json['id'].toString(),
        value: (json) => Medicacao.fromJson(json));
  }

  Future save(Medicacao medicacao) async {
    Medicacao? savedMedicacao;

    if (medicacao.id == null) {
      savedMedicacao = await _create(medicacao);
    } else {
      savedMedicacao = await _update(medicacao);
    }

    return savedMedicacao;
  }

  remove(Medicacao medicacao) async {
    await httpClient.delete('api/proximas-medicacoes/${medicacao.id}');
  }

  Future<Medicacao> _create(Medicacao medicacao) async {
    var jsonMedicacao = await httpClient.postJson(
        'api/proximas-medicacoes', medicacao.toJson());
    return Medicacao.fromJson(jsonMedicacao);
  }

  Future<Medicacao> _update(Medicacao medicacao) async {
    var petJson = await httpClient.patchJson(
        'api/proximas-medicacoes/${medicacao.id}', medicacao.toJson());
    return Medicacao.fromJson(petJson);
  }
}
