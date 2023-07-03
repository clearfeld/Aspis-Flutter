import 'package:aspis/theme.dart';
import 'package:flutter/material.dart';

class FlatTextField extends StatefulWidget {
  const FlatTextField({
    super.key,
    required this.textController,
    this.hintText,
    this.labelText,
    this.password = false,
    this.enabled = true,
    this.backgroundColor = Colors.transparent,
    this.prefixIcon,
  });

  final TextEditingController textController;
  final String? hintText;
  final String? labelText;
  final bool password;
  final bool enabled;
  final Color backgroundColor;
  final IconData? prefixIcon;

  @override
  State<FlatTextField> createState() => _FlatTextField();
}

class _FlatTextField extends State<FlatTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    _isObscure = _isObscure && widget.password;

    return TextField(
      controller: widget.textController,
      enabled: widget.enabled,
      obscureText: _isObscure,
      enableSuggestions: !widget.password,
      autocorrect: !widget.password,
      style: TextStyle(color: customColors.textColor),
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        contentPadding: EdgeInsets.fromLTRB(8, 4, 8, 4),
        suffixIcon: widget.password ? IconButton(icon: _isObscure ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off), onPressed: () {
          setState(() {
            _isObscure = !_isObscure;
          });
        },) : null,
        filled: true,
        fillColor: widget.backgroundColor,
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: customColors.border!, width: 1),
          borderRadius: BorderRadius.circular(5)
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: customColors.border!, width: 1),
          borderRadius: BorderRadius.circular(5)
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 16.0, color: Colors.grey),
      ),
    );
  }
}
