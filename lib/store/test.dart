import 'package:realm/realm.dart';

part 'test.g.dart';

@RealmModel()
class _Person {
  @PrimaryKey()
  late ObjectId id;
  late String name;
}

// @RealmModel()
// class _RealmTest {
//   @PrimaryKey()
//   late ObjectId id;
//   late String name;
// }
