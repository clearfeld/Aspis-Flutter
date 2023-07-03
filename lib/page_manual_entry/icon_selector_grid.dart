import 'dart:convert';

import 'package:aspis/components/flat_textfield.dart';
import 'package:aspis/page_manual_entry/icon_selector_grid.dart';
import 'package:aspis/theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconSelectorGrid extends StatefulWidget {
  const IconSelectorGrid(
      {super.key,
      required this.setIconInformation,
      required this.setCurrentIconImagePath,
       required this.iconType, this.iconValue});

  final Function(String, String) setIconInformation;
final Function(String) setCurrentIconImagePath;

  final String iconType;
  final String? iconValue;

  @override
  State<IconSelectorGrid> createState() => _IconSelectorGridState();
}

class _IconSelectorGridState extends State<IconSelectorGrid> {
  final searchTextController = TextEditingController();
  List<dynamic>? someImages;
  List<dynamic>? filteredImageList;
  var currentIcon = "assets/aegis_icons/icons/3_Generic/User.svg";

  @override
  void initState() {
    super.initState();

    searchTextController.text = "";
    searchTextController.addListener(searchValueOnChange);

    if (widget.iconType == "icon" && widget.iconValue != null) {
      setState(() {
        currentIcon = (widget.iconValue as String);
      });
    }

    _initImages();
  }

  void searchValueOnChange() {
    List<dynamic> filteredList = [];

    if (someImages != null) {
      if (searchTextController.text == "") {
        setState(() {
          filteredImageList = someImages;
        });
        return;
      }

      var searchText = searchTextController.text.toLowerCase();
      for (var image in someImages!) {
        // debugPrint(otpCode.title.toLowerCase());
        // debugPrint(image["title"]);
        if (image["title"].toLowerCase().contains(searchText)
            // || image.issuer!.toLowerCase().contains(searchText)
            ) {
          var lastIndex = image["imagePath"].lastIndexOf("/");
          var svgIndex = image["imagePath"].lastIndexOf(".svg");

          if (lastIndex == -1 || svgIndex == -1) {
            continue;
          }

          filteredList.add({
            "imagePath": image["imagePath"],
            "title": image["imagePath"].substring(lastIndex + 1, svgIndex)
          });
        }
      }

      // print(filteredList);

      setState(() {
        filteredImageList = filteredList;
      });
    }
  }

  List<dynamic>? getFilteredList() {
    return filteredImageList;
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    // debugPrint(manifestContent);

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    List<dynamic> imageList = [];

    for (var icon in manifestMap.keys) {
      // print(icon);
      if (icon.contains('aegis_icons/')) {
        var lastIndex = icon.lastIndexOf("/");
        var svgIndex = icon.lastIndexOf(".svg");

        if (lastIndex == -1 || svgIndex == -1) {
          continue;
        }

        imageList.add({"imagePath": icon, "title": icon.substring(lastIndex + 1, svgIndex)});
      }
    }

    // final imagePaths = manifestMap.keys
    //     .where((String key) => key.contains('aegis_icons/'))
    //     .where((String key) => key.contains('.svg'))
    //     .toList();

    setState(() {
      filteredImageList = imageList;
      someImages = imageList;
    });
  }

  @override
  void dispose() {
    // searchTextController.text = "";
    searchTextController.dispose();

    super.dispose();
  }

  Widget gridCell(dynamic icon) {
    if (icon == null) {
      return const SizedBox();
    }

    return ListTile(
      title: InkWell(
        child: Container(
          //   width: 88.0,
          //   height: 88.0,
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(icon["imagePath"], semanticsLabel: icon["imagePath"]),
        ),
        onTap: () {
          setState(() {
            currentIcon = icon["imagePath"];
          });

          widget.setCurrentIconImagePath(icon["imagePath"]);

          widget.setIconInformation("icon", icon["imagePath"]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>();
    // final fli = getFilteredList();

    return Container(
      // key: cust_key,
      height: MediaQuery.of(context).size.height * 0.8,
      color: customColors!.navbarBackground,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              height: 44.0,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: FlatTextField(
                      textController: searchTextController,
                      hintText: "Search",
                      backgroundColor: customColors.backgroundCompliment!,
                      // prefixIcon: Icons.search,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Center(
                    child: Container(
                      width: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: customColors.buttonGrey,
                      ),
                      child: SizedBox(
                        child: IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            searchTextController.text = '';
                            setState(() {
                              //appbarState = EAppbarState.none;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Divider(
              color: customColors.border,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: getFilteredList()?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  return gridCell(getFilteredList()?[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
