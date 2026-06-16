import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final bool obscureText;

  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;

  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.obscureText = false,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,

      focusNode: focusNode,

      textInputAction: textInputAction,

      onFieldSubmitted: onFieldSubmitted,

      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon:
        prefixIcon != null
            ? Icon(prefixIcon)
            : null,
      ),
    );
  }
}