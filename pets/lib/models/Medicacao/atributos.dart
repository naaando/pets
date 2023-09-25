import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:pets/models/Medicacao/repetidor.dart';

part 'atributos.freezed.dart';
part 'atributos.g.dart';

@freezed
class Atributos with _$Atributos {
  @JsonSerializable(explicitToJson: true)
  const Atributos._();

  const factory Atributos({
    String? fabricante,
    String? veterinario,
    String? quando,
    @Default(Repetidor()) Repetidor repetidor,
  }) = _Atributos;

  factory Atributos.fromJson(Map<String, dynamic> json) =>
      _$AtributosFromJson(json);
}
