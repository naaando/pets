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

  String? especieId;

  Especie? especie;
  String? imagem;
  String? mae;
  String? nascimento;
  String? castracao;
  String? pai;
  String? raca;
  String? sexo;
  String? userCreated;
  String? userUpdated;
  String? espacoId;
  String? obito;

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
    this.mae,
    this.pai,
    this.sexo,
    this.raca,
    required this.espacoId,
    this.obito,
    this.userCreated,
    this.userUpdated,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);
  Map<String, dynamic> toJson() => _$PetToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'castrado': castrado,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'especie_id': especieId,
      'imagem': imagem,
      'mae': mae,
      'nascimento': nascimento,
      'castracao': castracao,
      'obito': obito,
      'pai': pai,
      'raca': raca,
      'sexo': sexo,
      'espaco_id': espacoId,
      'user_created': userCreated,
      'user_updated': userUpdated,
    }..removeWhere(
        (key, value) => value == null || (value is String && value.isEmpty));
  }
}
