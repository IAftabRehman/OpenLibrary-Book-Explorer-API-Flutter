import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Providers/ChangeModeProvider.dart';
import 'package:provider/provider.dart';
import '../Elements/CustomTextField.dart';

/// Custom Authentication Text Field
class AuthenticationTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboard;
  final String hintText;
  final IconData? suffixIcon;
  final bool isPasswordField;

  const AuthenticationTextField({
    super.key,
    required this.controller,
    this.keyboard,
    required this.hintText,
    this.suffixIcon,
    this.isPasswordField = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MyTextField(
      controller: controller,
      keyboardType: keyboard ?? TextInputType.text,
      hintText: hintText,
      hintColor: Colors.blue,
      hintSize: 15,
      textColor: Colors.black,
      suffixIcon: suffixIcon,
      suffixColor: themeProvider.primaryTextColor,
      isPasswordField: isPasswordField,
    );
  }
}
