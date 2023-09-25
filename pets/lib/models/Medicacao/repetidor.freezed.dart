// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repetidor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Repetidor _$RepetidorFromJson(Map<String, dynamic> json) {
  return _Repetidor.fromJson(json);
}

/// @nodoc
mixin _$Repetidor {
  String? get intervaloValor => throw _privateConstructorUsedError;
  String? get intervaloTipo => throw _privateConstructorUsedError;
  String? get duranteValor => throw _privateConstructorUsedError;
  String? get duranteTipo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepetidorCopyWith<Repetidor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepetidorCopyWith<$Res> {
  factory $RepetidorCopyWith(Repetidor value, $Res Function(Repetidor) then) =
      _$RepetidorCopyWithImpl<$Res, Repetidor>;
  @useResult
  $Res call(
      {String? intervaloValor,
      String? intervaloTipo,
      String? duranteValor,
      String? duranteTipo});
}

/// @nodoc
class _$RepetidorCopyWithImpl<$Res, $Val extends Repetidor>
    implements $RepetidorCopyWith<$Res> {
  _$RepetidorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intervaloValor = freezed,
    Object? intervaloTipo = freezed,
    Object? duranteValor = freezed,
    Object? duranteTipo = freezed,
  }) {
    return _then(_value.copyWith(
      intervaloValor: freezed == intervaloValor
          ? _value.intervaloValor
          : intervaloValor // ignore: cast_nullable_to_non_nullable
              as String?,
      intervaloTipo: freezed == intervaloTipo
          ? _value.intervaloTipo
          : intervaloTipo // ignore: cast_nullable_to_non_nullable
              as String?,
      duranteValor: freezed == duranteValor
          ? _value.duranteValor
          : duranteValor // ignore: cast_nullable_to_non_nullable
              as String?,
      duranteTipo: freezed == duranteTipo
          ? _value.duranteTipo
          : duranteTipo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RepetidorCopyWith<$Res> implements $RepetidorCopyWith<$Res> {
  factory _$$_RepetidorCopyWith(
          _$_Repetidor value, $Res Function(_$_Repetidor) then) =
      __$$_RepetidorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? intervaloValor,
      String? intervaloTipo,
      String? duranteValor,
      String? duranteTipo});
}

/// @nodoc
class __$$_RepetidorCopyWithImpl<$Res>
    extends _$RepetidorCopyWithImpl<$Res, _$_Repetidor>
    implements _$$_RepetidorCopyWith<$Res> {
  __$$_RepetidorCopyWithImpl(
      _$_Repetidor _value, $Res Function(_$_Repetidor) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intervaloValor = freezed,
    Object? intervaloTipo = freezed,
    Object? duranteValor = freezed,
    Object? duranteTipo = freezed,
  }) {
    return _then(_$_Repetidor(
      intervaloValor: freezed == intervaloValor
          ? _value.intervaloValor
          : intervaloValor // ignore: cast_nullable_to_non_nullable
              as String?,
      intervaloTipo: freezed == intervaloTipo
          ? _value.intervaloTipo
          : intervaloTipo // ignore: cast_nullable_to_non_nullable
              as String?,
      duranteValor: freezed == duranteValor
          ? _value.duranteValor
          : duranteValor // ignore: cast_nullable_to_non_nullable
              as String?,
      duranteTipo: freezed == duranteTipo
          ? _value.duranteTipo
          : duranteTipo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Repetidor extends _Repetidor with DiagnosticableTreeMixin {
  const _$_Repetidor(
      {this.intervaloValor,
      this.intervaloTipo,
      this.duranteValor,
      this.duranteTipo})
      : super._();

  factory _$_Repetidor.fromJson(Map<String, dynamic> json) =>
      _$$_RepetidorFromJson(json);

  @override
  final String? intervaloValor;
  @override
  final String? intervaloTipo;
  @override
  final String? duranteValor;
  @override
  final String? duranteTipo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Repetidor(intervaloValor: $intervaloValor, intervaloTipo: $intervaloTipo, duranteValor: $duranteValor, duranteTipo: $duranteTipo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Repetidor'))
      ..add(DiagnosticsProperty('intervaloValor', intervaloValor))
      ..add(DiagnosticsProperty('intervaloTipo', intervaloTipo))
      ..add(DiagnosticsProperty('duranteValor', duranteValor))
      ..add(DiagnosticsProperty('duranteTipo', duranteTipo));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Repetidor &&
            (identical(other.intervaloValor, intervaloValor) ||
                other.intervaloValor == intervaloValor) &&
            (identical(other.intervaloTipo, intervaloTipo) ||
                other.intervaloTipo == intervaloTipo) &&
            (identical(other.duranteValor, duranteValor) ||
                other.duranteValor == duranteValor) &&
            (identical(other.duranteTipo, duranteTipo) ||
                other.duranteTipo == duranteTipo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, intervaloValor, intervaloTipo, duranteValor, duranteTipo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RepetidorCopyWith<_$_Repetidor> get copyWith =>
      __$$_RepetidorCopyWithImpl<_$_Repetidor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RepetidorToJson(
      this,
    );
  }
}

abstract class _Repetidor extends Repetidor {
  const factory _Repetidor(
      {final String? intervaloValor,
      final String? intervaloTipo,
      final String? duranteValor,
      final String? duranteTipo}) = _$_Repetidor;
  const _Repetidor._() : super._();

  factory _Repetidor.fromJson(Map<String, dynamic> json) =
      _$_Repetidor.fromJson;

  @override
  String? get intervaloValor;
  @override
  String? get intervaloTipo;
  @override
  String? get duranteValor;
  @override
  String? get duranteTipo;
  @override
  @JsonKey(ignore: true)
  _$$_RepetidorCopyWith<_$_Repetidor> get copyWith =>
      throw _privateConstructorUsedError;
}
