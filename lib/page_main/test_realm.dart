import 'dart:convert';
import 'dart:math';
import 'package:otp/otp.dart' as LOTP;
import 'package:base32/base32.dart';
import 'package:aspis/global_realm.dart';
import 'package:aspis/store/test.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as pe;

import 'package:aspis/page_main/otp_code_block/otp_code_block.dart';
import 'package:aspis/components/flat_textfield.dart';
import 'package:realm/realm.dart';

class TestRealm extends StatefulWidget {
  const TestRealm({super.key});

  @override
  State<TestRealm> createState() => _TestRealmState();
}

class _TestRealmState extends State<TestRealm> {
  final passwordTextController = TextEditingController();

  RealmResults<OTP>? OTPCodes;

  @override
  void initState() {
    super.initState();

    OTPCodes = gRealm.all<OTP>();

    print(OTPCodes);
  }

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
    final people = gRealm.all<Person>();
    for (var i = 0; i < people.length; ++i) {
      print(people[i].name);
    }

    final otp = gRealm.all<OTP>();
    for (var i = 0; i < otp.length; ++i) {
      print(otp[i].title);
      // GenerateOTPCode(otp[i]);
    }
  }

// For testing purposes
  void GenerateOTPCode(otp) {
    print(otp);
    // if (otp.title != "NP") {
    //   return;
    // }

    print(otp.secret);

    final code = LOTP.OTP.generateTOTPCodeString(otp.secret, DateTime.now().millisecondsSinceEpoch,
        length: 6, interval: 30, algorithm: LOTP.Algorithm.SHA1, isGoogle: true);
    print(code);
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
          for (var otpcode in OTPCodes!) OTPCodeBlock(otpcode: otpcode),
          TextButton(onPressed: () => {addTestDataToRealm()}, child: const Text("Test Data")),
          TextButton(onPressed: () => {readTestDataToRealm()}, child: const Text("Read Data"))
        ],
      ),
    );
  }
}
