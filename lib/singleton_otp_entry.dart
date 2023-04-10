import 'package:aspis/otp_entry.dart';
import 'package:aspis/store/test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

var newOtp = OtpEntry();

final OTPManagerProvider = StateNotifierProvider<OTPItemManager, RealmResults<OTP>?>((ref) {
  return OTPItemManager();
});

class OTPItemManager extends StateNotifier<RealmResults<OTP>?> {
  OTPItemManager([RealmResults<OTP>? otps]) : super(otps);

  void setOTPList(RealmResults<OTP>? list) {
    state = list;
  }

//   void addOTP(OTP nh) {
//     if (state != null) {
//       state = [
//         (...?state as RealmResults<OTP>),
//         nh
//       ];// as RealmResults<OTP>?;
//     }
//   }
}
