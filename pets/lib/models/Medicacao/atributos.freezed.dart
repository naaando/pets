// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'atributos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Atributos _$AtributosFromJson(Map<String, dynamic> json) {
  return _Atributos.fromJson(json);
}

/// @nodoc
mixin _$Atributos {
  String? get fabricante => throw _privateConstructorUsedError;
  String? get veterinario => throw _privateConstructorUsedError;
  String? get quando => throw _privateConstructorUsedError;
  Repetidor get repetidor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AtributosCopyWith<Atributos> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AtributosCopyWith<$Res> {
  factory $AtributosCopyWith(Atributos value, $Res Function(Atributos) then) =
      _$AtributosCopyWithImpl<$Res, Atributos>;
  @useResult
  $Res call(
      {String? fabricante,
      String? veterinario,
      String? quando,
      Repetidor repetidor});

  $RepetidorCopyWith<$Res> get repetidor;
}

/// @nodoc
class _$AtributosCopyWithImpl<$Res, $Val extends Atributos>
    implements $AtributosCopyWith<$Res> {
  _$AtributosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fabricante = freezed,
    Object? veterinario = freezed,
    Object? quando = freezed,
    Object? repetidor = null,
  }) {
    return _then(_value.copyWith(
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
      repetidor: null == repetidor
          ? _value.repetidor
          : repetidor // ignore: cast_nullable_to_non_nullable
              as Repetidor,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RepetidorCopyWith<$Res> get repetidor {
    return $RepetidorCopyWith<$Res>(_value.repetidor, (value) {
      return _then(_value.copyWith(repetidor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AtributosCopyWith<$Res> implements $AtributosCopyWith<$Res> {
  factory _$$_AtributosCopyWith(
          _$_Atributos value, $Res Function(_$_Atributos) then) =
      __$$_AtributosCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? fabricante,
      String? veterinario,
      String? quando,
      Repetidor repetidor});

  @override
  $RepetidorCopyWith<$Res> get repetidor;
}

/// @nodoc
class __$$_AtributosCopyWithImpl<$Res>
    extends _$AtributosCopyWithImpl<$Res, _$_Atributos>
    implements _$$_AtributosCopyWith<$Res> {
  __$$_AtributosCopyWithImpl(
      _$_Atributos _value, $Res Function(_$_Atributos) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fabricante = freezed,
    Object? veterinario = freezed,
    Object? quando = freezed,
    Object? repetidor = null,
  }) {
    return _then(_$_Atributos(
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
      repetidor: null == repetidor
          ? _value.repetidor
          : repetidor // ignore: cast_nullable_to_non_nullable
              as Repetidor,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Atributos extends _Atributos with DiagnosticableTreeMixin {
  const _$_Atributos(
      {this.fabricante,
      this.veterinario,
      this.quando,
      this.repetidor = const Repetidor()})
      : super._();

  factory _$_Atributos.fromJson(Map<String, dynamic> json) =>
      _$$_AtributosFromJson(json);

  @override
  final String? fabricante;
  @override
  final String? veterinario;
  @override
  final String? quando;
  @override
  @JsonKey()
  final Repetidor repetidor;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Atributos(fabricante: $fabricante, veterinario: $veterinario, quando: $quando, repetidor: $repetidor)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Atributos'))
      ..add(DiagnosticsProperty('fabricante', fabricante))
      ..add(DiagnosticsProperty('veterinario', veterinario))
      ..add(DiagnosticsProperty('quando', quando))
      ..add(DiagnosticsProperty('repetidor', repetidor));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Atributos &&
            (identical(other.fabricante, fabricante) ||
                other.fabricante == fabricante) &&
            (identical(other.veterinario, veterinario) ||
                other.veterinario == veterinario) &&
            (identical(other.quando, quando) || other.quando == quando) &&
            (identical(other.repetidor, repetidor) ||
                other.repetidor == repetidor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fabricante, veterinario, quando, repetidor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AtributosCopyWith<_$_Atributos> get copyWith =>
      __$$_AtributosCopyWithImpl<_$_Atributos>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AtributosToJson(
      this,
    );
  }
}

abstract class _Atributos extends Atributos {
  const factory _Atributos(
      {final String? fabricante,
      final String? veterinario,
      final String? quando,
      final Repetidor repetidor}) = _$_Atributos;
  const _Atributos._() : super._();

  factory _Atributos.fromJson(Map<String, dynamic> json) =
      _$_Atributos.fromJson;

  @override
  String? get fabricante;
  @override
  String? get veterinario;
  @override
  String? get quando;
  @override
  Repetidor get repetidor;
  @override
  @JsonKey(ignore: true)
  _$$_AtributosCopyWith<_$_Atributos> get copyWith =>
      throw _privateConstructorUsedError;
}
