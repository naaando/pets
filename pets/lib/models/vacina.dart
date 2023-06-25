import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vacina.g.dart';

@collection
@JsonSerializable()
class Vacina {
  Id? id;

  @JsonKey(name: 'pet_id')
  String? petId;
  String? nome;
  String? fabricante;
  String? veterinario;
  String? quando;
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
    this.quando,
    this.createdAt,
    this.updatedAt,
  });

  factory Vacina.fromJson(Map<String, dynamic> json) => _$VacinaFromJson(json);
  Map<String, dynamic> toJson() => _$VacinaToJson(this);
}
