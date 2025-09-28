import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:openlibrary_book_explorer/Providers/AuthenticationProvider.dart';
import 'package:provider/provider.dart';
import '../../Providers/ChangeModeProvider.dart';
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
    /// Theme Provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    /// Authentication Provider
    final authProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      /// Body Start
      body: MyContainer(
        decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),

            /// Title Text
            MyText(
              text: "Login",
              size: 20,
              fontWeight: FontWeight.bold,
              color: themeProvider.primaryTextColor,
            ),
            const SizedBox(height: 10),

            /// Subtitle Text
            MyText(
              text:
                  "Log in to unlock your favorites and continue your reading journey.",
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
            const SizedBox(height: 10),

            /// Password TextField
            AuthenticationTextField(
              controller: passwordController,
              keyboard: TextInputType.visiblePassword,
              hintText: "Password",
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
              onPressed: () async {
                final success = await authProvider.login(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );

                if (success) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Successfully Logged In"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // close dialog
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.home, // go to home
                              );
                            },
                            child: const Text("Go to Home Page"),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Login failed. Please try again"),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 15),

            /// Navigate SignUp Screen Text
            Align(
              alignment: Alignment.bottomRight,
              child: MyText(
                text: "Don't have an account? SignUp",
                size: 13,
                decoration: TextDecoration.underline,
                color: themeProvider.primaryTextColor,
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
