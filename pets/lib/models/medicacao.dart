import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:flutter/foundation.dart';

import 'pet.dart';

part 'medicacao.freezed.dart';
part 'medicacao.g.dart';

@freezed
class Medicacao with _$Medicacao {
  @JsonSerializable(explicitToJson: true)
  const Medicacao._();

  const factory Medicacao({
    Id? id,
    @Default('medicacao') String tipo,
    @JsonKey(name: 'pet_id') String? petId,
    Pet? pet,
    @JsonKey(name: 'inicial_id') int? inicialId,
    @JsonKey(name: 'antecessora_id') int? antecessoraId,
    @Default('') String nome,
    String? fabricante,
    String? veterinario,
    String? quando,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @Default(false) bool completado,
  }) = _Medicacao;

  factory Medicacao.proximaDose(Medicacao medicacao, String proximaDose) =>
      Medicacao(
        tipo: medicacao.tipo,
        // inicialId: medicacao.inicialId ?? medicacao.id,
        // antecessoraId: medicacao.id,
        petId: medicacao.petId,
        nome: medicacao.nome,
        fabricante: medicacao.fabricante,
        veterinario: medicacao.veterinario,
        quando: proximaDose,
        createdAt: medicacao.createdAt,
        updatedAt: medicacao.updatedAt,
        completado: false,
      );

  // @ignore
  get tipoExtenso {
    switch (tipo) {
      case 'medicacao':
        return 'Medicação';
      case 'vacina':
        return 'Vacina';
      case 'vermifugo':
        return 'Vermífugo';
      default:
        return 'Medicação';
    }
  }

  /// Verifica se a medicação deve ser completada
  /// a partir da data de quando ela deveria ser tomada
  /// e retorna um booleano
  bool deveCompletar() {
    if (quando == null) {
      return false;
    }

    final dateTime = DateTime.tryParse(quando!)?.toLocal();

    if (dateTime == null) {
      return false;
    }

    return dateTime.isBefore(DateTime.now());
  }

  factory Medicacao.fromJson(Map<String, dynamic> json) =>
      _$MedicacaoFromJson(json);
}
