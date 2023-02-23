// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Person extends _Person with RealmEntity, RealmObjectBase, RealmObject {
  Person(
    ObjectId id,
    String name,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  Person._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<Person>> get changes =>
      RealmObjectBase.getChanges<Person>(this);

  @override
  Person freeze() => RealmObjectBase.freezeObject<Person>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Person._);
    return const SchemaObject(ObjectType.realmObject, Person, 'Person', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class OTP extends _OTP with RealmEntity, RealmObjectBase, RealmObject {
  OTP(
    ObjectId id,
    String title,
    String secret,
    String type,
    String hashFunc,
    int period,
    int digits,
    int usageCount, {
    String? issuer,
    String? group,
    String? notes,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'secret', secret);
    RealmObjectBase.set(this, 'issuer', issuer);
    RealmObjectBase.set(this, 'group', group);
    RealmObjectBase.set(this, 'notes', notes);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'hashFunc', hashFunc);
    RealmObjectBase.set(this, 'period', period);
    RealmObjectBase.set(this, 'digits', digits);
    RealmObjectBase.set(this, 'usageCount', usageCount);
  }

  OTP._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get secret => RealmObjectBase.get<String>(this, 'secret') as String;
  @override
  set secret(String value) => RealmObjectBase.set(this, 'secret', value);

  @override
  String? get issuer => RealmObjectBase.get<String>(this, 'issuer') as String?;
  @override
  set issuer(String? value) => RealmObjectBase.set(this, 'issuer', value);

  @override
  String? get group => RealmObjectBase.get<String>(this, 'group') as String?;
  @override
  set group(String? value) => RealmObjectBase.set(this, 'group', value);

  @override
  String? get notes => RealmObjectBase.get<String>(this, 'notes') as String?;
  @override
  set notes(String? value) => RealmObjectBase.set(this, 'notes', value);

  @override
  String get type => RealmObjectBase.get<String>(this, 'type') as String;
  @override
  set type(String value) => RealmObjectBase.set(this, 'type', value);

  @override
  String get hashFunc =>
      RealmObjectBase.get<String>(this, 'hashFunc') as String;
  @override
  set hashFunc(String value) => RealmObjectBase.set(this, 'hashFunc', value);

  @override
  int get period => RealmObjectBase.get<int>(this, 'period') as int;
  @override
  set period(int value) => RealmObjectBase.set(this, 'period', value);

  @override
  int get digits => RealmObjectBase.get<int>(this, 'digits') as int;
  @override
  set digits(int value) => RealmObjectBase.set(this, 'digits', value);

  @override
  int get usageCount => RealmObjectBase.get<int>(this, 'usageCount') as int;
  @override
  set usageCount(int value) => RealmObjectBase.set(this, 'usageCount', value);

  @override
  Stream<RealmObjectChanges<OTP>> get changes =>
      RealmObjectBase.getChanges<OTP>(this);

  @override
  OTP freeze() => RealmObjectBase.freezeObject<OTP>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(OTP._);
    return const SchemaObject(ObjectType.realmObject, OTP, 'OTP', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('secret', RealmPropertyType.string),
      SchemaProperty('issuer', RealmPropertyType.string, optional: true),
      SchemaProperty('group', RealmPropertyType.string, optional: true),
      SchemaProperty('notes', RealmPropertyType.string, optional: true),
      SchemaProperty('type', RealmPropertyType.string),
      SchemaProperty('hashFunc', RealmPropertyType.string),
      SchemaProperty('period', RealmPropertyType.int),
      SchemaProperty('digits', RealmPropertyType.int),
      SchemaProperty('usageCount', RealmPropertyType.int),
    ]);
  }
}
