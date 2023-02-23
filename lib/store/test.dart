import 'dart:ffi';

import 'package:realm/realm.dart';

part 'test.g.dart';

@RealmModel()
class _Person {
  @PrimaryKey()
  late ObjectId id;
  late String name;
}

@RealmModel()
class _OTP {
  @PrimaryKey()
  late ObjectId id;

  late String title;

  late String secret;

  late String? issuer;

  late String? group;

  late String? notes;

  late String type;
  late String hashFunc;
  late int period;
  late int digits;
  late int usageCount;
}
