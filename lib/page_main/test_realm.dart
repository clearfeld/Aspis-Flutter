import 'dart:convert';
import 'package:aspis/global_realm.dart';
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

  void addTestDataToRealm() {
    gRealm.write(() {
      gRealm.addAll([
        Person(ObjectId(), 'Figrin D\'an'),
        Person(ObjectId(), 'Greedo'),
        Person(ObjectId(), 'Toro')
      ]);
    });
  }

  void readTestDataToRealm() {
    // final people = gRealm.all<Person>();
    // for (var i = 0; i < people.length; ++i) {
    //   print(people[i].name);
    // }

    final otp = gRealm.all<OTP>();
    for (var i = 0; i < otp.length; ++i) {
      print(otp[i].title);
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

          TextButton(onPressed: () => {addTestDataToRealm()}, child: const Text("Test Data")),

          TextButton(onPressed: () => {readTestDataToRealm()}, child: const Text("Read Data"))
        ],
      ),
    );
  }
}
