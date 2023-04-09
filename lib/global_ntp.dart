import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntp/ntp.dart';

late DateTime gNTPTime;

Future<void> gGetNTPTime() async {
  DateTime myTime;

  /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
  myTime = DateTime.now();

  /// Or get NTP offset (in milliseconds) and add it yourself
  final int offset =
      await NTP.getNtpOffset(
        localTime: myTime,
        lookUpAddress: "time.google.com" // lookupAddress
      );

  gNTPTime = myTime.add(Duration(milliseconds: offset));

//   debugPrint('\n==== $lookupAddress ====');
//   debugPrint('My time: $_myTime');
//   debugPrint('NTP time: $gNTPTime');
//   debugPrint('Difference: ${_myTime.difference(gNTPTime).inMilliseconds}ms');

  return;
}


final refreshProvider = StateProvider<bool>((ref) {
  return false;
});
