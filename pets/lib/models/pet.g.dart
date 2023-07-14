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
      mae: json['mae'] as String?,
      pai: json['pai'] as String?,
      sexo: json['sexo'] as String?,
      raca: json['raca'] as String?,
      espacoId: json['espaco_id'] as String?,
      obito: json['obito'] as String?,
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
      'mae': instance.mae,
      'nascimento': instance.nascimento,
      'castracao': instance.castracao,
      'pai': instance.pai,
      'raca': instance.raca,
      'sexo': instance.sexo,
      'userCreated': instance.userCreated,
      'userUpdated': instance.userUpdated,
      'espaco_id': instance.espacoId,
      'obito': instance.obito,
      'imagem_url': instance.imagemUrl,
    };
