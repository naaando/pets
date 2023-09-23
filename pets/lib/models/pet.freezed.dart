// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Pet _$PetFromJson(Map<String, dynamic> json) {
  return _Pet.fromJson(json);
}

/// @nodoc
mixin _$Pet {
  String? get id => throw _privateConstructorUsedError;
  String get nome => throw _privateConstructorUsedError;
  bool? get castrado => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'especie_id')
  String? get especieId => throw _privateConstructorUsedError;
  Especie? get especie => throw _privateConstructorUsedError;
  String? get imagem => throw _privateConstructorUsedError;
  @JsonKey(name: 'mae_id')
  String? get maeId => throw _privateConstructorUsedError;
  String? get nascimento => throw _privateConstructorUsedError;
  String? get castracao => throw _privateConstructorUsedError;
  @JsonKey(name: 'pai_id')
  String? get paiId => throw _privateConstructorUsedError;
  String? get raca => throw _privateConstructorUsedError;
  String? get sexo => throw _privateConstructorUsedError;
  String? get userCreated => throw _privateConstructorUsedError;
  String? get userUpdated => throw _privateConstructorUsedError;
  @JsonKey(name: 'espaco_id')
  String? get espacoId => throw _privateConstructorUsedError;
  String? get falecimento => throw _privateConstructorUsedError;
  @JsonKey(name: 'imagem_url')
  String? get imagemUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PetCopyWith<Pet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetCopyWith<$Res> {
  factory $PetCopyWith(Pet value, $Res Function(Pet) then) =
      _$PetCopyWithImpl<$Res, Pet>;
  @useResult
  $Res call(
      {String? id,
      String nome,
      bool? castrado,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'especie_id') String? especieId,
      Especie? especie,
      String? imagem,
      @JsonKey(name: 'mae_id') String? maeId,
      String? nascimento,
      String? castracao,
      @JsonKey(name: 'pai_id') String? paiId,
      String? raca,
      String? sexo,
      String? userCreated,
      String? userUpdated,
      @JsonKey(name: 'espaco_id') String? espacoId,
      String? falecimento,
      @JsonKey(name: 'imagem_url') String? imagemUrl});
}

/// @nodoc
class _$PetCopyWithImpl<$Res, $Val extends Pet> implements $PetCopyWith<$Res> {
  _$PetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? nome = null,
    Object? castrado = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? especieId = freezed,
    Object? especie = freezed,
    Object? imagem = freezed,
    Object? maeId = freezed,
    Object? nascimento = freezed,
    Object? castracao = freezed,
    Object? paiId = freezed,
    Object? raca = freezed,
    Object? sexo = freezed,
    Object? userCreated = freezed,
    Object? userUpdated = freezed,
    Object? espacoId = freezed,
    Object? falecimento = freezed,
    Object? imagemUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      nome: null == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String,
      castrado: freezed == castrado
          ? _value.castrado
          : castrado // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      especieId: freezed == especieId
          ? _value.especieId
          : especieId // ignore: cast_nullable_to_non_nullable
              as String?,
      especie: freezed == especie
          ? _value.especie
          : especie // ignore: cast_nullable_to_non_nullable
              as Especie?,
      imagem: freezed == imagem
          ? _value.imagem
          : imagem // ignore: cast_nullable_to_non_nullable
              as String?,
      maeId: freezed == maeId
          ? _value.maeId
          : maeId // ignore: cast_nullable_to_non_nullable
              as String?,
      nascimento: freezed == nascimento
          ? _value.nascimento
          : nascimento // ignore: cast_nullable_to_non_nullable
              as String?,
      castracao: freezed == castracao
          ? _value.castracao
          : castracao // ignore: cast_nullable_to_non_nullable
              as String?,
      paiId: freezed == paiId
          ? _value.paiId
          : paiId // ignore: cast_nullable_to_non_nullable
              as String?,
      raca: freezed == raca
          ? _value.raca
          : raca // ignore: cast_nullable_to_non_nullable
              as String?,
      sexo: freezed == sexo
          ? _value.sexo
          : sexo // ignore: cast_nullable_to_non_nullable
              as String?,
      userCreated: freezed == userCreated
          ? _value.userCreated
          : userCreated // ignore: cast_nullable_to_non_nullable
              as String?,
      userUpdated: freezed == userUpdated
          ? _value.userUpdated
          : userUpdated // ignore: cast_nullable_to_non_nullable
              as String?,
      espacoId: freezed == espacoId
          ? _value.espacoId
          : espacoId // ignore: cast_nullable_to_non_nullable
              as String?,
      falecimento: freezed == falecimento
          ? _value.falecimento
          : falecimento // ignore: cast_nullable_to_non_nullable
              as String?,
      imagemUrl: freezed == imagemUrl
          ? _value.imagemUrl
          : imagemUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PetCopyWith<$Res> implements $PetCopyWith<$Res> {
  factory _$$_PetCopyWith(_$_Pet value, $Res Function(_$_Pet) then) =
      __$$_PetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String nome,
      bool? castrado,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'especie_id') String? especieId,
      Especie? especie,
      String? imagem,
      @JsonKey(name: 'mae_id') String? maeId,
      String? nascimento,
      String? castracao,
      @JsonKey(name: 'pai_id') String? paiId,
      String? raca,
      String? sexo,
      String? userCreated,
      String? userUpdated,
      @JsonKey(name: 'espaco_id') String? espacoId,
      String? falecimento,
      @JsonKey(name: 'imagem_url') String? imagemUrl});
}

/// @nodoc
class __$$_PetCopyWithImpl<$Res> extends _$PetCopyWithImpl<$Res, _$_Pet>
    implements _$$_PetCopyWith<$Res> {
  __$$_PetCopyWithImpl(_$_Pet _value, $Res Function(_$_Pet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? nome = null,
    Object? castrado = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? especieId = freezed,
    Object? especie = freezed,
    Object? imagem = freezed,
    Object? maeId = freezed,
    Object? nascimento = freezed,
    Object? castracao = freezed,
    Object? paiId = freezed,
    Object? raca = freezed,
    Object? sexo = freezed,
    Object? userCreated = freezed,
    Object? userUpdated = freezed,
    Object? espacoId = freezed,
    Object? falecimento = freezed,
    Object? imagemUrl = freezed,
  }) {
    return _then(_$_Pet(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      nome: null == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String,
      castrado: freezed == castrado
          ? _value.castrado
          : castrado // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      especieId: freezed == especieId
          ? _value.especieId
          : especieId // ignore: cast_nullable_to_non_nullable
              as String?,
      especie: freezed == especie
          ? _value.especie
          : especie // ignore: cast_nullable_to_non_nullable
              as Especie?,
      imagem: freezed == imagem
          ? _value.imagem
          : imagem // ignore: cast_nullable_to_non_nullable
              as String?,
      maeId: freezed == maeId
          ? _value.maeId
          : maeId // ignore: cast_nullable_to_non_nullable
              as String?,
      nascimento: freezed == nascimento
          ? _value.nascimento
          : nascimento // ignore: cast_nullable_to_non_nullable
              as String?,
      castracao: freezed == castracao
          ? _value.castracao
          : castracao // ignore: cast_nullable_to_non_nullable
              as String?,
      paiId: freezed == paiId
          ? _value.paiId
          : paiId // ignore: cast_nullable_to_non_nullable
              as String?,
      raca: freezed == raca
          ? _value.raca
          : raca // ignore: cast_nullable_to_non_nullable
              as String?,
      sexo: freezed == sexo
          ? _value.sexo
          : sexo // ignore: cast_nullable_to_non_nullable
              as String?,
      userCreated: freezed == userCreated
          ? _value.userCreated
          : userCreated // ignore: cast_nullable_to_non_nullable
              as String?,
      userUpdated: freezed == userUpdated
          ? _value.userUpdated
          : userUpdated // ignore: cast_nullable_to_non_nullable
              as String?,
      espacoId: freezed == espacoId
          ? _value.espacoId
          : espacoId // ignore: cast_nullable_to_non_nullable
              as String?,
      falecimento: freezed == falecimento
          ? _value.falecimento
          : falecimento // ignore: cast_nullable_to_non_nullable
              as String?,
      imagemUrl: freezed == imagemUrl
          ? _value.imagemUrl
          : imagemUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Pet extends _Pet with DiagnosticableTreeMixin {
  const _$_Pet(
      {this.id,
      this.nome = '',
      this.castrado,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'especie_id') this.especieId,
      this.especie,
      this.imagem,
      @JsonKey(name: 'mae_id') this.maeId,
      this.nascimento,
      this.castracao,
      @JsonKey(name: 'pai_id') this.paiId,
      this.raca,
      this.sexo,
      this.userCreated,
      this.userUpdated,
      @JsonKey(name: 'espaco_id') required this.espacoId,
      this.falecimento,
      @JsonKey(name: 'imagem_url') this.imagemUrl})
      : super._();

  factory _$_Pet.fromJson(Map<String, dynamic> json) => _$$_PetFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey()
  final String nome;
  @override
  final bool? castrado;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  @JsonKey(name: 'especie_id')
  final String? especieId;
  @override
  final Especie? especie;
  @override
  final String? imagem;
  @override
  @JsonKey(name: 'mae_id')
  final String? maeId;
  @override
  final String? nascimento;
  @override
  final String? castracao;
  @override
  @JsonKey(name: 'pai_id')
  final String? paiId;
  @override
  final String? raca;
  @override
  final String? sexo;
  @override
  final String? userCreated;
  @override
  final String? userUpdated;
  @override
  @JsonKey(name: 'espaco_id')
  final String? espacoId;
  @override
  final String? falecimento;
  @override
  @JsonKey(name: 'imagem_url')
  final String? imagemUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Pet(id: $id, nome: $nome, castrado: $castrado, createdAt: $createdAt, updatedAt: $updatedAt, especieId: $especieId, especie: $especie, imagem: $imagem, maeId: $maeId, nascimento: $nascimento, castracao: $castracao, paiId: $paiId, raca: $raca, sexo: $sexo, userCreated: $userCreated, userUpdated: $userUpdated, espacoId: $espacoId, falecimento: $falecimento, imagemUrl: $imagemUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Pet'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('nome', nome))
      ..add(DiagnosticsProperty('castrado', castrado))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('especieId', especieId))
      ..add(DiagnosticsProperty('especie', especie))
      ..add(DiagnosticsProperty('imagem', imagem))
      ..add(DiagnosticsProperty('maeId', maeId))
      ..add(DiagnosticsProperty('nascimento', nascimento))
      ..add(DiagnosticsProperty('castracao', castracao))
      ..add(DiagnosticsProperty('paiId', paiId))
      ..add(DiagnosticsProperty('raca', raca))
      ..add(DiagnosticsProperty('sexo', sexo))
      ..add(DiagnosticsProperty('userCreated', userCreated))
      ..add(DiagnosticsProperty('userUpdated', userUpdated))
      ..add(DiagnosticsProperty('espacoId', espacoId))
      ..add(DiagnosticsProperty('falecimento', falecimento))
      ..add(DiagnosticsProperty('imagemUrl', imagemUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Pet &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nome, nome) || other.nome == nome) &&
            (identical(other.castrado, castrado) ||
                other.castrado == castrado) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.especieId, especieId) ||
                other.especieId == especieId) &&
            (identical(other.especie, especie) || other.especie == especie) &&
            (identical(other.imagem, imagem) || other.imagem == imagem) &&
            (identical(other.maeId, maeId) || other.maeId == maeId) &&
            (identical(other.nascimento, nascimento) ||
                other.nascimento == nascimento) &&
            (identical(other.castracao, castracao) ||
                other.castracao == castracao) &&
            (identical(other.paiId, paiId) || other.paiId == paiId) &&
            (identical(other.raca, raca) || other.raca == raca) &&
            (identical(other.sexo, sexo) || other.sexo == sexo) &&
            (identical(other.userCreated, userCreated) ||
                other.userCreated == userCreated) &&
            (identical(other.userUpdated, userUpdated) ||
                other.userUpdated == userUpdated) &&
            (identical(other.espacoId, espacoId) ||
                other.espacoId == espacoId) &&
            (identical(other.falecimento, falecimento) ||
                other.falecimento == falecimento) &&
            (identical(other.imagemUrl, imagemUrl) ||
                other.imagemUrl == imagemUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        nome,
        castrado,
        createdAt,
        updatedAt,
        especieId,
        especie,
        imagem,
        maeId,
        nascimento,
        castracao,
        paiId,
        raca,
        sexo,
        userCreated,
        userUpdated,
        espacoId,
        falecimento,
        imagemUrl
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PetCopyWith<_$_Pet> get copyWith =>
      __$$_PetCopyWithImpl<_$_Pet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PetToJson(
      this,
    );
  }
}

abstract class _Pet extends Pet {
  const factory _Pet(
      {final String? id,
      final String nome,
      final bool? castrado,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      @JsonKey(name: 'especie_id') final String? especieId,
      final Especie? especie,
      final String? imagem,
      @JsonKey(name: 'mae_id') final String? maeId,
      final String? nascimento,
      final String? castracao,
      @JsonKey(name: 'pai_id') final String? paiId,
      final String? raca,
      final String? sexo,
      final String? userCreated,
      final String? userUpdated,
      @JsonKey(name: 'espaco_id') required final String? espacoId,
      final String? falecimento,
      @JsonKey(name: 'imagem_url') final String? imagemUrl}) = _$_Pet;
  const _Pet._() : super._();

  factory _Pet.fromJson(Map<String, dynamic> json) = _$_Pet.fromJson;

  @override
  String? get id;
  @override
  String get nome;
  @override
  bool? get castrado;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(name: 'especie_id')
  String? get especieId;
  @override
  Especie? get especie;
  @override
  String? get imagem;
  @override
  @JsonKey(name: 'mae_id')
  String? get maeId;
  @override
  String? get nascimento;
  @override
  String? get castracao;
  @override
  @JsonKey(name: 'pai_id')
  String? get paiId;
  @override
  String? get raca;
  @override
  String? get sexo;
  @override
  String? get userCreated;
  @override
  String? get userUpdated;
  @override
  @JsonKey(name: 'espaco_id')
  String? get espacoId;
  @override
  String? get falecimento;
  @override
  @JsonKey(name: 'imagem_url')
  String? get imagemUrl;
  @override
  @JsonKey(ignore: true)
  _$$_PetCopyWith<_$_Pet> get copyWith => throw _privateConstructorUsedError;
}
