import 'package:flutter/material.dart';
// import 'package:habit_tracker/theme.dart';

class FlatSetting extends StatefulWidget {
  FlatSetting({
    super.key,
    //required this.textController,
    required this.settingNameText,
    required this.descriptionNameText,
    this.switchValue = false,
    this.showSwitch = false,
    this.disabled = false,
  });

  //final TextEditingController textController;
  final String settingNameText;
  final String descriptionNameText;
  bool switchValue;
  bool showSwitch;
  bool disabled;

  @override
  State<FlatSetting> createState() => _FlatSetting();
}

class _FlatSetting extends State<FlatSetting> {
  @override
  Widget build(BuildContext context) {
    Column switchColumn = Column();
    if (widget.showSwitch) {
      switchColumn = Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Switch(
            value: widget.switchValue,
            activeColor: Colors.blue,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
            onChanged: (bool value) {
              setState(() {
                widget.switchValue = value;
              });
            }
          )
        ],
      );
    }
    Color name = Colors.black;
    Color desc = Colors.grey;
    if (widget.disabled) {
      name = const Color.fromARGB(255, 209, 209, 209);
      desc = const Color.fromARGB(255, 209, 209, 209);
    }
    // final customColors = Theme.of(context).extension<CustomColors>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.settingNameText,
              style: TextStyle(
                color: name,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 450,
              child: Text(
                widget.descriptionNameText,
                style: TextStyle(
                  color: desc,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        switchColumn
      ],
    );
  }
}
