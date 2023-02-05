import 'dart:convert';
import 'package:aspis/store/test.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as pe;

import 'package:aspis/components/flat_textfield.dart';
import 'package:realm/realm.dart';

class TestRealm extends StatefulWidget {
  const TestRealm({super.key});

  @override
  State<TestRealm> createState() => _TestRealmState();
}

class _TestRealmState extends State<TestRealm> {
  final passwordTextController = TextEditingController();
  late Realm realm;

  void attemptToUnlockRealm() {
    // print("Attempting to unlock realm");
    var bytes = utf8.encode(passwordTextController.text);
    var digest = sha256.convert(bytes);

    var dd = digest.toString().substring(0, 32); // get the first 32 chars as the aes key
    final key = pe.Key.fromUtf8(dd);
    final iv = pe.IV.fromLength(16);

    final encrypter = pe.Encrypter(pe.AES(key));

    // long static string to ensure enough bytes are generated for the 64 byte encryptionkey
    final encrypted = encrypter
        .encrypt("mAEFuw90ebncuasethesthsethse hsseti203bjci0jbcji 0-beI) YCuI)BWEc", iv: iv);

    print("AES key - ${encrypted.bytes}");

    // TODO: ensure encrypted bytes is atleast 64 bytes
    // needs some more testing without the try catch

    List<int> x = [];
    for (var i = 0; i < 64; ++i) {
      x.add(encrypted.bytes[i]);
    }

    print(x);

    try {
      final encryptedConfig = Configuration.local([Person.schema], encryptionKey: x);
      realm = Realm(encryptedConfig);
    } catch (e) {
      // likely wrong password failed to open realm
      // TODO: check docs if there are error codes or something better
      print("Couldnt open realm");
      // TODO: have ui element showing error opening db (vault)
    }
  }

  void addTestDataToRealm() {
    realm.write(() {
      realm.addAll([
        Person(ObjectId(), 'Figrin D\'an'),
        Person(ObjectId(), 'Greedo'),
        Person(ObjectId(), 'Toro')
      ]);
    });
  }

  void readTestDataToRealm() {
    final people = realm.all<Person>();
    for (var i = 0; i < people.length; ++i) {
      print(people[i].name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 16,
          ),

          //
          FlatTextField(
            textController: passwordTextController,
            hintText: "Password",
            password: true,
          ),

          //
          TextButton(onPressed: () => {attemptToUnlockRealm()}, child: const Text("Enter")),

          TextButton(onPressed: () => {addTestDataToRealm()}, child: const Text("Test Data")),

          TextButton(onPressed: () => {readTestDataToRealm()}, child: const Text("Read Data"))
        ],
      ),
    );
  }
}
