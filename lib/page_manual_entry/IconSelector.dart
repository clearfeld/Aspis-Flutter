import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconSelector extends StatefulWidget {
  const IconSelector({
    super.key,
    required this.setIconInformation,
    required this.iconType,
    this.iconValue
  });

  final Function(String, String) setIconInformation;

  final String iconType;
  final String? iconValue;

  @override
  State<IconSelector> createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {
  final searchTextController = TextEditingController();
  var someImages;
  var currentIcon = "assets/aegis_icons/icons/3_Generic/User.svg";

  @override
  void initState() {
    super.initState();

    searchTextController.text = "";

    if (widget.iconType == "icon" && widget.iconValue != null)
      setState(() {
        currentIcon = (widget.iconValue as String);
      });

    _initImages();
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    // debugPrint(manifestContent);

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('aegis_icons/'))
        .where((String key) => key.contains('.svg'))
        .toList();

    // debugPrint(imagePaths);

// someImages = imagePaths;
    setState(() {
      someImages = imagePaths;
    });
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

                                    widget.setIconInformation(
                                        "icon",
                                        someImages[index]
                                    );
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
