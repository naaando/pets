// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicacao.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMedicacaoCollection on Isar {
  IsarCollection<Medicacao> get medicacaos => this.collection();
}

const MedicacaoSchema = CollectionSchema(
  name: r'Medicacao',
  id: -908804645793675552,
  properties: {
    r'antecessoraId': PropertySchema(
      id: 0,
      name: r'antecessoraId',
      type: IsarType.long,
    ),
    r'completado': PropertySchema(
      id: 1,
      name: r'completado',
      type: IsarType.bool,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.string,
    ),
    r'fabricante': PropertySchema(
      id: 3,
      name: r'fabricante',
      type: IsarType.string,
    ),
    r'inicialId': PropertySchema(
      id: 4,
      name: r'inicialId',
      type: IsarType.long,
    ),
    r'nome': PropertySchema(
      id: 5,
      name: r'nome',
      type: IsarType.string,
    ),
    r'petId': PropertySchema(
      id: 6,
      name: r'petId',
      type: IsarType.string,
    ),
    r'quando': PropertySchema(
      id: 7,
      name: r'quando',
      type: IsarType.string,
    ),
    r'tipo': PropertySchema(
      id: 8,
      name: r'tipo',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 9,
      name: r'updatedAt',
      type: IsarType.string,
    ),
    r'veterinario': PropertySchema(
      id: 10,
      name: r'veterinario',
      type: IsarType.string,
    )
  },
  estimateSize: _medicacaoEstimateSize,
  serialize: _medicacaoSerialize,
  deserialize: _medicacaoDeserialize,
  deserializeProp: _medicacaoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _medicacaoGetId,
  getLinks: _medicacaoGetLinks,
  attach: _medicacaoAttach,
  version: '3.1.0+1',
);

int _medicacaoEstimateSize(
  Medicacao object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.createdAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fabricante;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.nome.length * 3;
  {
    final value = object.petId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.quando;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.tipo.length * 3;
  {
    final value = object.updatedAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.veterinario;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _medicacaoSerialize(
  Medicacao object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.antecessoraId);
  writer.writeBool(offsets[1], object.completado);
  writer.writeString(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.fabricante);
  writer.writeLong(offsets[4], object.inicialId);
  writer.writeString(offsets[5], object.nome);
  writer.writeString(offsets[6], object.petId);
  writer.writeString(offsets[7], object.quando);
  writer.writeString(offsets[8], object.tipo);
  writer.writeString(offsets[9], object.updatedAt);
  writer.writeString(offsets[10], object.veterinario);
}

Medicacao _medicacaoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Medicacao(
    antecessoraId: reader.readLongOrNull(offsets[0]),
    completado: reader.readBoolOrNull(offsets[1]) ?? false,
    createdAt: reader.readStringOrNull(offsets[2]),
    fabricante: reader.readStringOrNull(offsets[3]),
    id: id,
    inicialId: reader.readLongOrNull(offsets[4]),
    nome: reader.readStringOrNull(offsets[5]) ?? '',
    petId: reader.readStringOrNull(offsets[6]),
    quando: reader.readStringOrNull(offsets[7]),
    tipo: reader.readStringOrNull(offsets[8]) ?? 'medicacao',
    updatedAt: reader.readStringOrNull(offsets[9]),
    veterinario: reader.readStringOrNull(offsets[10]),
  );
  return object;
}

P _medicacaoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset) ?? 'medicacao') as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _medicacaoGetId(Medicacao object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _medicacaoGetLinks(Medicacao object) {
  return [];
}

void _medicacaoAttach(IsarCollection<dynamic> col, Id id, Medicacao object) {
  object.id = id;
}

extension MedicacaoQueryWhereSort
    on QueryBuilder<Medicacao, Medicacao, QWhere> {
  QueryBuilder<Medicacao, Medicacao, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MedicacaoQueryWhere
    on QueryBuilder<Medicacao, Medicacao, QWhereClause> {
  QueryBuilder<Medicacao, Medicacao, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MedicacaoQueryFilter
    on QueryBuilder<Medicacao, Medicacao, QFilterCondition> {
  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      antecessoraIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'antecessoraId',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      antecessoraIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'antecessoraId',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      antecessoraIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'antecessoraId',
        value: value,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      antecessoraIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'antecessoraId',
        value: value,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      antecessoraIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'antecessoraId',
        value: value,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      antecessoraIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'antecessoraId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> completadoEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completado',
        value: value,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> createdAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      createdAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> createdAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> createdAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> createdAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> createdAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> createdAtContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> createdAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> createdAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      createdAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAt',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> fabricanteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fabricante',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      fabricanteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fabricante',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> fabricanteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fabricante',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      fabricanteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fabricante',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> fabricanteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fabricante',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> fabricanteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fabricante',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      fabricanteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fabricante',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> fabricanteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fabricante',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> fabricanteContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fabricante',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> fabricanteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fabricante',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      fabricanteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fabricante',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      fabricanteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fabricante',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> inicialIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inicialId',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      inicialIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inicialId',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> inicialIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inicialId',
        value: value,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      inicialIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inicialId',
        value: value,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> inicialIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inicialId',
        value: value,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> inicialIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inicialId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> nomeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> nomeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> nomeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> nomeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> nomeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> nomeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> nomeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> nomeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nome',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> petIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'petId',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> petIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'petId',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> petIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'petId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> petIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'petId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> petIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'petId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> petIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'petId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> petIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'petId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> petIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'petId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> petIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'petId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> petIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'petId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> petIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'petId',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> petIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'petId',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> quandoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quando',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> quandoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quando',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> quandoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quando',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> quandoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quando',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> quandoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quando',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> quandoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quando',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> quandoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quando',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> quandoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quando',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> quandoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quando',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> quandoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quando',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> quandoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quando',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> quandoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quando',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> tipoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> tipoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> tipoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> tipoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> tipoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> tipoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> tipoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> tipoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> tipoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> tipoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipo',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> updatedAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      updatedAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> updatedAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> updatedAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> updatedAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> updatedAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> updatedAtContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> updatedAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'updatedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> updatedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      updatedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'updatedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      veterinarioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'veterinario',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      veterinarioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'veterinario',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> veterinarioEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'veterinario',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      veterinarioGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'veterinario',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> veterinarioLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'veterinario',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> veterinarioBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'veterinario',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      veterinarioStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'veterinario',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> veterinarioEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'veterinario',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> veterinarioContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'veterinario',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition> veterinarioMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'veterinario',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      veterinarioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'veterinario',
        value: '',
      ));
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterFilterCondition>
      veterinarioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'veterinario',
        value: '',
      ));
    });
  }
}

extension MedicacaoQueryObject
    on QueryBuilder<Medicacao, Medicacao, QFilterCondition> {}

extension MedicacaoQueryLinks
    on QueryBuilder<Medicacao, Medicacao, QFilterCondition> {}

extension MedicacaoQuerySortBy on QueryBuilder<Medicacao, Medicacao, QSortBy> {
  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByAntecessoraId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'antecessoraId', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByAntecessoraIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'antecessoraId', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByCompletado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completado', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByCompletadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completado', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByFabricante() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fabricante', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByFabricanteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fabricante', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByInicialId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inicialId', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByInicialIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inicialId', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByPetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByQuando() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quando', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByQuandoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quando', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByVeterinario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'veterinario', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> sortByVeterinarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'veterinario', Sort.desc);
    });
  }
}

extension MedicacaoQuerySortThenBy
    on QueryBuilder<Medicacao, Medicacao, QSortThenBy> {
  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByAntecessoraId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'antecessoraId', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByAntecessoraIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'antecessoraId', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByCompletado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completado', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByCompletadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completado', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByFabricante() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fabricante', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByFabricanteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fabricante', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByInicialId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inicialId', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByInicialIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inicialId', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByPetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByQuando() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quando', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByQuandoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quando', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByVeterinario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'veterinario', Sort.asc);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QAfterSortBy> thenByVeterinarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'veterinario', Sort.desc);
    });
  }
}

extension MedicacaoQueryWhereDistinct
    on QueryBuilder<Medicacao, Medicacao, QDistinct> {
  QueryBuilder<Medicacao, Medicacao, QDistinct> distinctByAntecessoraId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'antecessoraId');
    });
  }

  QueryBuilder<Medicacao, Medicacao, QDistinct> distinctByCompletado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completado');
    });
  }

  QueryBuilder<Medicacao, Medicacao, QDistinct> distinctByCreatedAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QDistinct> distinctByFabricante(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fabricante', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QDistinct> distinctByInicialId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inicialId');
    });
  }

  QueryBuilder<Medicacao, Medicacao, QDistinct> distinctByNome(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QDistinct> distinctByPetId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'petId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QDistinct> distinctByQuando(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quando', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QDistinct> distinctByTipo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QDistinct> distinctByUpdatedAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Medicacao, Medicacao, QDistinct> distinctByVeterinario(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'veterinario', caseSensitive: caseSensitive);
    });
  }
}

extension MedicacaoQueryProperty
    on QueryBuilder<Medicacao, Medicacao, QQueryProperty> {
  QueryBuilder<Medicacao, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Medicacao, int?, QQueryOperations> antecessoraIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'antecessoraId');
    });
  }

  QueryBuilder<Medicacao, bool, QQueryOperations> completadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completado');
    });
  }

  QueryBuilder<Medicacao, String?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Medicacao, String?, QQueryOperations> fabricanteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fabricante');
    });
  }

  QueryBuilder<Medicacao, int?, QQueryOperations> inicialIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inicialId');
    });
  }

  QueryBuilder<Medicacao, String, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }

  QueryBuilder<Medicacao, String?, QQueryOperations> petIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'petId');
    });
  }

  QueryBuilder<Medicacao, String?, QQueryOperations> quandoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quando');
    });
  }

  QueryBuilder<Medicacao, String, QQueryOperations> tipoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipo');
    });
  }

  QueryBuilder<Medicacao, String?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<Medicacao, String?, QQueryOperations> veterinarioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'veterinario');
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medicacao _$MedicacaoFromJson(Map<String, dynamic> json) => Medicacao(
      id: json['id'] as int?,
      inicialId: json['inicial_id'] as int?,
      antecessoraId: json['antecessora_id'] as int?,
      tipo: json['tipo'] as String? ?? 'medicacao',
      petId: json['pet_id'] as String?,
      pet: json['pet'] == null
          ? null
          : Pet.fromJson(json['pet'] as Map<String, dynamic>),
      nome: json['nome'] as String? ?? '',
      fabricante: json['fabricante'] as String?,
      veterinario: json['veterinario'] as String?,
      quando: json['quando'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      completado: json['completado'] as bool? ?? false,
    );

Map<String, dynamic> _$MedicacaoToJson(Medicacao instance) => <String, dynamic>{
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
