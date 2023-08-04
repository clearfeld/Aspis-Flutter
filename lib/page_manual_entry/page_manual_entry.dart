import 'package:aspis/page_manual_entry/IconSelector.dart';
import 'package:aspis/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:aspis/global_realm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:aspis/store/test.dart';
import 'package:aspis/components/flat_textfield.dart';

import 'package:aspis/components/flat_dropdown.dart';
import 'package:expandable/expandable.dart';
import 'package:aspis/singleton_otp_entry.dart';

class PageManualEntry extends ConsumerStatefulWidget {
  const PageManualEntry({super.key, this.fOTPCode});

  final OTP? fOTPCode;

  @override
  ConsumerState<PageManualEntry> createState() => _PageManualEntryState();
}

class _PageManualEntryState extends ConsumerState<PageManualEntry> {
  final titleTextController = TextEditingController();
  final secretTextController = TextEditingController();

  final issuerTextController = TextEditingController();

  final notesTextController = TextEditingController();

  final periodTextController = TextEditingController();

  final digitsTextController = TextEditingController();

  final usageTextController = TextEditingController();

  String iconType = "text";
  String? iconValue;

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
      iconType = widget.fOTPCode?.iconType ?? "text";
      iconValue = widget.fOTPCode?.iconValue;
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

  void setIconInformation(type, value) {
    iconType = type;
    iconValue = value;
  }

//   void _moreOptionSelected(int item) {
//     if (item == 0) {
//       //Navigator.push(
//       //  context,
//       //  PageRouteBuilder(
//       //    pageBuilder:
//       //        (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
//       //      return const PageAbout();
//       //    },
//       //    transitionDuration: Duration.zero,
//       //    reverseTransitionDuration: Duration.zero,
//       //  ),
//       //);
//     } else if (item == 1) {}
//   }

  void pSaveEntry() {
    if (widget.fOTPCode == null) {
      var o = OTP(
          ObjectId(),
          titleTextController.text,
          secretTextController.text,
          issuer: issuerTextController.text,
          group: groupValue,
          notes: notesTextController.text,
          iconType,
          iconValue: iconValue,
          typeValue,
          hashValue,
          int.parse(periodTextController.text),
          int.parse(digitsTextController.text),
          int.parse(usageTextController.text));

      gRealm.write(() {
        gRealm.addAll([o]);
      });

      // TODO(clearfeld): clean this disgusting
      ref.watch(OTPManagerProvider.notifier).setOTPList(gRealm.all<OTP>());
    } else {
      if (widget.fOTPCode != null) {
        var o = OTP(
            (widget.fOTPCode?.id as ObjectId),
            titleTextController.text,
            secretTextController.text,
            issuer: issuerTextController.text,
            group: groupValue,
            notes: notesTextController.text,
            iconType,
            iconValue: iconValue,
            typeValue,
            hashValue,
            int.parse(periodTextController.text),
            int.parse(digitsTextController.text),
            int.parse(usageTextController.text));

        gRealm.write(() {
          gRealm.add<OTP>(o, update: true);
        });

        ref.watch(OTPManagerProvider.notifier).setOTPList(gRealm.all<OTP>());
      }
    }

    Navigator.pop(context, "refresh");
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.page_add_entry__add_entry ?? ""),
        centerTitle: true,
        elevation: 0,
        backgroundColor: customColors.navbarBackground,
        surfaceTintColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () => {pSaveEntry()},
            child: (widget.fOTPCode == null)
                ? Text(AppLocalizations.of(context)?.page_add_entry__create ?? "",
                    style: TextStyle(
                      color: customColors.textColor,
                    ))
                : Text(AppLocalizations.of(context)?.page_add_entry__save ?? "",
                    style: TextStyle(
                      color: customColors.textColor,
                    )),
          ),

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
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 20.0, 8.0),
          child: Center(
            child: SizedBox(
              width: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 176,
                    child: IconSelector(
                        setIconInformation: setIconInformation,
                        iconType: iconType,
                        iconValue: iconValue),
                  ),
                  Divider(
                    color: customColors.border,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Icon(
                            Icons.person,
                            color: customColors.textColor,
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)?.page_add_entry__name ?? "",
                              style: TextStyle(fontSize: 16.0)),
                          const SizedBox(
                            height: 4,
                          ),
                          FlatTextField(
                            textController: titleTextController,
                            hintText: AppLocalizations.of(context)?.page_add_entry__name ?? "",
                          ),
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 32.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                (AppLocalizations.of(context)?.page_add_entry__issuer ?? "") +
                                    " (" +
                                    (AppLocalizations.of(context)?.page_add_entry__optional ?? "") +
                                    ")",
                                style: TextStyle(fontSize: 16.0)),
                            const SizedBox(
                              height: 4,
                            ),
                            FlatTextField(
                              textController: issuerTextController,
                              hintText: AppLocalizations.of(context)?.page_add_entry__issuer ?? "",
                            ),
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
                            Text(AppLocalizations.of(context)?.page_add_entry__group ?? "",
                                style: TextStyle(fontSize: 16.0)),
                            const SizedBox(
                              height: 4,
                            ),
                            FlatDropdown(
                              value: groupValue,
                              onValueChanged: (String? valueArg) {
                                setState(() {
                                  groupValue = valueArg!;
                                });
                              },
                              items: [
                                // TODO: FIXME:
                                "No Group" // AppLocalizations.of(context)?.page_add_entry__no_group ?? "",
                              ],
                            )
                          ],
                        ),
                      ),

                      //   Expanded(
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: <Widget>[
                      //         FlatDropdown(
                      //           value: groupValue,
                      //           hintText: "Group",
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
                    height: 16,
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Icon(
                            Icons.note,
                            color: customColors.textColor,
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (AppLocalizations.of(context)?.page_add_entry__note ?? "") +
                                " (" +
                                (AppLocalizations.of(context)?.page_add_entry__optional ?? "") +
                                ")",
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          FlatTextField(
                            textController: notesTextController,
                            hintText: AppLocalizations.of(context)?.page_add_entry__note ?? "",
                          ),
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Divider(
                    color: customColors.border,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ExpandablePanel(
                    header: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                          child: Text(
                            AppLocalizations.of(context)?.page_add_entry__advanced ?? "",
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                    theme: ExpandableThemeData(iconColor: customColors.textColor),
                    collapsed: const Column(children: []),
                    expanded: Column(children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Icon(
                                Icons.key,
                                color: customColors.textColor,
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)?.page_add_entry__secret ?? "",
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              FlatTextField(
                                textController: secretTextController,
                                hintText: AppLocalizations.of(context)?.page_add_entry__secret ?? "",
                                password: true,
                              ),
                            ],
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Icon(
                                Icons.info,
                                color: customColors.textColor,
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)?.page_add_entry__type ?? "",
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                FlatDropdown(
                                  value: typeValue,
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
                                Text(
                                  AppLocalizations.of(context)?.page_add_entry__hash_function ?? "",
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                FlatDropdown(
                                  value: hashValue,
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
                        height: 16,
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Icon(
                                Icons.timer,
                                color: customColors.textColor,
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)?.page_add_entry__period_seconds ?? "",
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                FlatTextField(
                                  textController: periodTextController,
                                  hintText: AppLocalizations.of(context)?.page_add_entry__period ?? "",
                                ),
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
                                Text(
                                  AppLocalizations.of(context)?.page_add_entry__length ?? "",
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                FlatTextField(
                                  textController: digitsTextController,
                                  hintText: AppLocalizations.of(context)?.page_add_entry__length ?? "",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 32.0,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)?.page_add_entry__usage_count ?? "",
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              FlatTextField(
                                textController: usageTextController,
                                hintText: AppLocalizations.of(context)?.page_add_entry__usage_count ?? "",
                                enabled: false,
                              ),
                            ],
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
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
