import 'package:flutter/material.dart';

import 'package:aspis/page_main/fab_button.dart';

import 'package:aspis/page_settings/page_settings.dart';
import 'package:aspis/page_about/page_about.dart';

import 'package:aspis/page_main/test_realm.dart';

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  final searchTextController = TextEditingController();
  bool search = false;

  @override
  void dispose() {
    super.dispose();
    searchTextController.dispose();
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
    AppBar vappBar;
    if (search) {
      vappBar = AppBar(
          backgroundColor: const Color(0xFF006699),
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
                          search = false;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ));
    } else {
      vappBar = AppBar(
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
      );
    }

    return Scaffold(
      appBar: vappBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TestRealm(
              searchString: searchTextController.text,
            ),
          ],
        ),
      ),
      floatingActionButton: FabButton(),
    );
  }
}
