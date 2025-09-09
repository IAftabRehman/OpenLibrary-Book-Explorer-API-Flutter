import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/ChangeMode.dart';
import 'package:provider/provider.dart';
import '../Elements/CustomTextField.dart';

class AuthenticationTextField extends StatelessWidget {
  TextEditingController controller;
  TextInputType? keyboard;
  String labelText;
  IconData? suffixIcon;
  bool isPasswordField = false;
  AuthenticationTextField({super.key, required this.controller, this.keyboard, required this.labelText,this.suffixIcon, required this.isPasswordField});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MyTextField(
        controller: controller,
        keyboardType:  keyboard ?? TextInputType.text,
        labelText: labelText,
        labelColor: Colors.blue,
        labelSize: 15,
        textColor: themeProvider.primaryTextColor,
        suffixIcon: suffixIcon,
        suffixColor: themeProvider.primaryTextColor,
        isPasswordField: isPasswordField,
      );
  }
}
