import 'package:flutter/material.dart';

import 'package:aspis/components/flat_textfield.dart';

import '../components/flat_dropdown.dart';
import 'package:expandable/expandable.dart';
// import 'package:aspis/components/flat_dropdown.dart';

class PageManualEntry extends StatefulWidget {
  const PageManualEntry({super.key});

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
  String typeValue = "";
  String hashValue = "";

  @override
  void initState() {
    super.initState();
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
    } else if (item == 1) {
      print("1" * 100);
    }
  }
  void _save_entry() {
    print(titleTextController.text);
    print(secretTextController.text);
    print(issuerTextController.text);
    print(notesTextController.text);
    print(periodTextController.text);
    print(digitsTextController.text);
    print(usageTextController.text);
    print(groupValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Entry"),
        elevation: 0,
        backgroundColor: const Color(0xFF006699),
        actions: [
          TextButton(onPressed: () => {_save_entry()}, child: const Text("Save")),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "Edit Icon",
                ),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text(
                  "Reset Usage Count",
                ),
              ),
            ],
            onSelected: (item) => {_moreOptionSelected(item)},
          ),
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
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.black,
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
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.key,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: FlatTextField(
                          textController: secretTextController,
                          labelText: "Secret",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
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
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FlatDropdown(
                              value: groupValue,
                              labelText: "Group",
                              onValueChanged: (String? valueArg) {
                                setState(() {
                                  groupValue = valueArg!;
                                });
                              },
                              items: ["No Group","fdsa","qwer"],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.sort,
                        color: Colors.black,
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
                    height: 5,
                  ),
                  ExpandablePanel(
                    header: Padding(
                      padding: EdgeInsets.only(left: 24.0, top: 10),
                      child: Text("Advanced",
                              textAlign: TextAlign.left,
                            ),
                    ),
                    collapsed: Column(children: []),
                    expanded: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.info,
                              color: Colors.black,
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
                                    items: ["TOTP","HOTP","Stream","Yandex","MOTP"],
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
                                    items: ["SHA1","SHA256","SHA512"],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
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
                          height: 5,
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
                          height: 5,
                        ),
                      ]
                    ),
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
