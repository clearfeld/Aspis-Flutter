import 'package:aspis/theme.dart';
import 'package:flutter/material.dart';
// import 'package:habit_tracker/theme.dart';

typedef SetValueStringCallback = void Function(String? valueArg);

class FlatDropdown extends StatefulWidget {
  const FlatDropdown({
    super.key,
    required this.value,
    required this.onValueChanged,
    required this.items,
    this.labelText = "",
  });

  final String value;
  final SetValueStringCallback onValueChanged;

  // TODO(clearfeld): allow for enums later
  final List<String> items;

  final String? labelText;

  @override
  State<FlatDropdown> createState() => _FlatDropdown();
}

class _FlatDropdown extends State<FlatDropdown> {
  // Son({
  //     @
  // });

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return DecoratedBox(
      decoration: const BoxDecoration(
          // color: customColors.background, //  Color.fromRGBO(41, 41, 41, 1.0),
          //background color of dropdown button
          // border: Border.all(color: Colors.black38, width:3), //border of dropdown button
          // borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
          // boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
          //   BoxShadow(
          //     color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
          //     blurRadius: 5) //blur radius of shadow
          // ]
          ),
      child: Container(
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                height: 3,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: customColors.border!, width: 1),
                borderRadius: BorderRadius.circular(5)
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: customColors.border!, width: 1),
                borderRadius: BorderRadius.circular(5)
              ),
              contentPadding: const EdgeInsets.only(top: -5, left: 5, right: 5),
            ),
            child: DropdownButton(
              value: widget.value,
              icon: const Icon(Icons.expand_more),
              onChanged: (String? valueArg) {
                widget.onValueChanged(valueArg);
              },
              items: widget.items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),

              style: TextStyle(
                color: customColors.textColor,
                fontSize: 16, //font size on dropdown button
              ),

              dropdownColor: customColors.background, //dropdown background color
              underline: Container(), //remove underline
              isExpanded: true, //make true to make width 100%
            ),
          )),
    );
  }
}
