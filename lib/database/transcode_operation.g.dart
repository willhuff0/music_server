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
  return Isar.fastHash(object.id);
}

@isarProtected
TranscodeOperation deserializeTranscodeOperation(IsarReader reader) {
  final String _id;
  _id = IsarCore.readString(reader, 1) ?? '';
  final object = TranscodeOperation(
    _id,
  );
  return object;
}

@isarProtected
dynamic deserializeTranscodeOperationProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
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
}

extension TranscodeOperationQueryWhereDistinct
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QDistinct> {}

extension TranscodeOperationQueryProperty1
    on QueryBuilder<TranscodeOperation, TranscodeOperation, QProperty> {
  QueryBuilder<TranscodeOperation, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
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
}

extension TranscodeOperationQueryProperty3<R1, R2>
    on QueryBuilder<TranscodeOperation, (R1, R2), QAfterProperty> {
  QueryBuilder<TranscodeOperation, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }
}
