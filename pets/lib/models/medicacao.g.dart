// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicacao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Medicacao _$$_MedicacaoFromJson(Map<String, dynamic> json) => _$_Medicacao(
      id: json['id'] as int?,
      tipo: json['tipo'] as String? ?? 'medicacao',
      petId: json['pet_id'] as String?,
      pet: json['pet'] == null
          ? null
          : Pet.fromJson(json['pet'] as Map<String, dynamic>),
      inicialId: json['inicial_id'] as int?,
      antecessoraId: json['antecessora_id'] as int?,
      nome: json['nome'] as String? ?? '',
      fabricante: json['fabricante'] as String?,
      veterinario: json['veterinario'] as String?,
      quando: json['quando'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      completado: json['completado'] as bool? ?? false,
    );

Map<String, dynamic> _$$_MedicacaoToJson(_$_Medicacao instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tipo': instance.tipo,
      'pet_id': instance.petId,
      'pet': instance.pet,
      'inicial_id': instance.inicialId,
      'antecessora_id': instance.antecessoraId,
      'nome': instance.nome,
      'fabricante': instance.fabricante,
      'veterinario': instance.veterinario,
      'quando': instance.quando,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'completado': instance.completado,
    };
