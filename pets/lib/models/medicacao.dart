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

  @JsonKey(name: 'inicial_id')
  int? inicialId;

  @JsonKey(name: 'antecessora_id')
  int? antecessoraId;

  String nome;
  String? fabricante;
  String? veterinario;
  String? quando;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  bool completado;

  Medicacao({
    this.id,
    this.inicialId,
    this.antecessoraId,
    this.tipo = 'medicacao',
    this.petId,
    this.nome = '',
    this.fabricante,
    this.veterinario,
    this.quando,
    this.createdAt,
    this.updatedAt,
    this.completado = false,
  });

  factory Medicacao.fromJson(Map<String, dynamic> json) =>
      _$MedicacaoFromJson(json);
  Map<String, dynamic> toJson() => _$MedicacaoToJson(this);

  factory Medicacao.proximaDose(Medicacao medicacao, String proximaDose) {
    return Medicacao(
      tipo: medicacao.tipo,
      inicialId: medicacao.inicialId ?? medicacao.id,
      antecessoraId: medicacao.id,
      petId: medicacao.petId,
      nome: medicacao.nome,
      fabricante: medicacao.fabricante,
      veterinario: medicacao.veterinario,
      quando: proximaDose,
      createdAt: medicacao.createdAt,
      updatedAt: medicacao.updatedAt,
      completado: false,
    );
  }

  bool deveCompletar() {
    if (quando == null) {
      return false;
    }

    var dateTime = DateTime.tryParse(quando!)?.toLocal();

    if (dateTime is DateTime) {
      completado = dateTime.isBefore(DateTime.now());
    }

    return completado;
  }
}
