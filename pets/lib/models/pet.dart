import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pets/models/especie.dart';
import 'package:flutter/foundation.dart';

part 'pet.freezed.dart';
part 'pet.g.dart';

@freezed
class Pet with _$Pet {
  @JsonSerializable(explicitToJson: true)
  const Pet._();

  const factory Pet({
    String? id,
    @Default('') String nome,
    bool? castrado,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'especie_id') String? especieId,
    Especie? especie,
    String? imagem,
    @JsonKey(name: 'mae_id') String? maeId,
    String? nascimento,
    String? castracao,
    @JsonKey(name: 'pai_id') String? paiId,
    String? raca,
    String? sexo,
    String? userCreated,
    String? userUpdated,
    @JsonKey(name: 'espaco_id') required String? espacoId,
    String? falecimento,
    @JsonKey(name: 'imagem_url') String? imagemUrl,
  }) = _Pet;

  Uri? get imagemUri {
    return imagemUrl != null ? Uri.parse(imagemUrl!) : null;
  }

  factory Pet.fromJson(Map<String, Object?> json) => _$PetFromJson(json);
}
