// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medicacao.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Medicacao _$MedicacaoFromJson(Map<String, dynamic> json) {
  return _Medicacao.fromJson(json);
}

/// @nodoc
mixin _$Medicacao {
  int? get id => throw _privateConstructorUsedError;
  String get tipo => throw _privateConstructorUsedError;
  @JsonKey(name: 'pet_id')
  String? get petId => throw _privateConstructorUsedError;
  Pet? get pet => throw _privateConstructorUsedError;
  @JsonKey(name: 'inicial_id')
  int? get inicialId => throw _privateConstructorUsedError;
  @JsonKey(name: 'antecessora_id')
  int? get antecessoraId => throw _privateConstructorUsedError;
  String get nome => throw _privateConstructorUsedError;
  String? get fabricante => throw _privateConstructorUsedError;
  String? get veterinario => throw _privateConstructorUsedError;
  String? get quando => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  bool get completado => throw _privateConstructorUsedError;
  Atributos get atributos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MedicacaoCopyWith<Medicacao> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicacaoCopyWith<$Res> {
  factory $MedicacaoCopyWith(Medicacao value, $Res Function(Medicacao) then) =
      _$MedicacaoCopyWithImpl<$Res, Medicacao>;
  @useResult
  $Res call(
      {int? id,
      String tipo,
      @JsonKey(name: 'pet_id') String? petId,
      Pet? pet,
      @JsonKey(name: 'inicial_id') int? inicialId,
      @JsonKey(name: 'antecessora_id') int? antecessoraId,
      String nome,
      String? fabricante,
      String? veterinario,
      String? quando,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      bool completado,
      Atributos atributos});

  $PetCopyWith<$Res>? get pet;
  $AtributosCopyWith<$Res> get atributos;
}

/// @nodoc
class _$MedicacaoCopyWithImpl<$Res, $Val extends Medicacao>
    implements $MedicacaoCopyWith<$Res> {
  _$MedicacaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tipo = null,
    Object? petId = freezed,
    Object? pet = freezed,
    Object? inicialId = freezed,
    Object? antecessoraId = freezed,
    Object? nome = null,
    Object? fabricante = freezed,
    Object? veterinario = freezed,
    Object? quando = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? completado = null,
    Object? atributos = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      petId: freezed == petId
          ? _value.petId
          : petId // ignore: cast_nullable_to_non_nullable
              as String?,
      pet: freezed == pet
          ? _value.pet
          : pet // ignore: cast_nullable_to_non_nullable
              as Pet?,
      inicialId: freezed == inicialId
          ? _value.inicialId
          : inicialId // ignore: cast_nullable_to_non_nullable
              as int?,
      antecessoraId: freezed == antecessoraId
          ? _value.antecessoraId
          : antecessoraId // ignore: cast_nullable_to_non_nullable
              as int?,
      nome: null == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String,
      fabricante: freezed == fabricante
          ? _value.fabricante
          : fabricante // ignore: cast_nullable_to_non_nullable
              as String?,
      veterinario: freezed == veterinario
          ? _value.veterinario
          : veterinario // ignore: cast_nullable_to_non_nullable
              as String?,
      quando: freezed == quando
          ? _value.quando
          : quando // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      completado: null == completado
          ? _value.completado
          : completado // ignore: cast_nullable_to_non_nullable
              as bool,
      atributos: null == atributos
          ? _value.atributos
          : atributos // ignore: cast_nullable_to_non_nullable
              as Atributos,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PetCopyWith<$Res>? get pet {
    if (_value.pet == null) {
      return null;
    }

    return $PetCopyWith<$Res>(_value.pet!, (value) {
      return _then(_value.copyWith(pet: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AtributosCopyWith<$Res> get atributos {
    return $AtributosCopyWith<$Res>(_value.atributos, (value) {
      return _then(_value.copyWith(atributos: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MedicacaoCopyWith<$Res> implements $MedicacaoCopyWith<$Res> {
  factory _$$_MedicacaoCopyWith(
          _$_Medicacao value, $Res Function(_$_Medicacao) then) =
      __$$_MedicacaoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String tipo,
      @JsonKey(name: 'pet_id') String? petId,
      Pet? pet,
      @JsonKey(name: 'inicial_id') int? inicialId,
      @JsonKey(name: 'antecessora_id') int? antecessoraId,
      String nome,
      String? fabricante,
      String? veterinario,
      String? quando,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      bool completado,
      Atributos atributos});

  @override
  $PetCopyWith<$Res>? get pet;
  @override
  $AtributosCopyWith<$Res> get atributos;
}

/// @nodoc
class __$$_MedicacaoCopyWithImpl<$Res>
    extends _$MedicacaoCopyWithImpl<$Res, _$_Medicacao>
    implements _$$_MedicacaoCopyWith<$Res> {
  __$$_MedicacaoCopyWithImpl(
      _$_Medicacao _value, $Res Function(_$_Medicacao) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tipo = null,
    Object? petId = freezed,
    Object? pet = freezed,
    Object? inicialId = freezed,
    Object? antecessoraId = freezed,
    Object? nome = null,
    Object? fabricante = freezed,
    Object? veterinario = freezed,
    Object? quando = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? completado = null,
    Object? atributos = null,
  }) {
    return _then(_$_Medicacao(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      petId: freezed == petId
          ? _value.petId
          : petId // ignore: cast_nullable_to_non_nullable
              as String?,
      pet: freezed == pet
          ? _value.pet
          : pet // ignore: cast_nullable_to_non_nullable
              as Pet?,
      inicialId: freezed == inicialId
          ? _value.inicialId
          : inicialId // ignore: cast_nullable_to_non_nullable
              as int?,
      antecessoraId: freezed == antecessoraId
          ? _value.antecessoraId
          : antecessoraId // ignore: cast_nullable_to_non_nullable
              as int?,
      nome: null == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String,
      fabricante: freezed == fabricante
          ? _value.fabricante
          : fabricante // ignore: cast_nullable_to_non_nullable
              as String?,
      veterinario: freezed == veterinario
          ? _value.veterinario
          : veterinario // ignore: cast_nullable_to_non_nullable
              as String?,
      quando: freezed == quando
          ? _value.quando
          : quando // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      completado: null == completado
          ? _value.completado
          : completado // ignore: cast_nullable_to_non_nullable
              as bool,
      atributos: null == atributos
          ? _value.atributos
          : atributos // ignore: cast_nullable_to_non_nullable
              as Atributos,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Medicacao extends _Medicacao with DiagnosticableTreeMixin {
  const _$_Medicacao(
      {this.id,
      this.tipo = 'medicacao',
      @JsonKey(name: 'pet_id') this.petId,
      this.pet,
      @JsonKey(name: 'inicial_id') this.inicialId,
      @JsonKey(name: 'antecessora_id') this.antecessoraId,
      this.nome = '',
      this.fabricante,
      this.veterinario,
      this.quando,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.completado = false,
      this.atributos = const Atributos()})
      : super._();

  factory _$_Medicacao.fromJson(Map<String, dynamic> json) =>
      _$$_MedicacaoFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey()
  final String tipo;
  @override
  @JsonKey(name: 'pet_id')
  final String? petId;
  @override
  final Pet? pet;
  @override
  @JsonKey(name: 'inicial_id')
  final int? inicialId;
  @override
  @JsonKey(name: 'antecessora_id')
  final int? antecessoraId;
  @override
  @JsonKey()
  final String nome;
  @override
  final String? fabricante;
  @override
  final String? veterinario;
  @override
  final String? quando;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  @JsonKey()
  final bool completado;
  @override
  @JsonKey()
  final Atributos atributos;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Medicacao(id: $id, tipo: $tipo, petId: $petId, pet: $pet, inicialId: $inicialId, antecessoraId: $antecessoraId, nome: $nome, fabricante: $fabricante, veterinario: $veterinario, quando: $quando, createdAt: $createdAt, updatedAt: $updatedAt, completado: $completado, atributos: $atributos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Medicacao'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('tipo', tipo))
      ..add(DiagnosticsProperty('petId', petId))
      ..add(DiagnosticsProperty('pet', pet))
      ..add(DiagnosticsProperty('inicialId', inicialId))
      ..add(DiagnosticsProperty('antecessoraId', antecessoraId))
      ..add(DiagnosticsProperty('nome', nome))
      ..add(DiagnosticsProperty('fabricante', fabricante))
      ..add(DiagnosticsProperty('veterinario', veterinario))
      ..add(DiagnosticsProperty('quando', quando))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('completado', completado))
      ..add(DiagnosticsProperty('atributos', atributos));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Medicacao &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tipo, tipo) || other.tipo == tipo) &&
            (identical(other.petId, petId) || other.petId == petId) &&
            (identical(other.pet, pet) || other.pet == pet) &&
            (identical(other.inicialId, inicialId) ||
                other.inicialId == inicialId) &&
            (identical(other.antecessoraId, antecessoraId) ||
                other.antecessoraId == antecessoraId) &&
            (identical(other.nome, nome) || other.nome == nome) &&
            (identical(other.fabricante, fabricante) ||
                other.fabricante == fabricante) &&
            (identical(other.veterinario, veterinario) ||
                other.veterinario == veterinario) &&
            (identical(other.quando, quando) || other.quando == quando) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.completado, completado) ||
                other.completado == completado) &&
            (identical(other.atributos, atributos) ||
                other.atributos == atributos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tipo,
      petId,
      pet,
      inicialId,
      antecessoraId,
      nome,
      fabricante,
      veterinario,
      quando,
      createdAt,
      updatedAt,
      completado,
      atributos);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MedicacaoCopyWith<_$_Medicacao> get copyWith =>
      __$$_MedicacaoCopyWithImpl<_$_Medicacao>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MedicacaoToJson(
      this,
    );
  }
}

abstract class _Medicacao extends Medicacao {
  const factory _Medicacao(
      {final int? id,
      final String tipo,
      @JsonKey(name: 'pet_id') final String? petId,
      final Pet? pet,
      @JsonKey(name: 'inicial_id') final int? inicialId,
      @JsonKey(name: 'antecessora_id') final int? antecessoraId,
      final String nome,
      final String? fabricante,
      final String? veterinario,
      final String? quando,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      final bool completado,
      final Atributos atributos}) = _$_Medicacao;
  const _Medicacao._() : super._();

  factory _Medicacao.fromJson(Map<String, dynamic> json) =
      _$_Medicacao.fromJson;

  @override
  int? get id;
  @override
  String get tipo;
  @override
  @JsonKey(name: 'pet_id')
  String? get petId;
  @override
  Pet? get pet;
  @override
  @JsonKey(name: 'inicial_id')
  int? get inicialId;
  @override
  @JsonKey(name: 'antecessora_id')
  int? get antecessoraId;
  @override
  String get nome;
  @override
  String? get fabricante;
  @override
  String? get veterinario;
  @override
  String? get quando;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  bool get completado;
  @override
  Atributos get atributos;
  @override
  @JsonKey(ignore: true)
  _$$_MedicacaoCopyWith<_$_Medicacao> get copyWith =>
      throw _privateConstructorUsedError;
}
