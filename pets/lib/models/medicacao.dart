import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medicacao.g.dart';

@collection
@JsonSerializable()
class Medicacao {
  Id? id;
  @JsonKey(defaultValue: 'medicacao')
  String tipo;

  @JsonKey(name: 'pet_id')
  String? petId;
  String? nome;
  String? fabricante;
  String? veterinario;
  String? quando;
  @JsonKey(name: 'total_doses', defaultValue: 1)
  int totalDoses;
  @JsonKey(name: 'dose_atual', defaultValue: 1)
  int doseAtual;
  @JsonKey(name: 'proxima_dose')
  String? proximaDose;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  Medicacao({
    this.id,
    this.tipo = 'medicacao',
    this.petId,
    this.nome,
    this.fabricante,
    this.veterinario,
    this.quando,
    this.proximaDose,
    this.totalDoses = 1,
    this.doseAtual = 1,
    this.createdAt,
    this.updatedAt,
  });

  factory Medicacao.fromJson(Map<String, dynamic> json) =>
      _$MedicacaoFromJson(json);
  Map<String, dynamic> toJson() => _$MedicacaoToJson(this);

  factory Medicacao.proximaDose(Medicacao medicacao) {
    return Medicacao(
      id: medicacao.id,
      tipo: medicacao.tipo,
      petId: medicacao.petId,
      nome: medicacao.nome,
      fabricante: medicacao.fabricante,
      veterinario: medicacao.veterinario,
      quando: medicacao.proximaDose,
      totalDoses: medicacao.totalDoses,
      doseAtual: medicacao.doseAtual + 1,
      proximaDose: null,
      createdAt: medicacao.createdAt,
      updatedAt: medicacao.updatedAt,
    );
  }
}
