import 'package:json_annotation/json_annotation.dart';

part 'especie.g.dart';

@JsonSerializable()
class Especie {
  String id;
  String nome;

  Especie({required this.id, required this.nome});

  factory Especie.fromJson(Map<String, dynamic> json) =>
      _$EspecieFromJson(json);

  Map<String, dynamic> toJson() => _$EspecieToJson(this);
}
