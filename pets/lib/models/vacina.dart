import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pets/fasthash.dart';

part 'vacina.g.dart';

@collection
@JsonSerializable()
class Vacina {
  String? id;
  Id? get isarId => id != null ? fastHash(id!) : null;

  @JsonKey(name: 'pet_id')
  String? petId;
  String? nome;
  String? fabricante;
  String? veterinario;
  String? data;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  Vacina({
    this.id,
    this.petId,
    this.nome,
    this.fabricante,
    this.veterinario,
    this.data,
    this.createdAt,
    this.updatedAt,
  });

  factory Vacina.fromJson(Map<String, dynamic> json) => _$VacinaFromJson(json);
  Map<String, dynamic> toJson() => _$VacinaToJson(this);
}
