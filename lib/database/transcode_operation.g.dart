// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcode_operation.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTranscodeOperationCollection on Isar {
  IsarCollection<TranscodeOperation> get transcodeOperations =>
      this.collection();
}

const TranscodeOperationSchema = CollectionSchema(
  name: r'TranscodeOperation',
  id: 7716398672627590605,
  properties: {
    r'failed': PropertySchema(
      id: 0,
      name: r'failed',
      type: IsarType.bool,
    ),
    r'failureMessage': PropertySchema(
      id: 1,
      name: r'failureMessage',
      type: IsarType.string,
    ),
    r'songId': PropertySchema(
      id: 2,
      name: r'songId',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 3,
      name: r'timestamp',
      type: IsarType.long,
    ),
    r'workReceivedToken': PropertySchema(
      id: 4,
      name: r'workReceivedToken',
      type: IsarType.string,
    )
  },
  estimateSize: _transcodeOperationEstimateSize,
  serialize: _transcodeOperationSerialize,
  deserialize: _transcodeOperationDeserialize,
  deserializeProp: _transcodeOperationDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'failed_timestamp': IndexSchema(
      id: -5132437931030169147,
      name: r'failed_timestamp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'failed',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'timestamp',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _transcodeOperationGetId,
  getLinks: _transcodeOperationGetLinks,
  attach: _transcodeOperationAttach,
  version: '3.1.0+1',
);

int _transcodeOperationEstimateSize(
  TranscodeOperation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.failureMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.songId.length * 3;
  {
    final value = object.workReceivedToken;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _transcodeOperationSerialize(
  TranscodeOperation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.failed);
  writer.writeString(offsets[1], object.failureMessage);
  writer.writeString(offsets[2], object.songId);
  writer.writeLong(offsets[3], object.timestamp);
  writer.writeString(offsets[4], object.workReceivedToken);
}

TranscodeOperation _transcodeOperationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TranscodeOperation(
    failed: reader.readBoolOrNull(offsets[0]) ?? false,
    failureMessage: reader.readStringOrNull(offsets[1]),
    isarId: id,
    songId: reader.readString(offsets[2]),
    timestamp: reader.readLong(offsets[3]),
    workReceivedToken: reader.readStringOrNull(offsets[4]),
  );
  return object;
}

P _transcodeOperationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _transcodeOperationGetId(TranscodeOperation object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _transcodeOperationGetLinks(
    TranscodeOperation object) {
  return [];
}

void _transcodeOperationAttach(
    IsarCollection<dynamic> col, Id id, TranscodeOperation object) {
  object.isarId = id;
}

extension TranscodeOperationQueryWhereSort
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QWhere> {
  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterWhere>
      anyFailedTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'failed_timestamp'),
      );
    });
  }
}

extension TranscodeOperationQueryWhere
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QWhereClause> {
  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterWhereClause>
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

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterWhereClause>
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

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterWhereClause>
      failedEqualToAnyTimestamp(bool failed) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'failed_timestamp',
        value: [failed],
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterWhereClause>
      failedNotEqualToAnyTimestamp(bool failed) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'failed_timestamp',
              lower: [],
              upper: [failed],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'failed_timestamp',
              lower: [failed],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'failed_timestamp',
              lower: [failed],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'failed_timestamp',
              lower: [],
              upper: [failed],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterWhereClause>
      failedTimestampEqualTo(bool failed, int timestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'failed_timestamp',
        value: [failed, timestamp],
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterWhereClause>
      failedEqualToTimestampNotEqualTo(bool failed, int timestamp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'failed_timestamp',
              lower: [failed],
              upper: [failed, timestamp],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'failed_timestamp',
              lower: [failed, timestamp],
              includeLower: false,
              upper: [failed],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'failed_timestamp',
              lower: [failed, timestamp],
              includeLower: false,
              upper: [failed],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'failed_timestamp',
              lower: [failed],
              upper: [failed, timestamp],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterWhereClause>
      failedEqualToTimestampGreaterThan(
    bool failed,
    int timestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'failed_timestamp',
        lower: [failed, timestamp],
        includeLower: include,
        upper: [failed],
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterWhereClause>
      failedEqualToTimestampLessThan(
    bool failed,
    int timestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'failed_timestamp',
        lower: [failed],
        upper: [failed, timestamp],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterWhereClause>
      failedEqualToTimestampBetween(
    bool failed,
    int lowerTimestamp,
    int upperTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'failed_timestamp',
        lower: [failed, lowerTimestamp],
        includeLower: includeLower,
        upper: [failed, upperTimestamp],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TranscodeOperationQueryFilter
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QFilterCondition> {
  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'failed',
        value: value,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'failureMessage',
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'failureMessage',
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'failureMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'failureMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'failureMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'failureMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'failureMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'failureMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'failureMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'failureMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'failureMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'failureMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
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

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
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

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
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

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      songIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      songIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      songIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      songIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      songIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'songId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      songIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'songId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      songIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      songIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      songIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songId',
        value: '',
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      songIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songId',
        value: '',
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      timestampEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      timestampGreaterThan(
    int value, {
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

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      timestampLessThan(
    int value, {
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

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      timestampBetween(
    int lower,
    int upper, {
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

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'workReceivedToken',
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'workReceivedToken',
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workReceivedToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workReceivedToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workReceivedToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workReceivedToken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'workReceivedToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'workReceivedToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'workReceivedToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'workReceivedToken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workReceivedToken',
        value: '',
      ));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'workReceivedToken',
        value: '',
      ));
    });
  }
}

extension TranscodeOperationQueryObject
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QFilterCondition> {}

extension TranscodeOperationQueryLinks
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QFilterCondition> {}

extension TranscodeOperationQuerySortBy
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QSortBy> {
  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByFailed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failed', Sort.asc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByFailedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failed', Sort.desc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByFailureMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failureMessage', Sort.asc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByFailureMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failureMessage', Sort.desc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByWorkReceivedToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workReceivedToken', Sort.asc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByWorkReceivedTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workReceivedToken', Sort.desc);
    });
  }
}

extension TranscodeOperationQuerySortThenBy
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QSortThenBy> {
  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByFailed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failed', Sort.asc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByFailedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failed', Sort.desc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByFailureMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failureMessage', Sort.asc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByFailureMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failureMessage', Sort.desc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByWorkReceivedToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workReceivedToken', Sort.asc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByWorkReceivedTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workReceivedToken', Sort.desc);
    });
  }
}

extension TranscodeOperationQueryWhereDistinct
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QDistinct> {
  QueryBuilder<TranscodeOperation, TranscodeOperation, QDistinct>
      distinctByFailed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'failed');
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QDistinct>
      distinctByFailureMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'failureMessage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QDistinct>
      distinctBySongId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QDistinct>
      distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QDistinct>
      distinctByWorkReceivedToken({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workReceivedToken',
          caseSensitive: caseSensitive);
    });
  }
}

extension TranscodeOperationQueryProperty
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QQueryProperty> {
  QueryBuilder<TranscodeOperation, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<TranscodeOperation, bool, QQueryOperations> failedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'failed');
    });
  }

  QueryBuilder<TranscodeOperation, String?, QQueryOperations>
      failureMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'failureMessage');
    });
  }

  QueryBuilder<TranscodeOperation, String, QQueryOperations> songIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songId');
    });
  }

  QueryBuilder<TranscodeOperation, int, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<TranscodeOperation, String?, QQueryOperations>
      workReceivedTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workReceivedToken');
    });
  }
}
