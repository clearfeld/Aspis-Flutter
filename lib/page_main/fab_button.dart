import 'package:flutter/material.dart';

import 'package:aspis/page_manual_entry/page_manual_entry.dart';
import 'package:aspis/page_scan/page_scan.dart';
import 'dart:async';
import 'package:aspis/singleton_otp_entry.dart';

class FabButton extends StatelessWidget {
  const FabButton({super.key});

    FutureOr refreshHabitList(BuildContext context) {
      if (newOtp.secret != "") {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
              return const PageManualEntry();
            },
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      };
    }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'FAB',
      elevation: 0,
      child: const Icon(Icons.add),
      backgroundColor: const Color(0xFF006699),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              color: Colors.grey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Modal BottomSheet'),
                    ElevatedButton(
                        child: const Text('Enter Manually'),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (BuildContext context, Animation<double> animation1,
                                  Animation<double> animation2) {
                                return const PageManualEntry();
                              },
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        }),
                    ElevatedButton(
                      child: const Text('Scan QR Code - mobile only'),
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
                    ElevatedButton(
                      child: const Text('Close BottomSheet'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
