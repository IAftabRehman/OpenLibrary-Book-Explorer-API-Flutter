import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:openlibrary_book_explorer/Providers/AuthenticationProvider.dart';
import 'package:provider/provider.dart';
import '../../Providers/ChangeModeProvider.dart';
import '../CommonWidgets/AuthenticationTextField.dart';
import '../Elements/CustomBottom.dart';
import '../Elements/CustomContainer.dart';
import '../Elements/CustomText.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// Theme Provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    /// Authentication Provider
    final authProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      /// Body Start
      body: MyContainer(
        height: double.infinity,
        decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            /// Leading Icon (Back Icon)
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
                iconSize: 35,
                icon: Icon(Icons.keyboard_arrow_left),
              ),
            ),
            const SizedBox(height: 200),

            /// Title Text
            MyText(
              text: "Lost the Key to Your Library?",
              size: 20,
              fontWeight: FontWeight.bold,
              color: themeProvider.primaryTextColor,
            ),
            const SizedBox(height: 10),

            /// Subtitle Text
            MyText(
              text:
                  "Don’t worry, reset your password and unlock your bookshelf again.",
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
              hintText: "Email",
              suffixIcon: Icons.email_outlined,
              isPasswordField: false,
            ),
            const SizedBox(height: 20),

            /// Below Button
            MyButton(
              btnLabel: "Check Email",
              paddingLeft: 70,
              paddingRight: 70,
              onPressed: () async {
                final email = emailController.text.trim();

                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter your email")),
                  );
                  return;
                }

                final success = await authProvider.resetPassword(email);

                if (success) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Check Your Email"),
                      content: Text(
                        "A reset link has been sent to $email. Please check your inbox.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Reset failed")));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
