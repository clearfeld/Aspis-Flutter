import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:aspis/global_realm.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realm/realm.dart';
import 'package:aspis/store/test.dart';
import 'package:aspis/components/flat_textfield.dart';

import 'package:aspis/components/flat_dropdown.dart';
import 'package:expandable/expandable.dart';
import 'package:aspis/singleton_otp_entry.dart';

class IconSelector extends StatefulWidget {
  const IconSelector({super.key});

  @override
  State<IconSelector> createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {
  final searchTextController = TextEditingController();
  var someImages;
  var currentIcon = "assets/aegis_icons/icons/1_Primary/Allegro.svg";

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    print(manifestContent);

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('aegis_icons/'))
        .where((String key) => key.contains('.svg'))
        .toList();

    print(imagePaths);

// someImages = imagePaths;
    setState(() {
      someImages = imagePaths;
    });
  }

  @override
  void initState() {
    super.initState();

    searchTextController.text = "";

    _initImages();
  }

  @override
  void dispose() {
    searchTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.height * 0.8,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        TextButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          child: const Text('Close BottomSheet'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: GridView.builder(
                            itemCount: someImages.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: InkWell(
                                  child: Container(
                                    //   width: 88.0,
                                    //   height: 88.0,
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(someImages[index],
                                        semanticsLabel: someImages[index]),
                                  ),

                                  onTap: () {
                                    setState(() {
                                      currentIcon = someImages[index];
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },

          child: Container(
            width: 88.0,
            height: 88.0,
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(currentIcon, semanticsLabel: currentIcon),
          ),

        ),
      ]),
    );
  }
}
