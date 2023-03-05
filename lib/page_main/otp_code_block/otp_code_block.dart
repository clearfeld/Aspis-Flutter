import 'dart:ui';

import 'package:aspis/store/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otp/otp.dart' as LOTP;
import 'package:flutter/services.dart';

class OTPCodeBlock extends StatefulWidget {
  const OTPCodeBlock({super.key, required this.otpcode});

  final OTP otpcode;

  @override
  State<OTPCodeBlock> createState() => _OTPCodeBlockState();
}

class _OTPCodeBlockState extends State<OTPCodeBlock> {
  String? OTPCode;

  @override
  void initState() {
    super.initState();

    GenerateOTPCode(widget.otpcode);
    // OTPCodes = gRealm.all<OTP>();

    // print(OTPCodes);
  }

  void GenerateOTPCode(otp) {
    print(otp);
    print(otp.secret);

    try {
      final code = LOTP.OTP.generateTOTPCodeString(
          otp.secret, DateTime.now().millisecondsSinceEpoch,
          length: 6, interval: 30, algorithm: LOTP.Algorithm.SHA1, isGoogle: true);
      print(code);
      OTPCode = code;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (OTPCode != null) {
          await Clipboard.setData(ClipboardData(text: OTPCode));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 112.0,
                height: 112.0,
                padding: const EdgeInsets.all(30.0),
                child: SvgPicture.asset("assets/aegis_icons/icons/1_Primary/Allegro.svg",
                    semanticsLabel: 'Acme Logo'),
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(widget.otpcode.title),
                      const Text("  "),
                      Text(widget.otpcode.issuer ?? ""),
                    ],
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    OTPCode ?? "",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
              Text("Counter"),
            ],
          ),
        ],
      ),
    );
  }
}
