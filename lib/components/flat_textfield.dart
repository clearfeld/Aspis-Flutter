import 'package:flutter/material.dart';
// import 'package:habit_tracker/theme.dart';

class FlatTextField extends StatefulWidget {
  const FlatTextField({
    super.key,
    required this.textController,
    this.hintText,
    this.labelText,
    this.password = false,
    this.enabled = true,
  });

  final TextEditingController textController;
  final String? hintText;
  final String? labelText;
  final bool password;
  final bool enabled;

  @override
  State<FlatTextField> createState() => _FlatTextField();
}

class _FlatTextField extends State<FlatTextField> {
  @override
  Widget build(BuildContext context) {
    // final customColors = Theme.of(context).extension<CustomColors>()!;
    Color textColor = Colors.white;
    if (!widget.enabled) {
      textColor = Colors.grey;
    }

    return TextField(
      controller: widget.textController,
      enabled: widget.enabled,
      obscureText: widget.password,
      enableSuggestions: !widget.password,
      autocorrect: !widget.password,
      style: TextStyle(color: Colors.white), // customColors.text_color),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(41, 41, 41, 1.0), // customColors.background,
        labelText: widget.labelText,
        labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
        border: InputBorder.none,
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 16.0, color: Colors.grey),
      ),
    );
  }
}
