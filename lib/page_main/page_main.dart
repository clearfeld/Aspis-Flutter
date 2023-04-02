import 'package:aspis/global_realm.dart';
import 'package:aspis/page_main/otp_code_block/otp_code_block.dart';
import 'package:flutter/material.dart';

import 'package:aspis/page_main/fab_button.dart';

import 'package:aspis/page_settings/page_settings.dart';
import 'package:aspis/page_about/page_about.dart';

import 'package:aspis/page_main/test_realm.dart';
import 'package:realm/realm.dart';
import 'package:aspis/store/test.dart';

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  final searchTextController = TextEditingController();
  RealmResults<OTP>? otpCodes = gRealm.all<OTP>();
  bool search = false;

  @override
  void dispose() {
    super.dispose();
    searchTextController.dispose();
  }

  List<OTP> filteredCodes() {
    List<OTP> filteredList = [];
    if (otpCodes != null) {
      var searchText = searchTextController.text.toLowerCase();
      for (var otpCode in otpCodes!) {
        if (otpCode.title.toLowerCase().contains(searchText) ||
            otpCode.issuer!.toLowerCase().contains(searchText) ||
            searchText == '') {
          filteredList.add(otpCode);
        }
      }
    }
    return filteredList;
  }

  void _moreOptionSelected(int item) {
    if (item == 0) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder:
              (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
            return const PageAbout();
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (item == 1) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder:
              (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
            return const PageSettings();
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (search) {
      return WillPopScope(
          onWillPop: () async {
            searchTextController.text = '';
            setState(() {
              search = false;
            });
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
                backgroundColor: const Color(0xFF006699),
                // The search area here
                title: Container(
                  width: double.infinity,
                  height: 40,
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: TextField(
                      controller: searchTextController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              /* Clear the search field */
                              setState(() {
                                searchTextController.text = '';
                              });
                            },
                          ),
                          hintText: 'Search...',
                          border: InputBorder.none),
                      onChanged: (value) => {setState(() {})},
                    ),
                  ),
                )),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 16,
                          ),
                          for (var otpcode in filteredCodes()) ...[
                            OTPCodeBlock(otpcode: otpcode),
                            const SizedBox(
                              height: 4.0,
                            ),
                          ],
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: const FabButton(),
          ));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aspis"),
        elevation: 0,
        backgroundColor: const Color(0xFF006699),
        actions: [
          IconButton(
              onPressed: () => {
                    setState(() {
                      search = true;
                    })
                  },
              icon: const Icon(Icons.search)),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "About",
                ),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text(
                  "Settings",
                ),
              ),
            ],
            onSelected: (item) => {_moreOptionSelected(item)},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TestRealm(),
          ],
        ),
      ),
      floatingActionButton: const FabButton(),
    );
  }
}
