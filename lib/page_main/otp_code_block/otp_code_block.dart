import 'dart:ui';

import 'package:aspis/store/test.dart';
import 'package:aspis/theme.dart';
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

class _OTPCodeBlockState extends State<OTPCodeBlock> with TickerProviderStateMixin {
  String? OTPCode;
  AnimationController? controller;

  @override
  void initState() {
    super.initState();

    GenerateOTPCode(widget.otpcode);
    // OTPCodes = gRealm.all<OTP>();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
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
    final customColors = Theme.of(context).extension<CustomColors>();

    return GestureDetector(
      onTap: () async {
        if (OTPCode != null) {
          await Clipboard.setData(ClipboardData(text: OTPCode));
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        // color: customColors!.background,
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: customColors!.background,
          boxShadow: [
            BoxShadow(color: customColors.background ?? Colors.red, spreadRadius: 4),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 88.0,
                  height: 88.0,
                  padding: const EdgeInsets.all(16.0),
                  child: SvgPicture.asset("assets/aegis_icons/icons/1_Primary/Allegro.svg",
                      semanticsLabel: 'Acme Logo'),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(widget.otpcode.issuer ?? ""),
                          if (widget.otpcode.issuer != null) ...[
                            const Text("  "),
                          ],
                          Text(widget.otpcode.title),
                        ],
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            OTPCode ?? "",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text("Counter"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
