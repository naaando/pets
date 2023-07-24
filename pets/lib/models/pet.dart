import 'package:json_annotation/json_annotation.dart';
import 'package:pets/models/especie.dart';

part 'pet.g.dart';

@JsonSerializable()
class Pet {
  String? id;
  String nome;
  bool? castrado;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'especie_id')
  String? especieId;

  Especie? especie;
  String? imagem;

  @JsonKey(name: 'mae_id')
  String? maeId;
  String? nascimento;
  String? castracao;

  @JsonKey(name: 'pai_id')
  String? paiId;
  String? raca;
  String? sexo;
  String? userCreated;
  String? userUpdated;

  @JsonKey(name: 'espaco_id')
  String? espacoId;
  String? falecimento;

  @JsonKey(name: 'imagem_url')
  String? imagemUrl;

  Uri? get imagemUri {
    return imagemUrl != null ? Uri.parse(imagemUrl!) : null;
  }

  Pet({
    this.id,
    this.nome = '',
    this.castrado,
    this.updatedAt,
    this.createdAt,
    this.especieId,
    this.especie,
    this.imagem,
    this.imagemUrl,
    this.nascimento,
    this.castracao,
    this.maeId,
    this.paiId,
    this.sexo,
    this.raca,
    required this.espacoId,
    this.falecimento,
    this.userCreated,
    this.userUpdated,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);

  Map<String, dynamic> toJson() => _$PetToJson(this);
}
