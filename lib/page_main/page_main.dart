import 'package:aspis/components/flat_textfield.dart';
import 'package:aspis/global_realm.dart';
import 'package:aspis/page_main/otp_code_block/otp_code_block.dart';
import 'package:aspis/page_main/refresh_timer.dart';
import 'package:aspis/page_manual_entry/page_manual_entry.dart';
import 'package:aspis/singleton_otp_entry.dart';
import 'package:aspis/store/test.dart';
import 'package:aspis/theme.dart';
import 'package:flutter/material.dart';

import 'package:aspis/page_main/fab_button.dart';

import 'package:aspis/page_settings/page_settings.dart';
import 'package:aspis/page_about/page_about.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:realm/realm.dart';

enum EAppbarState {
  none,
  search,
  selected,
}

class PageMain extends ConsumerStatefulWidget {
  const PageMain({super.key});

  @override
  ConsumerState<PageMain> createState() => _PageMainState();
}

class _PageMainState extends ConsumerState<PageMain> {
  final searchTextController = TextEditingController();
  EAppbarState appbarState = EAppbarState.none;
  var selectedOTP = null;

  // RealmResults<OTP>? pOTPCodes;

  @override
  void initState() {
    super.initState();

    var pOTPCodes = gRealm.all<OTP>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(OTPManagerProvider.notifier).setOTPList(pOTPCodes);

      setState(() {});
      //   final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      //   authViewModel.getToken();
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchTextController.dispose();
  }

//   List<OTP> filteredCodes() {
//     List<OTP> filteredList = [];
//     if (pOTPCodes != null) {
//       var searchText = searchTextController.text.toLowerCase();
//       for (var otpCode in pOTPCodes!) {
//         if (otpCode.title.toLowerCase().contains(searchText) ||
//             otpCode.issuer!.toLowerCase().contains(searchText) ||
//             searchText == '') {
//           filteredList.add(otpCode);
//         }
//       }
//     }
//     return filteredList;
//   }

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
    final customColors = Theme.of(context).extension<CustomColors>();
    RealmResults<OTP>? pOTPCodes = ref.watch(OTPManagerProvider); // .notifier).state;
    // print(pOTPCodes);

    AppBar vappBar;
    if (appbarState == EAppbarState.search) {
      vappBar = AppBar(
          backgroundColor: customColors!.navbarBackground,
          elevation: 0,
          // The search area here
          title: SizedBox(
            width: double.infinity,
            height: 40,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatTextField(
                    textController: searchTextController,
                    hintText: "Search",
                    backgroundColor: customColors.backgroundCompliment!,
                    prefixIcon: Icons.search,
                  ),
                ),
                SizedBox(width: 10,),
                Center(
                  child: Container(
                    width: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: customColors.buttonGrey,
                    ),
                    child: SizedBox(
                      child: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white,),
                        onPressed: () {
                          searchTextController.text = '';
                          setState(() {
                            appbarState = EAppbarState.none;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
    } else if (appbarState == EAppbarState.selected) {
      vappBar = AppBar(
        elevation: 0,
        backgroundColor: customColors!.navbarBackground,
        surfaceTintColor: Colors.transparent,
        title: IconButton(
          onPressed: () => {
            setState(() {
              appbarState = EAppbarState.none;
              selectedOTP = null;
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
            onPressed: () {
              setState(() {
                appbarState = EAppbarState.none;
              });

              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (BuildContext context, Animation<double> animation1,
                      Animation<double> animation2) {
                    return PageManualEntry(
                      fOTPCode: selectedOTP,
                    );
                  },
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            icon: Icon(
              Icons.edit,
              color: customColors.textColor,
            ),
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
            icon: Icon(
              Icons.more_vert,
              color: customColors.textColor,
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
        backgroundColor: customColors!.navbarBackground,
        actions: [
          IconButton(
              onPressed: () => {
                    setState(() {
                      appbarState = EAppbarState.search;
                    })
                  },
              icon: const Icon(Icons.search)),
          if (ref.watch(themeProvider) == ThemeMode.dark) ...[
              IconButton(
                icon: const Icon(
                  Icons.light_mode,
                ),
                onPressed: () {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
              ),
            ] else if (ref.watch(themeProvider) == ThemeMode.light) ...[
              IconButton(
                icon: const Icon(
                  Icons.dark_mode,
                ),
                onPressed: () {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
              ),
            ],
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "About",
                ),
              ),
              //   const PopupMenuItem<int>(
              //     value: 1,
              //     child: Text(
              //       "Settings",
              //     ),
              //   ),
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

          const SizedBox(
            height: 4.0,
          ),

          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 4,
                  children: <Widget>[
                    //   const SizedBox(
                    //     height: 16,
                    //   ),
                    if (pOTPCodes != null)
                      for (var otpcode in pOTPCodes) ...[
                        /// filteredCodes()) ...[
                        OTPCodeBlock(
                            otpcode: otpcode,
                            onSelectedOTPCode: selectOTPCode,
                            selectedOTP: selectedOTP),
                        // const SizedBox(
                        //   height: 4.0,
                        // ),
                      ],
                    const SizedBox(
                      height: 4.0,
                    ),
                    if (pOTPCodes != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Showing "), Text("${pOTPCodes.length}", style: const TextStyle(fontWeight: FontWeight.bold),), const Text(' Entries')
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FabButton(),
    );
  }
}
