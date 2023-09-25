// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Pet _$$_PetFromJson(Map<String, dynamic> json) => _$_Pet(
      id: json['id'] as String?,
      nome: json['nome'] as String? ?? '',
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      especieId: json['especie_id'] as String?,
      especie: json['especie'] == null
          ? null
          : Especie.fromJson(json['especie'] as Map<String, dynamic>),
      imagem: json['imagem'] as String?,
      maeId: json['mae_id'] as String?,
      nascimento: json['nascimento'] as String?,
      castracao: json['castracao'] as String?,
      paiId: json['pai_id'] as String?,
      raca: json['raca'] as String?,
      sexo: json['sexo'] as String?,
      userCreated: json['userCreated'] as String?,
      userUpdated: json['userUpdated'] as String?,
      espacoId: json['espaco_id'] as String?,
      falecimento: json['falecimento'] as String?,
      imagemUrl: json['imagem_url'] as String?,
    );

Map<String, dynamic> _$$_PetToJson(_$_Pet instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'especie_id': instance.especieId,
      'especie': instance.especie,
      'imagem': instance.imagem,
      'mae_id': instance.maeId,
      'nascimento': instance.nascimento,
      'castracao': instance.castracao,
      'pai_id': instance.paiId,
      'raca': instance.raca,
      'sexo': instance.sexo,
      'userCreated': instance.userCreated,
      'userUpdated': instance.userUpdated,
      'espaco_id': instance.espacoId,
      'falecimento': instance.falecimento,
      'imagem_url': instance.imagemUrl,
    };
