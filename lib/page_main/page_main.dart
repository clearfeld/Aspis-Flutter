import 'dart:async';

import 'package:aspis/global_realm.dart';
import 'package:aspis/page_main/refresh_timer.dart';
import 'package:aspis/store/test.dart';
import 'package:flutter/material.dart';

import 'package:aspis/page_main/fab_button.dart';

import 'package:aspis/page_settings/page_settings.dart';
import 'package:aspis/page_about/page_about.dart';

import 'package:aspis/page_main/test_realm.dart';

enum EAppbarState {
  none,
  search,
  selected,
}

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  final searchTextController = TextEditingController();
  EAppbarState appbarState = EAppbarState.none;
  var selectedOTP = null;

  @override
  void dispose() {
    super.dispose();
    searchTextController.dispose();
  }

  void selectOTPCode(arg) {
    setState(() {
      selectedOTP = arg;
      appbarState = EAppbarState.selected;
    });
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

  void _moreOptionSelected_Selected(int item) {
    if (item == 0) {
      if (selectedOTP != null) {
        // print(selectedOTP);
        gRealm.write(() {
          gRealm.delete<OTP>(selectedOTP);
        });

        setState(() {
          selectedOTP = null;
          appbarState = EAppbarState.none;
        });
      }
    }
    // } else if (item == 1) {
    //   Navigator.push(
    //     context,
    //     PageRouteBuilder(
    //       pageBuilder:
    //           (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
    //         return const PageSettings();
    //       },
    //       transitionDuration: Duration.zero,
    //       reverseTransitionDuration: Duration.zero,
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    AppBar vappBar;
    if (appbarState == EAppbarState.search) {
      vappBar = AppBar(
          backgroundColor: const Color(0xFF006699),
          elevation: 0,
          // The search area here
          title: SizedBox(
            width: double.infinity,
            height: 40,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: searchTextController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search...',
                        border: InputBorder.none),
                    onChanged: (value) => {setState(() {})},
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 48.0,
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchTextController.text = '';
                        setState(() {
                          appbarState = EAppbarState.none;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ));
    } else if (appbarState == EAppbarState.selected) {
      vappBar = AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF006699),
        title: IconButton(
          onPressed: () => {
            setState(() {
              appbarState = EAppbarState.none;
            })
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          //   IconButton(
          //     onPressed: () => {
          //       setState(() {
          //         appbarState = EAppbarState.none;
          //       })
          //     },
          //     icon: const Icon(Icons.copy),
          //   ),

          IconButton(
            onPressed: () => {
              setState(() {
                appbarState = EAppbarState.none;
              })
            },
            icon: const Icon(Icons.edit),
          ),

          //   IconButton(
          //     onPressed: () => {
          //       setState(() {
          //         appbarState = EAppbarState.none;
          //       })
          //     },
          //     icon: const Icon(Icons.qr_code),
          //   ),

          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "Delete",
                ),
              ),
              //   const PopupMenuItem<int>(
              //     value: 1,
              //     child: Text(
              //       "Settings",
              //     ),
              //   ),
            ],
            onSelected: (item) => {_moreOptionSelected_Selected(item)},
          ),
        ],
      );
    } else {
      vappBar = AppBar(
        title: const Text("Aspis"),
        elevation: 0,
        backgroundColor: const Color(0xFF006699),
        actions: [
          IconButton(
              onPressed: () => {
                    setState(() {
                      appbarState = EAppbarState.search;
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
      );
    }

    return Scaffold(
      appBar: vappBar,
      body: Column(
        children: [

          Row(
            children: const <Widget>[
              RefreshTimer(),
            ],
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TestRealm(
                      searchString: searchTextController.text, onSelectedOTPCode: selectOTPCode),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FabButton(),
    );
  }
}
