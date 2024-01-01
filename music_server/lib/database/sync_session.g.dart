// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_session.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSyncSessionCollection on Isar {
  IsarCollection<SyncSession> get syncSessions => this.collection();
}

const SyncSessionSchema = CollectionSchema(
  name: r'SyncSession',
  id: 7491124393297850210,
  properties: {
    r'authorizedClients': PropertySchema(
      id: 0,
      name: r'authorizedClients',
      type: IsarType.stringList,
    ),
    r'port': PropertySchema(
      id: 1,
      name: r'port',
      type: IsarType.long,
    ),
    r'userId': PropertySchema(
      id: 2,
      name: r'userId',
      type: IsarType.string,
    ),
    r'workReceived': PropertySchema(
      id: 3,
      name: r'workReceived',
      type: IsarType.bool,
    )
  },
  estimateSize: _syncSessionEstimateSize,
  serialize: _syncSessionSerialize,
  deserialize: _syncSessionDeserialize,
  deserializeProp: _syncSessionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'workReceived': IndexSchema(
      id: -6356276783512050530,
      name: r'workReceived',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'workReceived',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _syncSessionGetId,
  getLinks: _syncSessionGetLinks,
  attach: _syncSessionAttach,
  version: '3.1.0+1',
);

int _syncSessionEstimateSize(
  SyncSession object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.authorizedClients.length * 3;
  {
    for (var i = 0; i < object.authorizedClients.length; i++) {
      final value = object.authorizedClients[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _syncSessionSerialize(
  SyncSession object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.authorizedClients);
  writer.writeLong(offsets[1], object.port);
  writer.writeString(offsets[2], object.userId);
  writer.writeBool(offsets[3], object.workReceived);
}

SyncSession _syncSessionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SyncSession(
    authorizedClients: reader.readStringList(offsets[0]) ?? [],
    isarId: id,
    port: reader.readLongOrNull(offsets[1]),
    userId: reader.readString(offsets[2]),
    workReceived: reader.readBoolOrNull(offsets[3]) ?? false,
  );
  return object;
}

P _syncSessionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _syncSessionGetId(SyncSession object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _syncSessionGetLinks(SyncSession object) {
  return [];
}

void _syncSessionAttach(
    IsarCollection<dynamic> col, Id id, SyncSession object) {
  object.isarId = id;
}

extension SyncSessionByIndex on IsarCollection<SyncSession> {
  Future<SyncSession?> getByUserId(String userId) {
    return getByIndex(r'userId', [userId]);
  }

  SyncSession? getByUserIdSync(String userId) {
    return getByIndexSync(r'userId', [userId]);
  }

  Future<bool> deleteByUserId(String userId) {
    return deleteByIndex(r'userId', [userId]);
  }

  bool deleteByUserIdSync(String userId) {
    return deleteByIndexSync(r'userId', [userId]);
  }

  Future<List<SyncSession?>> getAllByUserId(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'userId', values);
  }

  List<SyncSession?> getAllByUserIdSync(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'userId', values);
  }

  Future<int> deleteAllByUserId(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'userId', values);
  }

  int deleteAllByUserIdSync(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'userId', values);
  }

  Future<Id> putByUserId(SyncSession object) {
    return putByIndex(r'userId', object);
  }

  Id putByUserIdSync(SyncSession object, {bool saveLinks = true}) {
    return putByIndexSync(r'userId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserId(List<SyncSession> objects) {
    return putAllByIndex(r'userId', objects);
  }

  List<Id> putAllByUserIdSync(List<SyncSession> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'userId', objects, saveLinks: saveLinks);
  }
}

extension SyncSessionQueryWhereSort
    on QueryBuilder<SyncSession, SyncSession, QWhere> {
  QueryBuilder<SyncSession, SyncSession, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterWhere> anyWorkReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'workReceived'),
      );
    });
  }
}

extension SyncSessionQueryWhere
    on QueryBuilder<SyncSession, SyncSession, QWhereClause> {
  QueryBuilder<SyncSession, SyncSession, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
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

  QueryBuilder<SyncSession, SyncSession, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<SyncSession, SyncSession, QAfterWhereClause> userIdEqualTo(
      String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterWhereClause> userIdNotEqualTo(
      String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterWhereClause> workReceivedEqualTo(
      bool workReceived) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'workReceived',
        value: [workReceived],
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterWhereClause>
      workReceivedNotEqualTo(bool workReceived) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'workReceived',
              lower: [],
              upper: [workReceived],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'workReceived',
              lower: [workReceived],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'workReceived',
              lower: [workReceived],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'workReceived',
              lower: [],
              upper: [workReceived],
              includeUpper: false,
            ));
      }
    });
  }
}

extension SyncSessionQueryFilter
    on QueryBuilder<SyncSession, SyncSession, QFilterCondition> {
  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'authorizedClients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'authorizedClients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'authorizedClients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'authorizedClients',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'authorizedClients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'authorizedClients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'authorizedClients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'authorizedClients',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'authorizedClients',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'authorizedClients',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'authorizedClients',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'authorizedClients',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'authorizedClients',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'authorizedClients',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'authorizedClients',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      authorizedClientsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'authorizedClients',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
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

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition> portIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'port',
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      portIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'port',
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition> portEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition> portGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition> portLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition> portBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'port',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition> userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition> userIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterFilterCondition>
      workReceivedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workReceived',
        value: value,
      ));
    });
  }
}

extension SyncSessionQueryObject
    on QueryBuilder<SyncSession, SyncSession, QFilterCondition> {}

extension SyncSessionQueryLinks
    on QueryBuilder<SyncSession, SyncSession, QFilterCondition> {}

extension SyncSessionQuerySortBy
    on QueryBuilder<SyncSession, SyncSession, QSortBy> {
  QueryBuilder<SyncSession, SyncSession, QAfterSortBy> sortByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.asc);
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterSortBy> sortByPortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.desc);
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterSortBy> sortByWorkReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workReceived', Sort.asc);
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterSortBy>
      sortByWorkReceivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workReceived', Sort.desc);
    });
  }
}

extension SyncSessionQuerySortThenBy
    on QueryBuilder<SyncSession, SyncSession, QSortThenBy> {
  QueryBuilder<SyncSession, SyncSession, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterSortBy> thenByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.asc);
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterSortBy> thenByPortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.desc);
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterSortBy> thenByWorkReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workReceived', Sort.asc);
    });
  }

  QueryBuilder<SyncSession, SyncSession, QAfterSortBy>
      thenByWorkReceivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workReceived', Sort.desc);
    });
  }
}

extension SyncSessionQueryWhereDistinct
    on QueryBuilder<SyncSession, SyncSession, QDistinct> {
  QueryBuilder<SyncSession, SyncSession, QDistinct>
      distinctByAuthorizedClients() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'authorizedClients');
    });
  }

  QueryBuilder<SyncSession, SyncSession, QDistinct> distinctByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'port');
    });
  }

  QueryBuilder<SyncSession, SyncSession, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncSession, SyncSession, QDistinct> distinctByWorkReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workReceived');
    });
  }
}

extension SyncSessionQueryProperty
    on QueryBuilder<SyncSession, SyncSession, QQueryProperty> {
  QueryBuilder<SyncSession, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<SyncSession, List<String>, QQueryOperations>
      authorizedClientsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'authorizedClients');
    });
  }

  QueryBuilder<SyncSession, int?, QQueryOperations> portProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'port');
    });
  }

  QueryBuilder<SyncSession, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<SyncSession, bool, QQueryOperations> workReceivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workReceived');
    });
  }
}
