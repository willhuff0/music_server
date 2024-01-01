// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserCollection on Isar {
  IsarCollection<User> get users => this.collection();
}

const UserSchema = CollectionSchema(
  name: r'User',
  id: -7838171048429979076,
  properties: {
    r'email': PropertySchema(
      id: 0,
      name: r'email',
      type: IsarType.string,
    ),
    r'favors': PropertySchema(
      id: 1,
      name: r'favors',
      type: IsarType.objectList,
      target: r'GenreFavor',
    ),
    r'id': PropertySchema(
      id: 2,
      name: r'id',
      type: IsarType.string,
    ),
    r'lastFavorCheck': PropertySchema(
      id: 3,
      name: r'lastFavorCheck',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'namePhonetics': PropertySchema(
      id: 5,
      name: r'namePhonetics',
      type: IsarType.stringList,
    ),
    r'password': PropertySchema(
      id: 6,
      name: r'password',
      type: IsarType.object,
      target: r'HashedUserPassword',
    ),
    r'tier': PropertySchema(
      id: 7,
      name: r'tier',
      type: IsarType.byte,
      enumMap: _UsertierEnumValueMap,
    )
  },
  estimateSize: _userEstimateSize,
  serialize: _userSerialize,
  deserialize: _userDeserialize,
  deserializeProp: _userDeserializeProp,
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
    r'email': IndexSchema(
      id: -26095440403582047,
      name: r'email',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'email',
          type: IndexType.hash,
          caseSensitive: true,
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
  links: {},
  embeddedSchemas: {
    r'HashedUserPassword': HashedUserPasswordSchema,
    r'GenreFavor': GenreFavorSchema
  },
  getId: _userGetId,
  getLinks: _userGetLinks,
  attach: _userAttach,
  version: '3.1.0+1',
);

int _userEstimateSize(
  User object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.email.length * 3;
  bytesCount += 3 + object.favors.length * 3;
  {
    final offsets = allOffsets[GenreFavor]!;
    for (var i = 0; i < object.favors.length; i++) {
      final value = object.favors[i];
      bytesCount += GenreFavorSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.namePhonetics.length * 3;
  {
    for (var i = 0; i < object.namePhonetics.length; i++) {
      final value = object.namePhonetics[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 +
      HashedUserPasswordSchema.estimateSize(
          object.password, allOffsets[HashedUserPassword]!, allOffsets);
  return bytesCount;
}

void _userSerialize(
  User object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.email);
  writer.writeObjectList<GenreFavor>(
    offsets[1],
    allOffsets,
    GenreFavorSchema.serialize,
    object.favors,
  );
  writer.writeString(offsets[2], object.id);
  writer.writeDateTime(offsets[3], object.lastFavorCheck);
  writer.writeString(offsets[4], object.name);
  writer.writeStringList(offsets[5], object.namePhonetics);
  writer.writeObject<HashedUserPassword>(
    offsets[6],
    allOffsets,
    HashedUserPasswordSchema.serialize,
    object.password,
  );
  writer.writeByte(offsets[7], object.tier.index);
}

User _userDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = User(
    email: reader.readString(offsets[0]),
    favors: reader.readObjectList<GenreFavor>(
          offsets[1],
          GenreFavorSchema.deserialize,
          allOffsets,
          GenreFavor(),
        ) ??
        [],
    id: reader.readString(offsets[2]),
    isarId: id,
    lastFavorCheck: reader.readDateTime(offsets[3]),
    name: reader.readString(offsets[4]),
    namePhonetics: reader.readStringList(offsets[5]) ?? [],
    password: reader.readObjectOrNull<HashedUserPassword>(
          offsets[6],
          HashedUserPasswordSchema.deserialize,
          allOffsets,
        ) ??
        HashedUserPassword(),
    tier: _UsertierValueEnumMap[reader.readByteOrNull(offsets[7])] ??
        UserTier.free,
  );
  return object;
}

P _userDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectList<GenreFavor>(
            offset,
            GenreFavorSchema.deserialize,
            allOffsets,
            GenreFavor(),
          ) ??
          []) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readObjectOrNull<HashedUserPassword>(
            offset,
            HashedUserPasswordSchema.deserialize,
            allOffsets,
          ) ??
          HashedUserPassword()) as P;
    case 7:
      return (_UsertierValueEnumMap[reader.readByteOrNull(offset)] ??
          UserTier.free) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UsertierEnumValueMap = {
  'free': 0,
  'paid': 1,
};
const _UsertierValueEnumMap = {
  0: UserTier.free,
  1: UserTier.paid,
};

Id _userGetId(User object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _userGetLinks(User object) {
  return [];
}

void _userAttach(IsarCollection<dynamic> col, Id id, User object) {
  object.isarId = id;
}

extension UserByIndex on IsarCollection<User> {
  Future<User?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  User? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<User?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<User?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(User object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(User object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<User> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<User> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }

  Future<User?> getByEmail(String email) {
    return getByIndex(r'email', [email]);
  }

  User? getByEmailSync(String email) {
    return getByIndexSync(r'email', [email]);
  }

  Future<bool> deleteByEmail(String email) {
    return deleteByIndex(r'email', [email]);
  }

  bool deleteByEmailSync(String email) {
    return deleteByIndexSync(r'email', [email]);
  }

  Future<List<User?>> getAllByEmail(List<String> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return getAllByIndex(r'email', values);
  }

  List<User?> getAllByEmailSync(List<String> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'email', values);
  }

  Future<int> deleteAllByEmail(List<String> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'email', values);
  }

  int deleteAllByEmailSync(List<String> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'email', values);
  }

  Future<Id> putByEmail(User object) {
    return putByIndex(r'email', object);
  }

  Id putByEmailSync(User object, {bool saveLinks = true}) {
    return putByIndexSync(r'email', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByEmail(List<User> objects) {
    return putAllByIndex(r'email', objects);
  }

  List<Id> putAllByEmailSync(List<User> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'email', objects, saveLinks: saveLinks);
  }
}

extension UserQueryWhereSort on QueryBuilder<User, User, QWhere> {
  QueryBuilder<User, User, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<User, User, QAfterWhere> anyNamePhoneticsElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'namePhonetics'),
      );
    });
  }
}

extension UserQueryWhere on QueryBuilder<User, User, QWhereClause> {
  QueryBuilder<User, User, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<User, User, QAfterWhereClause> isarIdNotEqualTo(Id isarId) {
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

  QueryBuilder<User, User, QAfterWhereClause> isarIdGreaterThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<User, User, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<User, User, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<User, User, QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<User, User, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<User, User, QAfterWhereClause> emailEqualTo(String email) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'email',
        value: [email],
      ));
    });
  }

  QueryBuilder<User, User, QAfterWhereClause> emailNotEqualTo(String email) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'email',
              lower: [],
              upper: [email],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'email',
              lower: [email],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'email',
              lower: [email],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'email',
              lower: [],
              upper: [email],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<User, User, QAfterWhereClause> namePhoneticsElementEqualTo(
      String namePhoneticsElement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'namePhonetics',
        value: [namePhoneticsElement],
      ));
    });
  }

  QueryBuilder<User, User, QAfterWhereClause> namePhoneticsElementNotEqualTo(
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

  QueryBuilder<User, User, QAfterWhereClause> namePhoneticsElementGreaterThan(
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

  QueryBuilder<User, User, QAfterWhereClause> namePhoneticsElementLessThan(
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

  QueryBuilder<User, User, QAfterWhereClause> namePhoneticsElementBetween(
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

  QueryBuilder<User, User, QAfterWhereClause> namePhoneticsElementStartsWith(
      String NamePhoneticsElementPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'namePhonetics',
        lower: [NamePhoneticsElementPrefix],
        upper: ['$NamePhoneticsElementPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<User, User, QAfterWhereClause> namePhoneticsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'namePhonetics',
        value: [''],
      ));
    });
  }

  QueryBuilder<User, User, QAfterWhereClause> namePhoneticsElementIsNotEmpty() {
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

extension UserQueryFilter on QueryBuilder<User, User, QFilterCondition> {
  QueryBuilder<User, User, QAfterFilterCondition> emailEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> favorsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'favors',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> favorsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'favors',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> favorsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'favors',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> favorsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'favors',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> favorsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'favors',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> favorsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'favors',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> idBetween(
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

  QueryBuilder<User, User, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<User, User, QAfterFilterCondition> lastFavorCheckEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastFavorCheck',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> lastFavorCheckGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastFavorCheck',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> lastFavorCheckLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastFavorCheck',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> lastFavorCheckBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastFavorCheck',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<User, User, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> namePhoneticsElementEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition>
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

  QueryBuilder<User, User, QAfterFilterCondition> namePhoneticsElementLessThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> namePhoneticsElementBetween(
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

  QueryBuilder<User, User, QAfterFilterCondition>
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

  QueryBuilder<User, User, QAfterFilterCondition> namePhoneticsElementEndsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> namePhoneticsElementContains(
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

  QueryBuilder<User, User, QAfterFilterCondition> namePhoneticsElementMatches(
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

  QueryBuilder<User, User, QAfterFilterCondition>
      namePhoneticsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'namePhonetics',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition>
      namePhoneticsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'namePhonetics',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> namePhoneticsLengthEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> namePhoneticsIsEmpty() {
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

  QueryBuilder<User, User, QAfterFilterCondition> namePhoneticsIsNotEmpty() {
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

  QueryBuilder<User, User, QAfterFilterCondition> namePhoneticsLengthLessThan(
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

  QueryBuilder<User, User, QAfterFilterCondition>
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

  QueryBuilder<User, User, QAfterFilterCondition> namePhoneticsLengthBetween(
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

  QueryBuilder<User, User, QAfterFilterCondition> tierEqualTo(UserTier value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tier',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> tierGreaterThan(
    UserTier value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tier',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> tierLessThan(
    UserTier value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tier',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> tierBetween(
    UserTier lower,
    UserTier upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserQueryObject on QueryBuilder<User, User, QFilterCondition> {
  QueryBuilder<User, User, QAfterFilterCondition> favorsElement(
      FilterQuery<GenreFavor> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'favors');
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> password(
      FilterQuery<HashedUserPassword> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'password');
    });
  }
}

extension UserQueryLinks on QueryBuilder<User, User, QFilterCondition> {}

extension UserQuerySortBy on QueryBuilder<User, User, QSortBy> {
  QueryBuilder<User, User, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByLastFavorCheck() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFavorCheck', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByLastFavorCheckDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFavorCheck', Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByTier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tier', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByTierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tier', Sort.desc);
    });
  }
}

extension UserQuerySortThenBy on QueryBuilder<User, User, QSortThenBy> {
  QueryBuilder<User, User, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByLastFavorCheck() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFavorCheck', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByLastFavorCheckDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFavorCheck', Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByTier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tier', Sort.asc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByTierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tier', Sort.desc);
    });
  }
}

extension UserQueryWhereDistinct on QueryBuilder<User, User, QDistinct> {
  QueryBuilder<User, User, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QDistinct> distinctByLastFavorCheck() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastFavorCheck');
    });
  }

  QueryBuilder<User, User, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QDistinct> distinctByNamePhonetics() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'namePhonetics');
    });
  }

  QueryBuilder<User, User, QDistinct> distinctByTier() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tier');
    });
  }
}

extension UserQueryProperty on QueryBuilder<User, User, QQueryProperty> {
  QueryBuilder<User, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<User, String, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<User, List<GenreFavor>, QQueryOperations> favorsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'favors');
    });
  }

  QueryBuilder<User, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<User, DateTime, QQueryOperations> lastFavorCheckProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastFavorCheck');
    });
  }

  QueryBuilder<User, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<User, List<String>, QQueryOperations> namePhoneticsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'namePhonetics');
    });
  }

  QueryBuilder<User, HashedUserPassword, QQueryOperations> passwordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'password');
    });
  }

  QueryBuilder<User, UserTier, QQueryOperations> tierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tier');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const HashedUserPasswordSchema = Schema(
  name: r'HashedUserPassword',
  id: -8666419981354275597,
  properties: {
    r'hash': PropertySchema(
      id: 0,
      name: r'hash',
      type: IsarType.byteList,
    ),
    r'nonce': PropertySchema(
      id: 1,
      name: r'nonce',
      type: IsarType.byteList,
    )
  },
  estimateSize: _hashedUserPasswordEstimateSize,
  serialize: _hashedUserPasswordSerialize,
  deserialize: _hashedUserPasswordDeserialize,
  deserializeProp: _hashedUserPasswordDeserializeProp,
);

int _hashedUserPasswordEstimateSize(
  HashedUserPassword object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.hash.length;
  bytesCount += 3 + object.nonce.length;
  return bytesCount;
}

void _hashedUserPasswordSerialize(
  HashedUserPassword object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByteList(offsets[0], object.hash);
  writer.writeByteList(offsets[1], object.nonce);
}

HashedUserPassword _hashedUserPasswordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HashedUserPassword(
    hash: reader.readByteList(offsets[0]) ?? const [],
    nonce: reader.readByteList(offsets[1]) ?? const [],
  );
  return object;
}

P _hashedUserPasswordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readByteList(offset) ?? const []) as P;
    case 1:
      return (reader.readByteList(offset) ?? const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension HashedUserPasswordQueryFilter
    on QueryBuilder<HashedUserPassword, HashedUserPassword, QFilterCondition> {
  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      hashElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hash',
        value: value,
      ));
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      hashElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hash',
        value: value,
      ));
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      hashElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hash',
        value: value,
      ));
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      hashElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      hashLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hash',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      hashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hash',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      hashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hash',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      hashLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hash',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      hashLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hash',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      hashLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hash',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      nonceElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nonce',
        value: value,
      ));
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      nonceElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nonce',
        value: value,
      ));
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      nonceElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nonce',
        value: value,
      ));
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      nonceElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nonce',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      nonceLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nonce',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      nonceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nonce',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      nonceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nonce',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      nonceLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nonce',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      nonceLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nonce',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition>
      nonceLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nonce',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension HashedUserPasswordQueryObject
    on QueryBuilder<HashedUserPassword, HashedUserPassword, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const GenreFavorSchema = Schema(
  name: r'GenreFavor',
  id: -5397101336953831459,
  properties: {
    r'favor': PropertySchema(
      id: 0,
      name: r'favor',
      type: IsarType.double,
    ),
    r'genre': PropertySchema(
      id: 1,
      name: r'genre',
      type: IsarType.byte,
      enumMap: _GenreFavorgenreEnumValueMap,
    ),
    r'hashCode': PropertySchema(
      id: 2,
      name: r'hashCode',
      type: IsarType.long,
    )
  },
  estimateSize: _genreFavorEstimateSize,
  serialize: _genreFavorSerialize,
  deserialize: _genreFavorDeserialize,
  deserializeProp: _genreFavorDeserializeProp,
);

int _genreFavorEstimateSize(
  GenreFavor object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _genreFavorSerialize(
  GenreFavor object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.favor);
  writer.writeByte(offsets[1], object.genre.index);
  writer.writeLong(offsets[2], object.hashCode);
}

GenreFavor _genreFavorDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GenreFavor(
    favor: reader.readDoubleOrNull(offsets[0]) ?? 1.0,
    genre: _GenreFavorgenreValueEnumMap[reader.readByteOrNull(offsets[1])] ??
        Genre.pop,
  );
  return object;
}

P _genreFavorDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset) ?? 1.0) as P;
    case 1:
      return (_GenreFavorgenreValueEnumMap[reader.readByteOrNull(offset)] ??
          Genre.pop) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _GenreFavorgenreEnumValueMap = {
  'hipHop': 0,
  'pop': 1,
  'folk': 2,
  'experimental': 3,
  'rock': 4,
  'international': 5,
  'electronic': 6,
  'instrumental': 7,
};
const _GenreFavorgenreValueEnumMap = {
  0: Genre.hipHop,
  1: Genre.pop,
  2: Genre.folk,
  3: Genre.experimental,
  4: Genre.rock,
  5: Genre.international,
  6: Genre.electronic,
  7: Genre.instrumental,
};

extension GenreFavorQueryFilter
    on QueryBuilder<GenreFavor, GenreFavor, QFilterCondition> {
  QueryBuilder<GenreFavor, GenreFavor, QAfterFilterCondition> favorEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'favor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GenreFavor, GenreFavor, QAfterFilterCondition> favorGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'favor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GenreFavor, GenreFavor, QAfterFilterCondition> favorLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'favor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GenreFavor, GenreFavor, QAfterFilterCondition> favorBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'favor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GenreFavor, GenreFavor, QAfterFilterCondition> genreEqualTo(
      Genre value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'genre',
        value: value,
      ));
    });
  }

  QueryBuilder<GenreFavor, GenreFavor, QAfterFilterCondition> genreGreaterThan(
    Genre value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'genre',
        value: value,
      ));
    });
  }

  QueryBuilder<GenreFavor, GenreFavor, QAfterFilterCondition> genreLessThan(
    Genre value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'genre',
        value: value,
      ));
    });
  }

  QueryBuilder<GenreFavor, GenreFavor, QAfterFilterCondition> genreBetween(
    Genre lower,
    Genre upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'genre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GenreFavor, GenreFavor, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<GenreFavor, GenreFavor, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<GenreFavor, GenreFavor, QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<GenreFavor, GenreFavor, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GenreFavorQueryObject
    on QueryBuilder<GenreFavor, GenreFavor, QFilterCondition> {}
