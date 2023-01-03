import 'package:flutter/material.dart';

import 'package:aspis/components/flat_textfield.dart';
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

  @override
  void initState() {
    super.initState();
    titleTextController.text = "";
    secretTextController.text = "";
    issuerTextController.text = "";
    notesTextController.text = "";
  }

  @override
  void dispose() {
    titleTextController.dispose();
    secretTextController.dispose();
    issuerTextController.dispose();
    notesTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Entry"),
        elevation: 0,
        backgroundColor: const Color(0xFF006699),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text("Title"),
                      Expanded(
                        child: FlatTextField(
                          textController: titleTextController,
                          hintText: "Title",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Text("Secret"),
                      Expanded(
                        child: FlatTextField(
                          textController: secretTextController,
                          hintText: "Secret",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Text("Issuer (optional)"),
                      Expanded(
                        child: FlatTextField(
                          textController: issuerTextController,
                          hintText: "Issuer (optional)",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const <Widget>[Text("Group")],
                  ),
                  Row(
                    children: <Widget>[
                      const Text("Notes"),
                      Expanded(
                        child: FlatTextField(
                          textController: notesTextController,
                          hintText: "Notes (optional)",
                        ),
                      ),
                    ],
                  ),
                  const Text("Advance"),
                  Row(
                    children: const <Widget>[Text("Type")],
                  ),
                  Row(
                    children: const <Widget>[Text("Hash function")],
                  ),
                  Row(
                    children: const <Widget>[Text("Period (seconds)")],
                  ),
                  Row(
                    children: const <Widget>[Text("Digits")],
                  ),
                  Row(
                    children: const <Widget>[Text("Usage count")],
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
