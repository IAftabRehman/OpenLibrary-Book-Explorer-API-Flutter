import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:provider/provider.dart';

import '../../Configuration/ChangeMode.dart';
import '../CommonWidgets/AuthenticationTextField.dart';
import '../Elements/CustomBottom.dart';
import '../Elements/CustomContainer.dart';
import '../Elements/CustomText.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: MyContainer(
        height: double.infinity,
        decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),

            /// Title Text
            MyText(
              text: "Enter Your Library",
              size: 20,
              fontWeight: FontWeight.bold,
              color: themeProvider.primaryTextColor,
            ),
            const SizedBox(height: 10),

            /// Subtitle Text
            MyText(
              text:
                  "Access your saved favorites, explore authors, and pick up where you left off.",
              size: 17,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              color: themeProvider.secondaryTextColor,
            ),
            const SizedBox(height: 30),

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
            const SizedBox(height: 10),

            /// Forget Password
            Align(
              alignment: Alignment.bottomRight,
              child: MyText(
                text: "Forget Password",
                size: 13,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.right,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.forgetPassword);
                },
              ),
            ),
            const SizedBox(height: 30),

            /// Below Button
            MyButton(
              btnLabel: "LogIn",
              paddingLeft: 70,
              paddingRight: 70,
              onPressed: () {},
            ),
            const SizedBox(height: 15),

            /// Navigate SignUp Screen Text
            Align(
              alignment: Alignment.bottomRight,
              child: MyText(
                text: "Don't have an account? SignUp",
                size: 13,
                decoration: TextDecoration.underline,
                color: Colors.lightGreenAccent,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.right,
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.signUp);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
