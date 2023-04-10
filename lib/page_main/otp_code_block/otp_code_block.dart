import 'dart:async';

import 'package:aspis/global_ntp.dart';
import 'package:aspis/store/test.dart';
import 'package:aspis/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otp/otp.dart' as pl_lotp;
import 'package:flutter/services.dart';
// import 'package:realm/realm.dart';

class OTPCodeBlock extends ConsumerStatefulWidget {
  const OTPCodeBlock(
      {super.key,
      required this.otpcode,
      required this.onSelectedOTPCode,
      required this.selectedOTP});

  final OTP otpcode;
  final Function(OTP) onSelectedOTPCode;

  // TODO(clearfeld): do a smarter highlight
  final OTP? selectedOTP;

  @override
  ConsumerState<OTPCodeBlock> createState() => _OTPCodeBlockState();
}

class _OTPCodeBlockState extends ConsumerState<OTPCodeBlock> {
  String? sOTPCode;
  AnimationController? controller;
  Timer? periodicTimer;

  @override
  void initState() {
    super.initState();

    pGenerateOTPCode(widget.otpcode);
    // OTPCodes = gRealm.all<OTP>();
    // controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 5),
    // );
    // print(OTPCodes);

    // periodicTimer =
    //     Timer.periodic(const Duration(seconds: 30), (Timer t) => pGenerateOTPCode(widget.otpcode));
  }

  @override
  void dispose() {
    super.dispose();
    periodicTimer?.cancel();
  }

  void pGenerateOTPCode(otp) {
    // debugPrint(otp.toString());
    // debugPrint(otp.secret);

    try {
      final code = pl_lotp.OTP.generateTOTPCodeString(
          otp.secret, DateTime.now().millisecondsSinceEpoch,
          length: 6, interval: 30, algorithm: pl_lotp.Algorithm.SHA1, isGoogle: true);
      // debugPrint(code);

      setState(() {
        sOTPCode = code;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>();

    var isSelected = BoxShadow(color: customColors?.background ?? Colors.red, spreadRadius: 4);
    if (widget.otpcode.id == widget.selectedOTP?.id) {
      isSelected = const BoxShadow(color: Colors.blue, spreadRadius: 4);
    }

    final refresh = ref.watch(refreshProvider);
    if (refresh) {
      pGenerateOTPCode(widget.otpcode);
    }

    return GestureDetector(
      onTap: () async {
        if (sOTPCode != null) {
          await Clipboard.setData(ClipboardData(text: sOTPCode));
          //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //   content: Text("Copied"),
          // ));
        }
      },
      onLongPressStart: ((details) {
        // debugPrint(details);
        // callback();

        widget.onSelectedOTPCode(widget.otpcode);
      }),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        // color: customColors!.background,
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: customColors!.background,
          boxShadow: [
            isSelected
            // BoxShadow(color: customColors.background ?? Colors.red, spreadRadius: 4),
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
                  child: SvgPicture.asset(
                      widget.otpcode.iconValue ?? "assets/aegis_icons/icons/3_Generic/User.svg",
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
                      const SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            sOTPCode ?? "",
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // const Text("Counter"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
