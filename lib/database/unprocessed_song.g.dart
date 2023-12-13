// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unprocessed_song.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetUnprocessedSongCollection on Isar {
  IsarCollection<String, UnprocessedSong> get unprocessedSongs =>
      this.collection();
}

const UnprocessedSongSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'UnprocessedSong',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'id',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'owner',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'name',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'description',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'fileExtension',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'numParts',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'numPartsReceived',
        type: IsarType.long,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, UnprocessedSong>(
    serialize: serializeUnprocessedSong,
    deserialize: deserializeUnprocessedSong,
    deserializeProperty: deserializeUnprocessedSongProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeUnprocessedSong(IsarWriter writer, UnprocessedSong object) {
  IsarCore.writeString(writer, 1, object.id);
  IsarCore.writeString(writer, 2, object.owner);
  IsarCore.writeString(writer, 3, object.name);
  IsarCore.writeString(writer, 4, object.description);
  IsarCore.writeString(writer, 5, object.fileExtension);
  IsarCore.writeLong(writer, 6, object.numParts);
  IsarCore.writeLong(writer, 7, object.numPartsReceived);
  return Isar.fastHash(object.id);
}

@isarProtected
UnprocessedSong deserializeUnprocessedSong(IsarReader reader) {
  final String _id;
  _id = IsarCore.readString(reader, 1) ?? '';
  final String _owner;
  _owner = IsarCore.readString(reader, 2) ?? '';
  final String _name;
  _name = IsarCore.readString(reader, 3) ?? '';
  final String _description;
  _description = IsarCore.readString(reader, 4) ?? '';
  final String _fileExtension;
  _fileExtension = IsarCore.readString(reader, 5) ?? '';
  final int _numParts;
  _numParts = IsarCore.readLong(reader, 6);
  final int _numPartsReceived;
  _numPartsReceived = IsarCore.readLong(reader, 7);
  final object = UnprocessedSong(
    id: _id,
    owner: _owner,
    name: _name,
    description: _description,
    fileExtension: _fileExtension,
    numParts: _numParts,
    numPartsReceived: _numPartsReceived,
  );
  return object;
}

@isarProtected
dynamic deserializeUnprocessedSongProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      return IsarCore.readString(reader, 4) ?? '';
    case 5:
      return IsarCore.readString(reader, 5) ?? '';
    case 6:
      return IsarCore.readLong(reader, 6);
    case 7:
      return IsarCore.readLong(reader, 7);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _UnprocessedSongUpdate {
  bool call({
    required String id,
    String? owner,
    String? name,
    String? description,
    String? fileExtension,
    int? numParts,
    int? numPartsReceived,
  });
}

class _UnprocessedSongUpdateImpl implements _UnprocessedSongUpdate {
  const _UnprocessedSongUpdateImpl(this.collection);

  final IsarCollection<String, UnprocessedSong> collection;

  @override
  bool call({
    required String id,
    Object? owner = ignore,
    Object? name = ignore,
    Object? description = ignore,
    Object? fileExtension = ignore,
    Object? numParts = ignore,
    Object? numPartsReceived = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (owner != ignore) 2: owner as String?,
          if (name != ignore) 3: name as String?,
          if (description != ignore) 4: description as String?,
          if (fileExtension != ignore) 5: fileExtension as String?,
          if (numParts != ignore) 6: numParts as int?,
          if (numPartsReceived != ignore) 7: numPartsReceived as int?,
        }) >
        0;
  }
}

sealed class _UnprocessedSongUpdateAll {
  int call({
    required List<String> id,
    String? owner,
    String? name,
    String? description,
    String? fileExtension,
    int? numParts,
    int? numPartsReceived,
  });
}

class _UnprocessedSongUpdateAllImpl implements _UnprocessedSongUpdateAll {
  const _UnprocessedSongUpdateAllImpl(this.collection);

  final IsarCollection<String, UnprocessedSong> collection;

  @override
  int call({
    required List<String> id,
    Object? owner = ignore,
    Object? name = ignore,
    Object? description = ignore,
    Object? fileExtension = ignore,
    Object? numParts = ignore,
    Object? numPartsReceived = ignore,
  }) {
    return collection.updateProperties(id, {
      if (owner != ignore) 2: owner as String?,
      if (name != ignore) 3: name as String?,
      if (description != ignore) 4: description as String?,
      if (fileExtension != ignore) 5: fileExtension as String?,
      if (numParts != ignore) 6: numParts as int?,
      if (numPartsReceived != ignore) 7: numPartsReceived as int?,
    });
  }
}

extension UnprocessedSongUpdate on IsarCollection<String, UnprocessedSong> {
  _UnprocessedSongUpdate get update => _UnprocessedSongUpdateImpl(this);

  _UnprocessedSongUpdateAll get updateAll =>
      _UnprocessedSongUpdateAllImpl(this);
}

sealed class _UnprocessedSongQueryUpdate {
  int call({
    String? owner,
    String? name,
    String? description,
    String? fileExtension,
    int? numParts,
    int? numPartsReceived,
  });
}

class _UnprocessedSongQueryUpdateImpl implements _UnprocessedSongQueryUpdate {
  const _UnprocessedSongQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<UnprocessedSong> query;
  final int? limit;

  @override
  int call({
    Object? owner = ignore,
    Object? name = ignore,
    Object? description = ignore,
    Object? fileExtension = ignore,
    Object? numParts = ignore,
    Object? numPartsReceived = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (owner != ignore) 2: owner as String?,
      if (name != ignore) 3: name as String?,
      if (description != ignore) 4: description as String?,
      if (fileExtension != ignore) 5: fileExtension as String?,
      if (numParts != ignore) 6: numParts as int?,
      if (numPartsReceived != ignore) 7: numPartsReceived as int?,
    });
  }
}

extension UnprocessedSongQueryUpdate on IsarQuery<UnprocessedSong> {
  _UnprocessedSongQueryUpdate get updateFirst =>
      _UnprocessedSongQueryUpdateImpl(this, limit: 1);

  _UnprocessedSongQueryUpdate get updateAll =>
      _UnprocessedSongQueryUpdateImpl(this);
}

class _UnprocessedSongQueryBuilderUpdateImpl
    implements _UnprocessedSongQueryUpdate {
  const _UnprocessedSongQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<UnprocessedSong, UnprocessedSong, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? owner = ignore,
    Object? name = ignore,
    Object? description = ignore,
    Object? fileExtension = ignore,
    Object? numParts = ignore,
    Object? numPartsReceived = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (owner != ignore) 2: owner as String?,
        if (name != ignore) 3: name as String?,
        if (description != ignore) 4: description as String?,
        if (fileExtension != ignore) 5: fileExtension as String?,
        if (numParts != ignore) 6: numParts as int?,
        if (numPartsReceived != ignore) 7: numPartsReceived as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension UnprocessedSongQueryBuilderUpdate
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QOperations> {
  _UnprocessedSongQueryUpdate get updateFirst =>
      _UnprocessedSongQueryBuilderUpdateImpl(this, limit: 1);

  _UnprocessedSongQueryUpdate get updateAll =>
      _UnprocessedSongQueryBuilderUpdateImpl(this);
}

extension UnprocessedSongQueryFilter
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QFilterCondition> {
  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      ownerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameEqualTo(
    String value, {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameGreaterThanOrEqualTo(
    String value, {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameLessThan(
    String value, {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameLessThanOrEqualTo(
    String value, {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameEndsWith(
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionGreaterThanOrEqualTo(
    String value, {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionLessThanOrEqualTo(
    String value, {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionStartsWith(
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionEndsWith(
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 5,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      fileExtensionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsReceivedEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsReceivedGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsReceivedGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsReceivedLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsReceivedLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterFilterCondition>
      numPartsReceivedBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 7,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }
}

extension UnprocessedSongQueryObject
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QFilterCondition> {}

extension UnprocessedSongQuerySortBy
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QSortBy> {
  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> sortById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> sortByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> sortByOwner(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> sortByOwnerDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> sortByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> sortByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByDescriptionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByFileExtension({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByFileExtensionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByNumParts() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByNumPartsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByNumPartsReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      sortByNumPartsReceivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }
}

extension UnprocessedSongQuerySortThenBy
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QSortThenBy> {
  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> thenById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> thenByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> thenByOwner(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> thenByOwnerDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> thenByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy> thenByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByDescriptionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByFileExtension({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByFileExtensionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByNumParts() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByNumPartsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByNumPartsReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterSortBy>
      thenByNumPartsReceivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }
}

extension UnprocessedSongQueryWhereDistinct
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QDistinct> {
  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterDistinct>
      distinctByOwner({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterDistinct>
      distinctByFileExtension({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterDistinct>
      distinctByNumParts() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<UnprocessedSong, UnprocessedSong, QAfterDistinct>
      distinctByNumPartsReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7);
    });
  }
}

extension UnprocessedSongQueryProperty1
    on QueryBuilder<UnprocessedSong, UnprocessedSong, QProperty> {
  QueryBuilder<UnprocessedSong, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<UnprocessedSong, String, QAfterProperty> ownerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<UnprocessedSong, String, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<UnprocessedSong, String, QAfterProperty> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<UnprocessedSong, String, QAfterProperty>
      fileExtensionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<UnprocessedSong, int, QAfterProperty> numPartsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<UnprocessedSong, int, QAfterProperty>
      numPartsReceivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}

extension UnprocessedSongQueryProperty2<R>
    on QueryBuilder<UnprocessedSong, R, QAfterProperty> {
  QueryBuilder<UnprocessedSong, (R, String), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<UnprocessedSong, (R, String), QAfterProperty> ownerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<UnprocessedSong, (R, String), QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<UnprocessedSong, (R, String), QAfterProperty>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<UnprocessedSong, (R, String), QAfterProperty>
      fileExtensionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<UnprocessedSong, (R, int), QAfterProperty> numPartsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<UnprocessedSong, (R, int), QAfterProperty>
      numPartsReceivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}

extension UnprocessedSongQueryProperty3<R1, R2>
    on QueryBuilder<UnprocessedSong, (R1, R2), QAfterProperty> {
  QueryBuilder<UnprocessedSong, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<UnprocessedSong, (R1, R2, String), QOperations> ownerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<UnprocessedSong, (R1, R2, String), QOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<UnprocessedSong, (R1, R2, String), QOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<UnprocessedSong, (R1, R2, String), QOperations>
      fileExtensionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<UnprocessedSong, (R1, R2, int), QOperations> numPartsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<UnprocessedSong, (R1, R2, int), QOperations>
      numPartsReceivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}
