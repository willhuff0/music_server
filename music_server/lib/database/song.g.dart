// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSongCollection on Isar {
  IsarCollection<Song> get songs => this.collection();
}

const SongSchema = CollectionSchema(
  name: r'Song',
  id: -5548886644249537934,
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
    r'genres': PropertySchema(
      id: 3,
      name: r'genres',
      type: IsarType.byteList,
      enumMap: _SonggenresEnumValueMap,
    ),
    r'id': PropertySchema(
      id: 4,
      name: r'id',
      type: IsarType.string,
    ),
    r'lastPopularityCheck': PropertySchema(
      id: 5,
      name: r'lastPopularityCheck',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'namePhonetics': PropertySchema(
      id: 7,
      name: r'namePhonetics',
      type: IsarType.stringList,
    ),
    r'numPlays': PropertySchema(
      id: 8,
      name: r'numPlays',
      type: IsarType.long,
    ),
    r'owner': PropertySchema(
      id: 9,
      name: r'owner',
      type: IsarType.string,
    ),
    r'popularity': PropertySchema(
      id: 10,
      name: r'popularity',
      type: IsarType.double,
    ),
    r'timestamp': PropertySchema(
      id: 11,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _songEstimateSize,
  serialize: _songSerialize,
  deserialize: _songDeserialize,
  deserializeProp: _songDeserializeProp,
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
    ),
    r'owner': IndexSchema(
      id: 937942649497171216,
      name: r'owner',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'owner',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'genres': IndexSchema(
      id: 7272600453950102276,
      name: r'genres',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'genres',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'popularity': IndexSchema(
      id: -817613675826504681,
      name: r'popularity',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'popularity',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'namePhonetics': IndexSchema(
      id: -8167915883527909840,
      name: r'namePhonetics',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'namePhonetics',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'ownerUser': LinkSchema(
      id: -5287764460853307307,
      name: r'ownerUser',
      target: r'User',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _songGetId,
  getLinks: _songGetLinks,
  attach: _songAttach,
  version: '3.1.0+1',
);

int _songEstimateSize(
  Song object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.genres.length;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.namePhonetics.length * 3;
  {
    for (var i = 0; i < object.namePhonetics.length; i++) {
      final value = object.namePhonetics[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.owner.length * 3;
  return bytesCount;
}

void _songSerialize(
  Song object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeLong(offsets[1], object.duration);
  writer.writeBool(offsets[2], object.explicit);
  writer.writeByteList(offsets[3], object.genres.map((e) => e.index).toList());
  writer.writeString(offsets[4], object.id);
  writer.writeDateTime(offsets[5], object.lastPopularityCheck);
  writer.writeString(offsets[6], object.name);
  writer.writeStringList(offsets[7], object.namePhonetics);
  writer.writeLong(offsets[8], object.numPlays);
  writer.writeString(offsets[9], object.owner);
  writer.writeDouble(offsets[10], object.popularity);
  writer.writeDateTime(offsets[11], object.timestamp);
}

Song _songDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Song(
    description: reader.readString(offsets[0]),
    duration: reader.readLong(offsets[1]),
    explicit: reader.readBool(offsets[2]),
    genres: reader
            .readByteList(offsets[3])
            ?.map((e) => _SonggenresValueEnumMap[e] ?? Genre.hipHop)
            .toList() ??
        [],
    id: reader.readString(offsets[4]),
    isarId: id,
    lastPopularityCheck: reader.readDateTime(offsets[5]),
    name: reader.readString(offsets[6]),
    namePhonetics: reader.readStringList(offsets[7]) ?? [],
    numPlays: reader.readLong(offsets[8]),
    owner: reader.readString(offsets[9]),
    popularity: reader.readDouble(offsets[10]),
    timestamp: reader.readDateTime(offsets[11]),
  );
  return object;
}

P _songDeserializeProp<P>(
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
      return (reader
              .readByteList(offset)
              ?.map((e) => _SonggenresValueEnumMap[e] ?? Genre.hipHop)
              .toList() ??
          []) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringList(offset) ?? []) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _SonggenresEnumValueMap = {
  'hipHop': 0,
  'pop': 1,
  'folk': 2,
  'experimental': 3,
  'rock': 4,
  'international': 5,
  'electronic': 6,
  'instrumental': 7,
};
const _SonggenresValueEnumMap = {
  0: Genre.hipHop,
  1: Genre.pop,
  2: Genre.folk,
  3: Genre.experimental,
  4: Genre.rock,
  5: Genre.international,
  6: Genre.electronic,
  7: Genre.instrumental,
};

Id _songGetId(Song object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _songGetLinks(Song object) {
  return [object.ownerUser];
}

void _songAttach(IsarCollection<dynamic> col, Id id, Song object) {
  object.isarId = id;
  object.ownerUser.attach(col, col.isar.collection<User>(), r'ownerUser', id);
}

extension SongByIndex on IsarCollection<Song> {
  Future<Song?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  Song? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<Song?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<Song?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(Song object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(Song object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<Song> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<Song> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension SongQueryWhereSort on QueryBuilder<Song, Song, QWhere> {
  QueryBuilder<Song, Song, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Song, Song, QAfterWhere> anyGenresElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'genres'),
      );
    });
  }

  QueryBuilder<Song, Song, QAfterWhere> anyPopularity() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'popularity'),
      );
    });
  }

  QueryBuilder<Song, Song, QAfterWhere> anyNamePhoneticsElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'namePhonetics'),
      );
    });
  }
}

extension SongQueryWhere on QueryBuilder<Song, Song, QWhereClause> {
  QueryBuilder<Song, Song, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> isarIdNotEqualTo(Id isarId) {
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

  QueryBuilder<Song, Song, QAfterWhereClause> isarIdGreaterThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<Song, Song, QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<Song, Song, QAfterWhereClause> ownerEqualTo(String owner) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'owner',
        value: [owner],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> ownerNotEqualTo(String owner) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'owner',
              lower: [],
              upper: [owner],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'owner',
              lower: [owner],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'owner',
              lower: [owner],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'owner',
              lower: [],
              upper: [owner],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> genresElementEqualTo(
      Genre genresElement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'genres',
        value: [genresElement],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> genresElementNotEqualTo(
      Genre genresElement) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'genres',
              lower: [],
              upper: [genresElement],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'genres',
              lower: [genresElement],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'genres',
              lower: [genresElement],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'genres',
              lower: [],
              upper: [genresElement],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> genresElementGreaterThan(
    Genre genresElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'genres',
        lower: [genresElement],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> genresElementLessThan(
    Genre genresElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'genres',
        lower: [],
        upper: [genresElement],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> genresElementBetween(
    Genre lowerGenresElement,
    Genre upperGenresElement, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'genres',
        lower: [lowerGenresElement],
        includeLower: includeLower,
        upper: [upperGenresElement],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> popularityEqualTo(
      double popularity) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'popularity',
        value: [popularity],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> popularityNotEqualTo(
      double popularity) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'popularity',
              lower: [],
              upper: [popularity],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'popularity',
              lower: [popularity],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'popularity',
              lower: [popularity],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'popularity',
              lower: [],
              upper: [popularity],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> popularityGreaterThan(
    double popularity, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'popularity',
        lower: [popularity],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> popularityLessThan(
    double popularity, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'popularity',
        lower: [],
        upper: [popularity],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> popularityBetween(
    double lowerPopularity,
    double upperPopularity, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'popularity',
        lower: [lowerPopularity],
        includeLower: includeLower,
        upper: [upperPopularity],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> namePhoneticsElementEqualTo(
      String namePhoneticsElement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'namePhonetics',
        value: [namePhoneticsElement],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> namePhoneticsElementNotEqualTo(
      String namePhoneticsElement) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'namePhonetics',
              lower: [],
              upper: [namePhoneticsElement],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'namePhonetics',
              lower: [namePhoneticsElement],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'namePhonetics',
              lower: [namePhoneticsElement],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'namePhonetics',
              lower: [],
              upper: [namePhoneticsElement],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> namePhoneticsElementGreaterThan(
    String namePhoneticsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'namePhonetics',
        lower: [namePhoneticsElement],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> namePhoneticsElementLessThan(
    String namePhoneticsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'namePhonetics',
        lower: [],
        upper: [namePhoneticsElement],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> namePhoneticsElementBetween(
    String lowerNamePhoneticsElement,
    String upperNamePhoneticsElement, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'namePhonetics',
        lower: [lowerNamePhoneticsElement],
        includeLower: includeLower,
        upper: [upperNamePhoneticsElement],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> namePhoneticsElementStartsWith(
      String NamePhoneticsElementPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'namePhonetics',
        lower: [NamePhoneticsElementPrefix],
        upper: ['$NamePhoneticsElementPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> namePhoneticsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'namePhonetics',
        value: [''],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> namePhoneticsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'namePhonetics',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'namePhonetics',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'namePhonetics',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'namePhonetics',
              upper: [''],
            ));
      }
    });
  }
}

extension SongQueryFilter on QueryBuilder<Song, Song, QFilterCondition> {
  QueryBuilder<Song, Song, QAfterFilterCondition> descriptionEqualTo(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> descriptionGreaterThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> descriptionLessThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> descriptionBetween(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> descriptionStartsWith(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> descriptionEndsWith(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> durationEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> durationGreaterThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> durationLessThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> durationBetween(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> explicitEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explicit',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> genresElementEqualTo(
      Genre value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'genres',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> genresElementGreaterThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> genresElementLessThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> genresElementBetween(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> genresLengthEqualTo(
      int length) {
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

  QueryBuilder<Song, Song, QAfterFilterCondition> genresIsEmpty() {
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

  QueryBuilder<Song, Song, QAfterFilterCondition> genresIsNotEmpty() {
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

  QueryBuilder<Song, Song, QAfterFilterCondition> genresLengthLessThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> genresLengthGreaterThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> genresLengthBetween(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> lastPopularityCheckEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPopularityCheck',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition>
      lastPopularityCheckGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastPopularityCheck',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lastPopularityCheckLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastPopularityCheck',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lastPopularityCheckBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastPopularityCheck',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> namePhoneticsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'namePhonetics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition>
      namePhoneticsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'namePhonetics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> namePhoneticsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'namePhonetics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> namePhoneticsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'namePhonetics',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition>
      namePhoneticsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'namePhonetics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> namePhoneticsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'namePhonetics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> namePhoneticsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'namePhonetics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> namePhoneticsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'namePhonetics',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition>
      namePhoneticsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'namePhonetics',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition>
      namePhoneticsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'namePhonetics',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> namePhoneticsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'namePhonetics',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> namePhoneticsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'namePhonetics',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> namePhoneticsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'namePhonetics',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> namePhoneticsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'namePhonetics',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition>
      namePhoneticsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'namePhonetics',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> namePhoneticsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'namePhonetics',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> numPlaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numPlays',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> numPlaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numPlays',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> numPlaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numPlays',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> numPlaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numPlays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> ownerEqualTo(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> ownerGreaterThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> ownerLessThan(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> ownerBetween(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> ownerStartsWith(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> ownerEndsWith(
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

  QueryBuilder<Song, Song, QAfterFilterCondition> ownerContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'owner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> ownerMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'owner',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> ownerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'owner',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> ownerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'owner',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> popularityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'popularity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> popularityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'popularity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> popularityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'popularity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> popularityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'popularity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> timestampEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SongQueryObject on QueryBuilder<Song, Song, QFilterCondition> {}

extension SongQueryLinks on QueryBuilder<Song, Song, QFilterCondition> {
  QueryBuilder<Song, Song, QAfterFilterCondition> ownerUser(
      FilterQuery<User> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'ownerUser');
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> ownerUserIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ownerUser', 0, true, 0, true);
    });
  }
}

extension SongQuerySortBy on QueryBuilder<Song, Song, QSortBy> {
  QueryBuilder<Song, Song, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByExplicit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicit', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByExplicitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicit', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByLastPopularityCheck() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPopularityCheck', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByLastPopularityCheckDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPopularityCheck', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByNumPlays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numPlays', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByNumPlaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numPlays', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'owner', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'owner', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByPopularity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popularity', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByPopularityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popularity', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension SongQuerySortThenBy on QueryBuilder<Song, Song, QSortThenBy> {
  QueryBuilder<Song, Song, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByExplicit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicit', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByExplicitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explicit', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByLastPopularityCheck() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPopularityCheck', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByLastPopularityCheckDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPopularityCheck', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByNumPlays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numPlays', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByNumPlaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numPlays', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'owner', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'owner', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByPopularity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popularity', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByPopularityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popularity', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension SongQueryWhereDistinct on QueryBuilder<Song, Song, QDistinct> {
  QueryBuilder<Song, Song, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duration');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByExplicit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explicit');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByGenres() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'genres');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByLastPopularityCheck() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastPopularityCheck');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByNamePhonetics() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'namePhonetics');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByNumPlays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numPlays');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByOwner(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'owner', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByPopularity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'popularity');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension SongQueryProperty on QueryBuilder<Song, Song, QQueryProperty> {
  QueryBuilder<Song, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<Song, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Song, int, QQueryOperations> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duration');
    });
  }

  QueryBuilder<Song, bool, QQueryOperations> explicitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explicit');
    });
  }

  QueryBuilder<Song, List<Genre>, QQueryOperations> genresProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'genres');
    });
  }

  QueryBuilder<Song, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Song, DateTime, QQueryOperations> lastPopularityCheckProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastPopularityCheck');
    });
  }

  QueryBuilder<Song, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Song, List<String>, QQueryOperations> namePhoneticsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'namePhonetics');
    });
  }

  QueryBuilder<Song, int, QQueryOperations> numPlaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numPlays');
    });
  }

  QueryBuilder<Song, String, QQueryOperations> ownerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'owner');
    });
  }

  QueryBuilder<Song, double, QQueryOperations> popularityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'popularity');
    });
  }

  QueryBuilder<Song, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}
