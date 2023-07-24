// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pet _$PetFromJson(Map<String, dynamic> json) => Pet(
      id: json['id'] as String?,
      nome: json['nome'] as String? ?? '',
      castrado: json['castrado'] as bool?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      especieId: json['especie_id'] as String?,
      especie: json['especie'] == null
          ? null
          : Especie.fromJson(json['especie'] as Map<String, dynamic>),
      imagem: json['imagem'] as String?,
      imagemUrl: json['imagem_url'] as String?,
      nascimento: json['nascimento'] as String?,
      castracao: json['castracao'] as String?,
      maeId: json['mae_id'] as String?,
      paiId: json['pai_id'] as String?,
      sexo: json['sexo'] as String?,
      raca: json['raca'] as String?,
      espacoId: json['espaco_id'] as String?,
      falecimento: json['falecimento'] as String?,
      userCreated: json['userCreated'] as String?,
      userUpdated: json['userUpdated'] as String?,
    );

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'castrado': instance.castrado,
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
