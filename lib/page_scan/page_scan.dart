import 'package:aspis/page_manual_entry/page_manual_entry.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:aspis/otp_entry.dart';
import 'package:aspis/singleton_otp_entry.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile Scanner"),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  // as TorchState
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  // as CameraFacing
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: _foundBarcode,
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _foundBarcode(BarcodeCapture barcode) {
    /// open screen
    if (!_screenOpened) {
      final List<Barcode> barcodes = barcode.barcodes;
      _screenOpened = true;
      //otpauth://totp/Google%3Aaaronpatters%40gmail.com?secret=yd5bxaf365ptlyzy2t3gvdbudsaxv6yn&issuer=Google
      String otpString = Uri.decodeFull(barcodes.first.rawValue!);

      var uri = Uri.parse(otpString);
      uri.queryParameters.forEach((k, v) {
        switch (k) {
          case 'secret':
            {
              newOtp.secret = v;
            }
            break;
          case 'issuer':
            {
              newOtp.issuer = v;
            }
            break;
          case 'algorithm':
            {
              newOtp.algorithm = v;
            }
            break;
          case 'digits':
            {
              newOtp.digits = int.parse(v);
            }
            break;
          case 'counter':
            {
              newOtp.counter = v;
            }
            break;
          case 'period':
            {
              newOtp.period = v;
            }
            break;
          default:
            {}
        }
      });

      try {
        otpString = otpString.substring(10);
        var otpList = otpString.split('/');
        newOtp.type = otpList[0];
        otpString = otpList[1];
        otpList = otpString.split(':');
        otpString = otpList[1];
        otpList = otpString.split('?');
        newOtp.name = otpList[0];

        if (newOtp.type != 'totp' && newOtp.type != 'hotp') {
          newOtp = OtpEntry();
          throw "Invalid Token1";
        }
        if (newOtp.secret == '') {
          newOtp = OtpEntry();
          throw "Invalid Token2";
        }
        if (newOtp.issuer == '') {
          newOtp = OtpEntry();
          throw "Invalid Token3";
        }
        if (newOtp.counter == '') {
          if (newOtp.type == 'hotp') {
            newOtp = OtpEntry();
            throw "Invalid Token4";
          } else {
            newOtp.counter = '0';
          }
        }
        if (newOtp.period == '') {
          if (newOtp.type == 'hotp') {
            newOtp = OtpEntry();
            throw "Invalid Token5";
          } else {
            newOtp.period = '30';
          }
        }
        if (newOtp.algorithm == '') {
          newOtp.algorithm = 'SHA1';
        }
      } catch (e) {
        Navigator.pop(context);
      }

      barcode = BarcodeCapture(barcodes: [], raw: []);
      //Navigator.pop(context);
      //Navigator.pop(context);

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
        ).then(
          (value) {
            newOtp = OtpEntry();
            Navigator.pop(context);
          },
        );
      }

      //Navigator.push(context, MaterialPageRoute(builder: (context) =>
      //    FoundCodeScreen(screenClosed: _screenWasClosed, value: barcodes),));
    }
  }

//   void _screenWasClosed() {
//     _screenOpened = false;
//   }
}

class FoundCodeScreen extends StatefulWidget {
  final List<Barcode> value;
  final Function() screenClosed;
  const FoundCodeScreen({
    Key? key,
    required this.value,
    required this.screenClosed,
  }) : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Found Code"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
      ),
    );
  }
}
