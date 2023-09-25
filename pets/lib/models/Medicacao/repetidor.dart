import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'repetidor.freezed.dart';
part 'repetidor.g.dart';

@freezed
class Repetidor with _$Repetidor {
  @JsonSerializable(explicitToJson: true)
  const Repetidor._();

  const factory Repetidor({
    String? intervaloValor,
    String? intervaloTipo,
    String? duranteValor,
    String? duranteTipo,
  }) = _Repetidor;

  factory Repetidor.fromJson(Map<String, dynamic> json) =>
      _$RepetidorFromJson(json);
}
