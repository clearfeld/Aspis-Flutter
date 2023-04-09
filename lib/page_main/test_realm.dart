import 'package:otp/otp.dart' as pl_lotp;
import 'package:aspis/global_realm.dart';
import 'package:aspis/store/test.dart';
import 'package:flutter/material.dart';

import 'package:aspis/page_main/otp_code_block/otp_code_block.dart';
import 'package:realm/realm.dart';

class TestRealm extends StatefulWidget {
  const TestRealm({
    super.key,
    required this.searchString,
    required this.onSelectedOTPCode
    });

  final String searchString;
  final Function(OTP) onSelectedOTPCode;

  @override
  State<TestRealm> createState() => _TestRealmState();
}

class _TestRealmState extends State<TestRealm> {
  final passwordTextController = TextEditingController();

  RealmResults<OTP>? pOTPCodes;

  @override
  void initState() {
    super.initState();

    pOTPCodes = gRealm.all<OTP>();

    debugPrint(pOTPCodes.toString());
  }

  List<OTP> filteredCodes() {
    List<OTP> filteredList = [];
    if (pOTPCodes != null) {
      var searchText = widget.searchString.toLowerCase();
      for (var otpCode in pOTPCodes!) {
        if (otpCode.title.toLowerCase().contains(searchText) ||
            otpCode.issuer!.toLowerCase().contains(searchText) ||
            searchText == '') {
          filteredList.add(otpCode);
        }
      }
    }
    return filteredList;
  }

// For testing purposes
  void pGenerateOTPCode(otp) {
    debugPrint(otp);
    // if (otp.title != "NP") {
    //   return;
    // }

    debugPrint(otp.secret);

    final code = pl_lotp.OTP.generateTOTPCodeString(
        otp.secret, DateTime.now().millisecondsSinceEpoch,
        length: 6, interval: 30, algorithm: pl_lotp.Algorithm.SHA1, isGoogle: true);
    debugPrint(code);
  }

  @override
  Widget build(BuildContext context) {
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
                OTPCodeBlock(
                    otpcode: otpcode,
                    onSelectedOTPCode: widget.onSelectedOTPCode
                    ),
                const SizedBox(
                  height: 4.0,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
