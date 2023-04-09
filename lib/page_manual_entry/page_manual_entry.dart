import 'package:aspis/page_manual_entry/IconSelector.dart';
import 'package:flutter/material.dart';

import 'package:aspis/global_realm.dart';
import 'package:realm/realm.dart';
import 'package:aspis/store/test.dart';
import 'package:aspis/components/flat_textfield.dart';

import 'package:aspis/components/flat_dropdown.dart';
import 'package:expandable/expandable.dart';
import 'package:aspis/singleton_otp_entry.dart';

class PageManualEntry extends StatefulWidget {
  const PageManualEntry({super.key, this.fOTPCode});

  final OTP? fOTPCode;

  @override
  State<PageManualEntry> createState() => _PageManualEntryState();
}

class _PageManualEntryState extends State<PageManualEntry> {
  final titleTextController = TextEditingController();
  final secretTextController = TextEditingController();

  final issuerTextController = TextEditingController();

  final notesTextController = TextEditingController();

  final periodTextController = TextEditingController();

  final digitsTextController = TextEditingController();

  final usageTextController = TextEditingController();

  String groupValue = "";
  String typeValue = "TOTP";
  String hashValue = "SHA1";

  @override
  void initState() {
    super.initState();

    // QUESTION(clearfeld): is this for the QR code scanner?
    if (newOtp.secret != "") {
      titleTextController.text = newOtp.name;
      secretTextController.text = newOtp.secret;
      issuerTextController.text = newOtp.issuer;
      periodTextController.text = newOtp.period;
      digitsTextController.text = newOtp.digits.toString();
      usageTextController.text = newOtp.counter;
      groupValue = "No Group";
      typeValue = newOtp.type.toUpperCase();
      hashValue = newOtp.algorithm;
    } else if (widget.fOTPCode != null) {
      titleTextController.text = widget.fOTPCode?.title ?? "";
      secretTextController.text = widget.fOTPCode?.secret ?? "";
      issuerTextController.text = widget.fOTPCode?.issuer ?? "";
      periodTextController.text = widget.fOTPCode?.period.toString() ?? "30";
      digitsTextController.text = widget.fOTPCode?.digits.toString() ?? "6";
      usageTextController.text = widget.fOTPCode?.usageCount.toString() ?? "0";
      groupValue = "No Group";
      typeValue = widget.fOTPCode?.type.toUpperCase() ?? "TOTP";
      hashValue = widget.fOTPCode?.hashFunc ?? "SHA1";
    } else {
      titleTextController.text = "";
      secretTextController.text = "";
      issuerTextController.text = "";
      periodTextController.text = "30";
      digitsTextController.text = "6";
      usageTextController.text = "0";
      groupValue = "No Group";
      typeValue = "TOTP";
      hashValue = "SHA1";
    }
  }

  @override
  void dispose() {
    titleTextController.dispose();
    secretTextController.dispose();
    issuerTextController.dispose();
    notesTextController.dispose();
    periodTextController.dispose();
    digitsTextController.dispose();
    usageTextController.dispose();
    super.dispose();
  }

  void _moreOptionSelected(int item) {
    if (item == 0) {
      //Navigator.push(
      //  context,
      //  PageRouteBuilder(
      //    pageBuilder:
      //        (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
      //      return const PageAbout();
      //    },
      //    transitionDuration: Duration.zero,
      //    reverseTransitionDuration: Duration.zero,
      //  ),
      //);
    } else if (item == 1) {}
  }

  void pSaveEntry() {
    if (widget.fOTPCode == null) {
      gRealm.write(() {
        gRealm.addAll([
          OTP(
              ObjectId(),
              titleTextController.text,
              secretTextController.text,
              issuer: issuerTextController.text,
              group: groupValue,
              notes: notesTextController.text,
              typeValue,
              hashValue,
              int.parse(periodTextController.text),
              int.parse(digitsTextController.text),
              int.parse(usageTextController.text))
        ]);
      });
    } else {
      if (widget.fOTPCode != null) {
        gRealm.write(() {
          gRealm.add<OTP>(
            OTP(
              (widget.fOTPCode?.id as ObjectId),
              titleTextController.text,
              secretTextController.text,
              issuer: issuerTextController.text,
              group: groupValue,
              notes: notesTextController.text,
              typeValue,
              hashValue,
              int.parse(periodTextController.text),
              int.parse(digitsTextController.text),
              int.parse(usageTextController.text)
           )
          , update: true);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Entry"),
        elevation: 0,
        backgroundColor: const Color(0xFF006699),
        actions: [
          TextButton(
              onPressed: () => {pSaveEntry()},
              child: const Text("Save",
                  style: TextStyle(
                    color: const Color(0xFFFCFCFC),
                  ))),
          //   PopupMenuButton(
          //     icon: const Icon(
          //       Icons.more_vert,
          //       color: Colors.white,
          //     ),
          //     itemBuilder: (context) => [
          //       const PopupMenuItem<int>(
          //         value: 0,
          //         child: Text(
          //           "Edit Icon",
          //         ),
          //       ),
          //       const PopupMenuItem<int>(
          //         value: 1,
          //         child: Text(
          //           "Reset Usage Count",
          //         ),
          //       ),
          //     ],
          //     onSelected: (item) => {_moreOptionSelected(item)},
          //   ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              width: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 160,
                    child: IconSelector(),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: FlatTextField(
                          textController: titleTextController,
                          labelText: "Title",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.key,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: FlatTextField(
                          textController: secretTextController,
                          labelText: "Secret",
                          password: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 24.0,
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FlatTextField(
                              textController: issuerTextController,
                              labelText: "Issuer (optional)",
                            ),
                          ],
                        ),
                      ),

                      //   const SizedBox(
                      //     width: 16.0,
                      //   ),

                      //   Expanded(
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: <Widget>[
                      //         FlatDropdown(
                      //           value: groupValue,
                      //           labelText: "Group",
                      //           onValueChanged: (String? valueArg) {
                      //             setState(() {
                      //               groupValue = valueArg!;
                      //             });
                      //           },
                      //           items: const ["No Group", "fdsa", "qwer"],
                      //         )
                      //       ],
                      //     ),
                      //   ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.sort,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: FlatTextField(
                          textController: notesTextController,
                          labelText: "Notes (optional)",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ExpandablePanel(
                    header: const Padding(
                      padding: EdgeInsets.only(left: 4.0, top: 8),
                      child: Text(
                        "Advanced",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    theme: const ExpandableThemeData(iconColor: Colors.white),
                    collapsed: Column(children: const []),
                    expanded: Column(children: [
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FlatDropdown(
                                  value: typeValue,
                                  labelText: "Type",
                                  onValueChanged: (String? valueArg) {
                                    setState(() {
                                      typeValue = valueArg!;
                                    });
                                  },
                                  items: const ["TOTP", "HOTP"], // , "Stream", "Yandex", "MOTP"],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FlatDropdown(
                                  value: hashValue,
                                  labelText: "Hash Function",
                                  onValueChanged: (String? valueArg) {
                                    setState(() {
                                      hashValue = valueArg!;
                                    });
                                  },
                                  items: const ["SHA1", "SHA256", "SHA512"],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 24.0,
                          ),
                          Expanded(
                            child: FlatTextField(
                              textController: periodTextController,
                              labelText: "Period (Seconds)",
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: FlatTextField(
                              textController: digitsTextController,
                              labelText: "Digits",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 24.0,
                          ),
                          Expanded(
                            child: FlatTextField(
                              textController: usageTextController,
                              labelText: "Usage Count",
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
