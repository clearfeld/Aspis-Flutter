import 'package:aspis/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:aspis/page_manual_entry/page_manual_entry.dart';
import 'package:aspis/page_scan/page_scan.dart';
import 'dart:async';
import 'package:aspis/singleton_otp_entry.dart';
import 'package:flutter/foundation.dart';

class FabButton extends StatelessWidget {
  FabButton({super.key});

  FutureOr refreshHabitList(BuildContext context) {
    if (newOtp.secret != "") {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder:
              (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
            return PageManualEntry();
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  final isMobile = defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>();
    return FloatingActionButton(
      // tooltip: 'FAB',
      elevation: 0,
      backgroundColor: const Color(0xFF006699),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              color: customColors!.background,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // const Text('Modal BottomSheet'),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customColors.buttonPrimary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        fixedSize: Size(240, 32),
                      ),
                      child: Text(
                        AppLocalizations.of(context)?.home_page__enter_manually ?? "",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (BuildContext context, Animation<double> animation1,
                                Animation<double> animation2) {
                              return PageManualEntry();
                            },
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 8.0,
                    ),

                    if (isMobile) ...[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: customColors.buttonPrimary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          fixedSize: Size(240, 32),
                        ),
                        child: const Text(
                          'Scan QR Code - mobile only',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (BuildContext context, Animation<double> animation1,
                                  Animation<double> animation2) {
                                return const ScanPage();
                              },
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        },
                      ),
                    ],

                    const SizedBox(
                      height: 8.0,
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customColors.buttonGrey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        fixedSize: Size(240, 32),
                      ),
                      child: Text(
                        AppLocalizations.of(context)?.home_page__close ?? "",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
