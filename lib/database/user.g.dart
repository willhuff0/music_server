// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetUserCollection on Isar {
  IsarCollection<String, User> get users => this.collection();
}

const UserSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'User',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'id',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'name',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'email',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'password',
        type: IsarType.object,
        target: 'HashedUserPassword',
      ),
      IsarPropertySchema(
        name: 'activity',
        type: IsarType.objectList,
        target: 'UserActivity',
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, User>(
    serialize: serializeUser,
    deserialize: deserializeUser,
    deserializeProperty: deserializeUserProp,
  ),
  embeddedSchemas: [HashedUserPasswordSchema, UserActivitySchema],
);

@isarProtected
int serializeUser(IsarWriter writer, User object) {
  IsarCore.writeString(writer, 1, object.id);
  IsarCore.writeString(writer, 2, object.name);
  IsarCore.writeString(writer, 3, object.email);
  {
    final value = object.password;
    final objectWriter = IsarCore.beginObject(writer, 4);
    serializeHashedUserPassword(objectWriter, value);
    IsarCore.endObject(writer, objectWriter);
  }
  {
    final list = object.activities;
    final listWriter = IsarCore.beginList(writer, 5, list.length);
    for (var i = 0; i < list.length; i++) {
      {
        final value = list[i];
        final objectWriter = IsarCore.beginObject(listWriter, i);
        serializeUserActivity(objectWriter, value);
        IsarCore.endObject(listWriter, objectWriter);
      }
    }
    IsarCore.endList(writer, listWriter);
  }
  return Isar.fastHash(object.id);
}

@isarProtected
User deserializeUser(IsarReader reader) {
  final String _id;
  _id = IsarCore.readString(reader, 1) ?? '';
  final String _name;
  _name = IsarCore.readString(reader, 2) ?? '';
  final String _email;
  _email = IsarCore.readString(reader, 3) ?? '';
  final HashedUserPassword _password;
  {
    final objectReader = IsarCore.readObject(reader, 4);
    if (objectReader.isNull) {
      _password = HashedUserPassword(
        nonce: const <int>[],
        hash: const <int>[],
      );
    } else {
      final embedded = deserializeHashedUserPassword(objectReader);
      IsarCore.freeReader(objectReader);
      _password = embedded;
    }
  }
  final List<UserActivity> _activity;
  {
    final length = IsarCore.readList(reader, 5, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _activity = const [];
      } else {
        final list = List<UserActivity>.filled(
            length,
            UserActivity(
              type: UserActivityType.createUser,
              timestamp: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal(),
            ),
            growable: true);
        for (var i = 0; i < length; i++) {
          {
            final objectReader = IsarCore.readObject(reader, i);
            if (objectReader.isNull) {
              list[i] = UserActivity(
                type: UserActivityType.createUser,
                timestamp: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal(),
              );
            } else {
              final embedded = deserializeUserActivity(objectReader);
              IsarCore.freeReader(objectReader);
              list[i] = embedded;
            }
          }
        }
        IsarCore.freeReader(reader);
        _activity = list;
      }
    }
  }
  final object = User(
    id: _id,
    name: _name,
    email: _email,
    password: _password,
    activities: _activity,
  );
  return object;
}

@isarProtected
dynamic deserializeUserProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      {
        final objectReader = IsarCore.readObject(reader, 4);
        if (objectReader.isNull) {
          return HashedUserPassword(
            nonce: const <int>[],
            hash: const <int>[],
          );
        } else {
          final embedded = deserializeHashedUserPassword(objectReader);
          IsarCore.freeReader(objectReader);
          return embedded;
        }
      }
    case 5:
      {
        final length = IsarCore.readList(reader, 5, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return const [];
          } else {
            final list = List<UserActivity>.filled(
                length,
                UserActivity(
                  type: UserActivityType.createUser,
                  timestamp: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal(),
                ),
                growable: true);
            for (var i = 0; i < length; i++) {
              {
                final objectReader = IsarCore.readObject(reader, i);
                if (objectReader.isNull) {
                  list[i] = UserActivity(
                    type: UserActivityType.createUser,
                    timestamp: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal(),
                  );
                } else {
                  final embedded = deserializeUserActivity(objectReader);
                  IsarCore.freeReader(objectReader);
                  list[i] = embedded;
                }
              }
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _UserUpdate {
  bool call({
    required String id,
    String? name,
    String? email,
  });
}

class _UserUpdateImpl implements _UserUpdate {
  const _UserUpdateImpl(this.collection);

  final IsarCollection<String, User> collection;

  @override
  bool call({
    required String id,
    Object? name = ignore,
    Object? email = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (name != ignore) 2: name as String?,
          if (email != ignore) 3: email as String?,
        }) >
        0;
  }
}

sealed class _UserUpdateAll {
  int call({
    required List<String> id,
    String? name,
    String? email,
  });
}

class _UserUpdateAllImpl implements _UserUpdateAll {
  const _UserUpdateAllImpl(this.collection);

  final IsarCollection<String, User> collection;

  @override
  int call({
    required List<String> id,
    Object? name = ignore,
    Object? email = ignore,
  }) {
    return collection.updateProperties(id, {
      if (name != ignore) 2: name as String?,
      if (email != ignore) 3: email as String?,
    });
  }
}

extension UserUpdate on IsarCollection<String, User> {
  _UserUpdate get update => _UserUpdateImpl(this);

  _UserUpdateAll get updateAll => _UserUpdateAllImpl(this);
}

sealed class _UserQueryUpdate {
  int call({
    String? name,
    String? email,
  });
}

class _UserQueryUpdateImpl implements _UserQueryUpdate {
  const _UserQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<User> query;
  final int? limit;

  @override
  int call({
    Object? name = ignore,
    Object? email = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (name != ignore) 2: name as String?,
      if (email != ignore) 3: email as String?,
    });
  }
}

extension UserQueryUpdate on IsarQuery<User> {
  _UserQueryUpdate get updateFirst => _UserQueryUpdateImpl(this, limit: 1);

  _UserQueryUpdate get updateAll => _UserQueryUpdateImpl(this);
}

class _UserQueryBuilderUpdateImpl implements _UserQueryUpdate {
  const _UserQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<User, User, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? name = ignore,
    Object? email = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (name != ignore) 2: name as String?,
        if (email != ignore) 3: email as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension UserQueryBuilderUpdate on QueryBuilder<User, User, QOperations> {
  _UserQueryUpdate get updateFirst => _UserQueryBuilderUpdateImpl(this, limit: 1);

  _UserQueryUpdate get updateAll => _UserQueryBuilderUpdateImpl(this);
}

extension UserQueryFilter on QueryBuilder<User, User, QFilterCondition> {
  QueryBuilder<User, User, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> idGreaterThanOrEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> idLessThanOrEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> idBetween(
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

  QueryBuilder<User, User, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> idContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<User, User, QAfterFilterCondition> idMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<User, User, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> nameGreaterThanOrEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> nameLessThanOrEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<User, User, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> nameContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<User, User, QAfterFilterCondition> nameMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<User, User, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> emailGreaterThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> emailGreaterThanOrEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> emailLessThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> emailLessThanOrEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> emailBetween(
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

  QueryBuilder<User, User, QAfterFilterCondition> emailStartsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> emailEndsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> emailContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<User, User, QAfterFilterCondition> emailMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<User, User, QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> activityIsEmpty() {
    return not().activityIsNotEmpty();
  }

  QueryBuilder<User, User, QAfterFilterCondition> activityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 5, value: null),
      );
    });
  }
}

extension UserQueryObject on QueryBuilder<User, User, QFilterCondition> {
  QueryBuilder<User, User, QAfterFilterCondition> password(FilterQuery<HashedUserPassword> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, 4);
    });
  }
}

extension UserQuerySortBy on QueryBuilder<User, User, QSortBy> {
  QueryBuilder<User, User, QAfterSortBy> sortById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByEmailDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension UserQuerySortThenBy on QueryBuilder<User, User, QSortThenBy> {
  QueryBuilder<User, User, QAfterSortBy> thenById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByEmailDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension UserQueryWhereDistinct on QueryBuilder<User, User, QDistinct> {
  QueryBuilder<User, User, QAfterDistinct> distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterDistinct> distinctByEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }
}

extension UserQueryProperty1 on QueryBuilder<User, User, QProperty> {
  QueryBuilder<User, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<User, String, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<User, String, QAfterProperty> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<User, HashedUserPassword, QAfterProperty> passwordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<User, List<UserActivity>, QAfterProperty> activityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension UserQueryProperty2<R> on QueryBuilder<User, R, QAfterProperty> {
  QueryBuilder<User, (R, String), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<User, (R, String), QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<User, (R, String), QAfterProperty> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<User, (R, HashedUserPassword), QAfterProperty> passwordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<User, (R, List<UserActivity>), QAfterProperty> activityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension UserQueryProperty3<R1, R2> on QueryBuilder<User, (R1, R2), QAfterProperty> {
  QueryBuilder<User, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<User, (R1, R2, String), QOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<User, (R1, R2, String), QOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<User, (R1, R2, HashedUserPassword), QOperations> passwordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<User, (R1, R2, List<UserActivity>), QOperations> activityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

// **************************************************************************
// _IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

const HashedUserPasswordSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'HashedUserPassword',
    embedded: true,
    properties: [
      IsarPropertySchema(
        name: 'nonce',
        type: IsarType.longList,
      ),
      IsarPropertySchema(
        name: 'hash',
        type: IsarType.longList,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<void, HashedUserPassword>(
    serialize: serializeHashedUserPassword,
    deserialize: deserializeHashedUserPassword,
  ),
);

@isarProtected
int serializeHashedUserPassword(IsarWriter writer, HashedUserPassword object) {
  {
    final list = object.nonce;
    final listWriter = IsarCore.beginList(writer, 1, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeLong(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  {
    final list = object.hash;
    final listWriter = IsarCore.beginList(writer, 2, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeLong(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  return 0;
}

@isarProtected
HashedUserPassword deserializeHashedUserPassword(IsarReader reader) {
  final List<int> _nonce;
  {
    final length = IsarCore.readList(reader, 1, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _nonce = const <int>[];
      } else {
        final list = List<int>.filled(length, -9223372036854775808, growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readLong(reader, i);
        }
        IsarCore.freeReader(reader);
        _nonce = list;
      }
    }
  }
  final List<int> _hash;
  {
    final length = IsarCore.readList(reader, 2, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _hash = const <int>[];
      } else {
        final list = List<int>.filled(length, -9223372036854775808, growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readLong(reader, i);
        }
        IsarCore.freeReader(reader);
        _hash = list;
      }
    }
  }
  final object = HashedUserPassword(
    nonce: _nonce,
    hash: _hash,
  );
  return object;
}

extension HashedUserPasswordQueryFilter on QueryBuilder<HashedUserPassword, HashedUserPassword, QFilterCondition> {
  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> nonceElementEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> nonceElementGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> nonceElementGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> nonceElementLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> nonceElementLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> nonceElementBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> nonceIsEmpty() {
    return not().nonceIsNotEmpty();
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> nonceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 1, value: null),
      );
    });
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> hashElementEqualTo(
    int value,
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

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> hashElementGreaterThan(
    int value,
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

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> hashElementGreaterThanOrEqualTo(
    int value,
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

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> hashElementLessThan(
    int value,
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

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> hashElementLessThanOrEqualTo(
    int value,
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

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> hashElementBetween(
    int lower,
    int upper,
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

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> hashIsEmpty() {
    return not().hashIsNotEmpty();
  }

  QueryBuilder<HashedUserPassword, HashedUserPassword, QAfterFilterCondition> hashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 2, value: null),
      );
    });
  }
}

extension HashedUserPasswordQueryObject on QueryBuilder<HashedUserPassword, HashedUserPassword, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

const UserActivitySchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'UserActivity',
    embedded: true,
    properties: [
      IsarPropertySchema(
        name: 'type',
        type: IsarType.byte,
        enumMap: {"createUser": 0, "startSession": 1},
      ),
      IsarPropertySchema(
        name: 'timestamp',
        type: IsarType.dateTime,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<void, UserActivity>(
    serialize: serializeUserActivity,
    deserialize: deserializeUserActivity,
  ),
);

@isarProtected
int serializeUserActivity(IsarWriter writer, UserActivity object) {
  IsarCore.writeByte(writer, 1, object.type.index);
  IsarCore.writeLong(writer, 2, object.timestamp.toUtc().microsecondsSinceEpoch);
  return 0;
}

@isarProtected
UserActivity deserializeUserActivity(IsarReader reader) {
  final UserActivityType _type;
  {
    if (IsarCore.readNull(reader, 1)) {
      _type = UserActivityType.createUser;
    } else {
      _type = _userActivityType[IsarCore.readByte(reader, 1)] ?? UserActivityType.createUser;
    }
  }
  final DateTime _timestamp;
  {
    final value = IsarCore.readLong(reader, 2);
    if (value == -9223372036854775808) {
      _timestamp = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
    } else {
      _timestamp = DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final object = UserActivity(
    type: _type,
    timestamp: _timestamp,
  );
  return object;
}

const _userActivityType = {
  0: UserActivityType.createUser,
  1: UserActivityType.startSession,
};

extension UserActivityQueryFilter on QueryBuilder<UserActivity, UserActivity, QFilterCondition> {
  QueryBuilder<UserActivity, UserActivity, QAfterFilterCondition> typeEqualTo(
    UserActivityType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<UserActivity, UserActivity, QAfterFilterCondition> typeGreaterThan(
    UserActivityType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<UserActivity, UserActivity, QAfterFilterCondition> typeGreaterThanOrEqualTo(
    UserActivityType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<UserActivity, UserActivity, QAfterFilterCondition> typeLessThan(
    UserActivityType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<UserActivity, UserActivity, QAfterFilterCondition> typeLessThanOrEqualTo(
    UserActivityType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<UserActivity, UserActivity, QAfterFilterCondition> typeBetween(
    UserActivityType lower,
    UserActivityType upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower.index,
          upper: upper.index,
        ),
      );
    });
  }

  QueryBuilder<UserActivity, UserActivity, QAfterFilterCondition> timestampEqualTo(
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

  QueryBuilder<UserActivity, UserActivity, QAfterFilterCondition> timestampGreaterThan(
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

  QueryBuilder<UserActivity, UserActivity, QAfterFilterCondition> timestampGreaterThanOrEqualTo(
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

  QueryBuilder<UserActivity, UserActivity, QAfterFilterCondition> timestampLessThan(
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

  QueryBuilder<UserActivity, UserActivity, QAfterFilterCondition> timestampLessThanOrEqualTo(
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

  QueryBuilder<UserActivity, UserActivity, QAfterFilterCondition> timestampBetween(
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
}

extension UserActivityQueryObject on QueryBuilder<UserActivity, UserActivity, QFilterCondition> {}
