import 'dart:async';

import 'package:aspis/global_ntp.dart';
// import 'package:aspis/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefreshTimer extends ConsumerStatefulWidget {
  const RefreshTimer({
    super.key,
    // required this.otpcode, required this.onSelectedOTPCode
  });

//   final OTP otpcode;
//   final Function(OTP) onSelectedOTPCode;

  @override
  ConsumerState<RefreshTimer> createState() => _RefreshTimerState();
}

class _RefreshTimerState extends ConsumerState<RefreshTimer> with TickerProviderStateMixin {
  Timer? periodicTimer;
  double elapse = 0.0;
  double normalized = 1.0;

  @override
  void initState() {
    super.initState();

    // TODO(clearfeld): should at this point set the elapse relative to the ntptime
    // do this before the initial release
    // gNTPTime;

    periodicTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (elapse >= 30) {
        setState(() {
          elapse = 0.0;
          normalized = 1.0;
        });

        ref.read(refreshProvider.notifier).state = !ref.read(refreshProvider.notifier).state;
      } else {
        setState(() {
          elapse = elapse + 1.0;
          normalized = 1.0 - (
              pNormalize(
                elapse,
                0.0,
                30.0,
                0.0,
                100.0,
              ) / 100);

              ref.read(refreshProvider.notifier).state = false;
        });

        // debugPrint(normalized);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    periodicTimer?.cancel();
  }

  double pNormalize(double val, double valmin, double valmax, double min, double max) {
    return ((val - valmin) / (valmax - valmin)) * (max - min) + min;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 4.0,
        minWidth: 1.0,
        maxHeight: 4.0,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      width: MediaQuery.of(context).size.width * normalized,
      color: Colors.red,
    );
  }
}
