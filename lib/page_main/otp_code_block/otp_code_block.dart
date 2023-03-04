import 'package:aspis/store/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OTPCodeBlock extends StatefulWidget {
  const OTPCodeBlock({super.key, required this.otpcode});

  final OTP otpcode;

  @override
  State<OTPCodeBlock> createState() => _OTPCodeBlockState();
}

class _OTPCodeBlockState extends State<OTPCodeBlock> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(children: <Widget>[
            Text(widget.otpcode.title),
            const Text("  "),
            Text(widget.otpcode.issuer ?? ""),
            Container(
              width: 128.0,
              height: 128.0,
              padding: const EdgeInsets.all(30.0),
              child: SvgPicture.asset("assets/aegis_icons/icons/1_Primary/Allegro.svg",
                  semanticsLabel: 'Acme Logo'),
            ),
          ]),
        ],
      ),
    );
  }
}
