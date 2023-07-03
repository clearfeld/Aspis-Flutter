import 'dart:convert';

import 'package:aspis/components/flat_textfield.dart';
import 'package:aspis/page_manual_entry/icon_selector_grid.dart';
import 'package:aspis/theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconSelector extends StatefulWidget {
  const IconSelector(
      {super.key, required this.setIconInformation, required this.iconType, this.iconValue});

  final Function(String, String) setIconInformation;

  final String iconType;
  final String? iconValue;

  @override
  State<IconSelector> createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {
  final searchTextController = TextEditingController();
  var currentIcon = "assets/aegis_icons/icons/3_Generic/User.svg";

  @override
  void initState() {
    super.initState();

    searchTextController.text = "";

    if (widget.iconType == "icon" && widget.iconValue != null) {
      setState(() {
        currentIcon = (widget.iconValue as String);
      });
    }
  }

  void setCurrentIconImagePath(String imgPath) {
    setState(() {
        currentIcon = imgPath;
    });
  }

  @override
  void dispose() {
    // searchTextController.text = "";
    searchTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>();
    // final fli = getFilteredList();

    return SizedBox(
      // width: MediaQuery.of(context).size.height * 0.8,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        TextButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {

                return IconSelectorGrid(
                    setIconInformation: widget.setIconInformation,
                    setCurrentIconImagePath: setCurrentIconImagePath,
                    iconType: widget.iconType,
                    iconValue: widget.iconValue
                );
              },
            );

          },
          child: Container(
            width: 160.0,
            height: 160.0,
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(currentIcon, semanticsLabel: currentIcon),
          ),
        ),
      ]),
    );
  }
}
