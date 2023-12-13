// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcode_operation.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetTranscodeOperationCollection on Isar {
  IsarCollection<String, TranscodeOperation> get transcodeOperations =>
      this.collection();
}

const TranscodeOperationSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'TranscodeOperation',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'id',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'timestamp',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'workReceivedToken',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'failureMessage',
        type: IsarType.string,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, TranscodeOperation>(
    serialize: serializeTranscodeOperation,
    deserialize: deserializeTranscodeOperation,
    deserializeProperty: deserializeTranscodeOperationProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeTranscodeOperation(IsarWriter writer, TranscodeOperation object) {
  IsarCore.writeString(writer, 1, object.id);
  IsarCore.writeLong(
      writer, 2, object.timestamp.toUtc().microsecondsSinceEpoch);
  {
    final value = object.workReceivedToken;
    if (value == null) {
      IsarCore.writeNull(writer, 3);
    } else {
      IsarCore.writeString(writer, 3, value);
    }
  }
  {
    final value = object.failureMessage;
    if (value == null) {
      IsarCore.writeNull(writer, 4);
    } else {
      IsarCore.writeString(writer, 4, value);
    }
  }
  return Isar.fastHash(object.id);
}

@isarProtected
TranscodeOperation deserializeTranscodeOperation(IsarReader reader) {
  final String _id;
  _id = IsarCore.readString(reader, 1) ?? '';
  final DateTime _timestamp;
  {
    final value = IsarCore.readLong(reader, 2);
    if (value == -9223372036854775808) {
      _timestamp =
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
    } else {
      _timestamp = DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true);
    }
  }
  final String? _workReceivedToken;
  _workReceivedToken = IsarCore.readString(reader, 3);
  final String? _failureMessage;
  _failureMessage = IsarCore.readString(reader, 4);
  final object = TranscodeOperation(
    id: _id,
    timestamp: _timestamp,
    workReceivedToken: _workReceivedToken,
    failureMessage: _failureMessage,
  );
  return object;
}

@isarProtected
dynamic deserializeTranscodeOperationProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      {
        final value = IsarCore.readLong(reader, 2);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true);
        }
      }
    case 3:
      return IsarCore.readString(reader, 3);
    case 4:
      return IsarCore.readString(reader, 4);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _TranscodeOperationUpdate {
  bool call({
    required String id,
    DateTime? timestamp,
    String? workReceivedToken,
    String? failureMessage,
  });
}

class _TranscodeOperationUpdateImpl implements _TranscodeOperationUpdate {
  const _TranscodeOperationUpdateImpl(this.collection);

  final IsarCollection<String, TranscodeOperation> collection;

  @override
  bool call({
    required String id,
    Object? timestamp = ignore,
    Object? workReceivedToken = ignore,
    Object? failureMessage = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (timestamp != ignore) 2: timestamp as DateTime?,
          if (workReceivedToken != ignore) 3: workReceivedToken as String?,
          if (failureMessage != ignore) 4: failureMessage as String?,
        }) >
        0;
  }
}

sealed class _TranscodeOperationUpdateAll {
  int call({
    required List<String> id,
    DateTime? timestamp,
    String? workReceivedToken,
    String? failureMessage,
  });
}

class _TranscodeOperationUpdateAllImpl implements _TranscodeOperationUpdateAll {
  const _TranscodeOperationUpdateAllImpl(this.collection);

  final IsarCollection<String, TranscodeOperation> collection;

  @override
  int call({
    required List<String> id,
    Object? timestamp = ignore,
    Object? workReceivedToken = ignore,
    Object? failureMessage = ignore,
  }) {
    return collection.updateProperties(id, {
      if (timestamp != ignore) 2: timestamp as DateTime?,
      if (workReceivedToken != ignore) 3: workReceivedToken as String?,
      if (failureMessage != ignore) 4: failureMessage as String?,
    });
  }
}

extension TranscodeOperationUpdate
    on IsarCollection<String, TranscodeOperation> {
  _TranscodeOperationUpdate get update => _TranscodeOperationUpdateImpl(this);

  _TranscodeOperationUpdateAll get updateAll =>
      _TranscodeOperationUpdateAllImpl(this);
}

sealed class _TranscodeOperationQueryUpdate {
  int call({
    DateTime? timestamp,
    String? workReceivedToken,
    String? failureMessage,
  });
}

class _TranscodeOperationQueryUpdateImpl
    implements _TranscodeOperationQueryUpdate {
  const _TranscodeOperationQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<TranscodeOperation> query;
  final int? limit;

  @override
  int call({
    Object? timestamp = ignore,
    Object? workReceivedToken = ignore,
    Object? failureMessage = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (timestamp != ignore) 2: timestamp as DateTime?,
      if (workReceivedToken != ignore) 3: workReceivedToken as String?,
      if (failureMessage != ignore) 4: failureMessage as String?,
    });
  }
}

extension TranscodeOperationQueryUpdate on IsarQuery<TranscodeOperation> {
  _TranscodeOperationQueryUpdate get updateFirst =>
      _TranscodeOperationQueryUpdateImpl(this, limit: 1);

  _TranscodeOperationQueryUpdate get updateAll =>
      _TranscodeOperationQueryUpdateImpl(this);
}

class _TranscodeOperationQueryBuilderUpdateImpl
    implements _TranscodeOperationQueryUpdate {
  const _TranscodeOperationQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<TranscodeOperation, TranscodeOperation, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? timestamp = ignore,
    Object? workReceivedToken = ignore,
    Object? failureMessage = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (timestamp != ignore) 2: timestamp as DateTime?,
        if (workReceivedToken != ignore) 3: workReceivedToken as String?,
        if (failureMessage != ignore) 4: failureMessage as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension TranscodeOperationQueryBuilderUpdate
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QOperations> {
  _TranscodeOperationQueryUpdate get updateFirst =>
      _TranscodeOperationQueryBuilderUpdateImpl(this, limit: 1);

  _TranscodeOperationQueryUpdate get updateAll =>
      _TranscodeOperationQueryBuilderUpdateImpl(this);
}

extension TranscodeOperationQueryFilter
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QFilterCondition> {
  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      idGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      idLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      idLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      timestampEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      timestampGreaterThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      timestampLessThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      timestampLessThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      workReceivedTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 4,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterFilterCondition>
      failureMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }
}

extension TranscodeOperationQueryObject
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QFilterCondition> {}

extension TranscodeOperationQuerySortBy
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QSortBy> {
  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy> sortById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByWorkReceivedToken({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByWorkReceivedTokenDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByFailureMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      sortByFailureMessageDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension TranscodeOperationQuerySortThenBy
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QSortThenBy> {
  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy> thenById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByWorkReceivedToken({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByWorkReceivedTokenDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByFailureMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterSortBy>
      thenByFailureMessageDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension TranscodeOperationQueryWhereDistinct
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QDistinct> {
  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterDistinct>
      distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterDistinct>
      distinctByWorkReceivedToken({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TranscodeOperation, TranscodeOperation, QAfterDistinct>
      distinctByFailureMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }
}

extension TranscodeOperationQueryProperty1
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QProperty> {
  QueryBuilder<TranscodeOperation, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<TranscodeOperation, DateTime, QAfterProperty>
      timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<TranscodeOperation, String?, QAfterProperty>
      workReceivedTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<TranscodeOperation, String?, QAfterProperty>
      failureMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension TranscodeOperationQueryProperty2<R>
    on QueryBuilder<TranscodeOperation, R, QAfterProperty> {
  QueryBuilder<TranscodeOperation, (R, String), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<TranscodeOperation, (R, DateTime), QAfterProperty>
      timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<TranscodeOperation, (R, String?), QAfterProperty>
      workReceivedTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<TranscodeOperation, (R, String?), QAfterProperty>
      failureMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension TranscodeOperationQueryProperty3<R1, R2>
    on QueryBuilder<TranscodeOperation, (R1, R2), QAfterProperty> {
  QueryBuilder<TranscodeOperation, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<TranscodeOperation, (R1, R2, DateTime), QOperations>
      timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<TranscodeOperation, (R1, R2, String?), QOperations>
      workReceivedTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<TranscodeOperation, (R1, R2, String?), QOperations>
      failureMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}
