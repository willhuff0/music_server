// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unprocessed_song.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUnprocessedSongCollection on Isar {
  IsarCollection<UnprocessedSong> get unprocessedSongs => this.collection();
}

const UnprocessedSongSchema = CollectionSchema(
  name: r'UnprocessedSong',
  id: -7741506292936506925,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'duration': PropertySchema(
      id: 1,
      name: r'duration',
      type: IsarType.long,
    ),
    r'explicit': PropertySchema(
      id: 2,
      name: r'explicit',
      type: IsarType.bool,
    ),
    r'fileExtension': PropertySchema(
      id: 3,
      name: r'fileExtension',
      type: IsarType.string,
    ),
    r'genres': PropertySchema(
      id: 4,
      name: r'genres',
      type: IsarType.byteList,
      enumMap: _UnprocessedSonggenresEnumValueMap,
    ),
    r'id': PropertySchema(
      id: 5,
      name: r'id',
      type: IsarType.string,
    ),
    r'imageFileExtension': PropertySchema(
      id: 6,
      name: r'imageFileExtension',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 7,
      name: r'name',
      type: IsarType.string,
    ),
    r'numParts': PropertySchema(
      id: 8,
      name: r'numParts',
      type: IsarType.long,
    ),
    r'numPartsReceived': PropertySchema(
      id: 9,
      name: r'numPartsReceived',
      type: IsarType.long,
    ),
    r'owner': PropertySchema(
      id: 10,
      name: r'owner',
      type: IsarType.string,
    )
  },
  estimateSize: _unprocessedSongEstimateSize,
  serialize: _unprocessedSongSerialize,
  deserialize: _unprocessedSongDeserialize,
  deserializeProp: _unprocessedSongDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _unprocessedSongGetId,
  getLinks: _unprocessedSongGetLinks,
  attach: _unprocessedSongAttach,
  version: '3.1.0+1',
);

int _unprocessedSongEstimateSize(
  UnprocessedSong object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.fileExtension.length * 3;
  bytesCount += 3 + object.genres.length;
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.imageFileExtension;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.owner.length * 3;
  return bytesCount;
}

void _unprocessedSongSerialize(
  UnprocessedSong object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeLong(offsets[1], object.duration);
  writer.writeBool(offsets[2], object.explicit);
  writer.writeString(offsets[3], object.fileExtension);
  writer.writeByteList(offsets[4], object.genres.map((e) => e.index).toList());
  writer.writeString(offsets[5], object.id);
  writer.writeString(offsets[6], object.imageFileExtension);
  writer.writeString(offsets[7], object.name);
  writer.writeLong(offsets[8], object.numParts);
  writer.writeLong(offsets[9], object.numPartsReceived);
  writer.writeString(offsets[10], object.owner);
}

UnprocessedSong _unprocessedSongDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UnprocessedSong(
    description: reader.readString(offsets[0]),
    duration: reader.readLong(offsets[1]),
    explicit: reader.readBool(offsets[2]),
    fileExtension: reader.readString(offsets[3]),
    genres: reader
            .readByteList(offsets[4])
            ?.map((e) => _UnprocessedSonggenresValueEnumMap[e] ?? Genre.hipHop)
            .toList() ??
        [],
    id: reader.readString(offsets[5]),
    imageFileExtension: reader.readStringOrNull(offsets[6]),
    isarId: id,
    name: reader.readString(offsets[7]),
    numParts: reader.readLong(offsets[8]),
    numPartsReceived: reader.readLong(offsets[9]),
    owner: reader.readString(offsets[10]),
  );
  return object;
}

P _unprocessedSongDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader
              .readByteList(offset)
              ?.map(
                  (e) => _UnprocessedSonggenresValueEnumMap[e] ?? Genre.hipHop)
              .toList() ??
          []) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UnprocessedSonggenresEnumValueMap = {
  'hipHop': 0,
  'pop': 1,
  'folk': 2,
  'experimental': 3,
  'rock': 4,
  'international': 5,
  'electronic': 6,
  'instrumental': 7,
};
const _UnprocessedSonggenresValueEnumMap = {
  0: Genre.hipHop,
  1: Genre.pop,
  2: Genre.folk,
  3: Genre.experimental,
  4: Genre.rock,
  5: Genre.international,
  6: Genre.electronic,
  7: Genre.instrumental,
};

Id _unprocessedSongGetId(UnprocessedSong object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _unprocessedSongGetLinks(UnprocessedSong object) {
  return [];
}

void _unprocessedSongAttach(
    IsarCollection<dynamic> col, Id id, UnprocessedSong object) {
  object.isarId = id;
}

extension UnprocessedSongByIndex on IsarCollection<UnprocessedSong> {
  Future<UnprocessedSong?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  UnprocessedSong? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<UnprocessedSong?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<UnprocessedSong?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(UnprocessedSong object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(UnprocessedSong object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<UnprocessedSong> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<UnprocessedSong> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension UnprocessedSongQueryWhereSort
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QWhere> {
  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UnprocessedSongQueryWhere
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QWhereClause> {
  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterWhereClause>
      isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterWhereClause> idEqualTo(
      String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterWhereClause>
      idNotEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UnprocessedSongQueryFilter
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QFilterCondition> {
  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      durationEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      durationGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      durationLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      durationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      explicitEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicit',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileExtension',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileExtension',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileExtension',
        value: '',
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileExtension',
        value: '',
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      genresElementEqualTo(Genre value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'genres',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      genresElementGreaterThan(
    Genre value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'genres',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      genresElementLessThan(
    Genre value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'genres',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      genresElementBetween(
    Genre lower,
    Genre upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'genres',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      genresLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'genres',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      genresIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'genres',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      genresIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'genres',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      genresLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'genres',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      genresLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'genres',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      genresLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'genres',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      imageFileExtensionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageFileExtension',
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      imageFileExtensionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageFileExtension',
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      imageFileExtensionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageFileExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      imageFileExtensionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageFileExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      imageFileExtensionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageFileExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      imageFileExtensionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageFileExtension',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      imageFileExtensionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageFileExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      imageFileExtensionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageFileExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      imageFileExtensionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageFileExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      imageFileExtensionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageFileExtension',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      imageFileExtensionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageFileExtension',
        value: '',
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      imageFileExtensionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageFileExtension',
        value: '',
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numParts',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numParts',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numParts',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numParts',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsReceivedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numPartsReceived',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsReceivedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numPartsReceived',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsReceivedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numPartsReceived',
        value: value,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsReceivedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numPartsReceived',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'owner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'owner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'owner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'owner',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'owner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'owner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'owner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'owner',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'owner',
        value: '',
      ));
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'owner',
        value: '',
      ));
    });
  }
}

extension UnprocessedSongQueryObject
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QFilterCondition> {}

extension UnprocessedSongQueryLinks
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QFilterCondition> {}

extension UnprocessedSongQuerySortBy
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QSortBy> {
  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByExplicit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicit', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByExplicitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicit', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByFileExtension() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileExtension', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByFileExtensionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileExtension', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByImageFileExtension() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageFileExtension', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByImageFileExtensionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageFileExtension', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByNumParts() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numParts', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByNumPartsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numParts', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByNumPartsReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numPartsReceived', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByNumPartsReceivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numPartsReceived', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> sortByOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'owner', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'owner', Sort.desc);
    });
  }
}

extension UnprocessedSongQuerySortThenBy
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QSortThenBy> {
  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByExplicit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicit', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByExplicitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicit', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByFileExtension() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileExtension', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByFileExtensionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileExtension', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByImageFileExtension() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageFileExtension', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByImageFileExtensionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageFileExtension', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByNumParts() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numParts', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByNumPartsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numParts', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByNumPartsReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numPartsReceived', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByNumPartsReceivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numPartsReceived', Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> thenByOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'owner', Sort.asc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'owner', Sort.desc);
    });
  }
}

extension UnprocessedSongQueryWhereDistinct
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QDistinct> {
  QueryBuilder<UnprocessedSong, UnprocessedSong, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QDistinct>
      distinctByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duration');
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QDistinct>
      distinctByExplicit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicit');
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QDistinct>
      distinctByFileExtension({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileExtension',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QDistinct> distinctByGenres() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'genres');
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QDistinct>
      distinctByImageFileExtension({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageFileExtension',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QDistinct>
      distinctByNumParts() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numParts');
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QDistinct>
      distinctByNumPartsReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numPartsReceived');
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QDistinct> distinctByOwner(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'owner', caseSensitive: caseSensitive);
    });
  }
}

extension UnprocessedSongQueryProperty
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QQueryProperty> {
  QueryBuilder<UnprocessedSong, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<UnprocessedSong, String, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<UnprocessedSong, int, QQueryOperations> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duration');
    });
  }

  QueryBuilder<UnprocessedSong, bool, QQueryOperations> explicitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicit');
    });
  }

  QueryBuilder<UnprocessedSong, String, QQueryOperations>
      fileExtensionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileExtension');
    });
  }

  QueryBuilder<UnprocessedSong, List<Genre>, QQueryOperations>
      genresProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'genres');
    });
  }

  QueryBuilder<UnprocessedSong, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UnprocessedSong, String?, QQueryOperations>
      imageFileExtensionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageFileExtension');
    });
  }

  QueryBuilder<UnprocessedSong, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<UnprocessedSong, int, QQueryOperations> numPartsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numParts');
    });
  }

  QueryBuilder<UnprocessedSong, int, QQueryOperations>
      numPartsReceivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numPartsReceived');
    });
  }

  QueryBuilder<UnprocessedSong, String, QQueryOperations> ownerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'owner');
    });
  }
}
