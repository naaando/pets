// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atributos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Atributos _$$_AtributosFromJson(Map<String, dynamic> json) => _$_Atributos(
      fabricante: json['fabricante'] as String?,
      veterinario: json['veterinario'] as String?,
      quando: json['quando'] as String?,
      repetidor: json['repetidor'] == null
          ? const Repetidor()
          : Repetidor.fromJson(json['repetidor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AtributosToJson(_$_Atributos instance) =>
    <String, dynamic>{
      'fabricante': instance.fabricante,
      'veterinario': instance.veterinario,
      'quando': instance.quando,
      'repetidor': instance.repetidor,
    };
