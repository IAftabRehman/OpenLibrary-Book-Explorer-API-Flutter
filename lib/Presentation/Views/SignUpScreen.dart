import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/ChangeMode.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/AuthenticationTextField.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomBottom.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomText.dart';
import 'package:provider/provider.dart';
import '../Elements/CustomContainer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: MyContainer(
        height: double.infinity,
        decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),

              /// Title Text
              MyText(
                text: "Join the Library of Millions",
                size: 20,
                fontWeight: FontWeight.bold,
                color: themeProvider.primaryTextColor,
              ),
              const SizedBox(height: 10),

              /// Subtitle Text
              MyText(
                text:
                    "Save favorites, track authors, and discover books tailored to you.",
                size: 17,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                color: themeProvider.secondaryTextColor,
              ),
              const SizedBox(height: 30),

              /// Name TextField
              AuthenticationTextField(
                controller: nameController,
                keyboard: TextInputType.name,
                labelText: "Name",
                suffixIcon: Icons.person_outline,
                isPasswordField: false,
              ),
              const SizedBox(height: 10),

              /// Age TextField
              AuthenticationTextField(
                controller: ageController,
                keyboard: TextInputType.number,
                labelText: "Age",
                suffixIcon: Icons.cake_outlined,
                isPasswordField: false,
              ),
              const SizedBox(height: 10),

              /// Phone Number TextField
              AuthenticationTextField(
                controller: numberController,
                keyboard: TextInputType.phone,
                labelText: "Phone",
                suffixIcon: Icons.phone_outlined,
                isPasswordField: false,
              ),
              const SizedBox(height: 10),

              /// Email TextField
              AuthenticationTextField(
                controller: emailController,
                keyboard: TextInputType.emailAddress,
                labelText: "Email",
                suffixIcon: Icons.email_outlined,
                isPasswordField: false,
              ),
              const SizedBox(height: 10),

              /// Password TextField
              AuthenticationTextField(
                controller: passwordController,
                keyboard: TextInputType.visiblePassword,
                labelText: "Password",
                isPasswordField: true,
              ),
              const SizedBox(height: 20),

              /// Below Button
              MyButton(
                btnLabel: "Sign Up",
                paddingLeft: 70,
                paddingRight: 70,
                onPressed: () {},
              ),
              const SizedBox(height: 20),

              /// Navigate Login Screen Text
              Align(
                alignment: Alignment.bottomRight,
                child: MyText(
                  text: "Already have an account? LogIn",
                  size: 12,
                  color: Colors.lightGreenAccent,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.right,
                  decoration: TextDecoration.underline,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
