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
  TestRealm({super.key, required this.searchString});

  late String searchString = "";

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

  List<OTP> filteredCodes() {
    List<OTP> filteredList = [];
    if (OTPCodes != null) {
      var searchText = widget.searchString.toLowerCase();
      for (var otpCode in OTPCodes!) {
        if (otpCode.title.toLowerCase().contains(searchText) ||
            otpCode.issuer!.toLowerCase().contains(searchText) ||
            searchText == '') {
          filteredList.add(otpCode);
        }
      }
    }
    return filteredList;
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
      debugPrint(people[i].name);
    }

    final otp = gRealm.all<OTP>();
    for (var i = 0; i < otp.length; ++i) {
      debugPrint(otp[i].title);
      // GenerateOTPCode(otp[i]);
    }
  }

// For testing purposes
  void GenerateOTPCode(otp) {
    debugPrint(otp);
    // if (otp.title != "NP") {
    //   return;
    // }

    debugPrint(otp.secret);

    final code = LOTP.OTP.generateTOTPCodeString(otp.secret, DateTime.now().millisecondsSinceEpoch,
        length: 6, interval: 30, algorithm: LOTP.Algorithm.SHA1, isGoogle: true);
    debugPrint(code);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(filteredCodes().toString());
    debugPrint(OTPCodes!.toString());
    debugPrint(widget.searchString);

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Column(
        children: [
          Wrap(
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              for (var otpcode in filteredCodes()) ...[
                OTPCodeBlock(otpcode: otpcode),
                SizedBox(
                  height: 4.0,
                ),
              ],
            ],
          ),
          TextButton(onPressed: () => {addTestDataToRealm()}, child: const Text("Test Data")),
          TextButton(onPressed: () => {readTestDataToRealm()}, child: const Text("Read Data"))
        ],
      ),
    );
  }
}
