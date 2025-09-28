import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Providers/ChangeModeProvider.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/AuthenticationTextField.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomBottom.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomText.dart';
import 'package:openlibrary_book_explorer/Providers/AuthenticationProvider.dart';
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
                hintText: "Name",
                suffixIcon: Icons.person_outline,
                isPasswordField: false,
              ),
              const SizedBox(height: 10),

              /// Age TextField
              AuthenticationTextField(
                controller: ageController,
                keyboard: TextInputType.number,
                hintText: "Age",
                suffixIcon: Icons.cake_outlined,
                isPasswordField: false,
              ),
              const SizedBox(height: 10),

              /// Phone Number TextField
              AuthenticationTextField(
                controller: numberController,
                keyboard: TextInputType.phone,
                hintText: "Phone",
                suffixIcon: Icons.phone_outlined,
                isPasswordField: false,
              ),
              const SizedBox(height: 10),

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
              const SizedBox(height: 20),

              /// Below Button
              Consumer<AuthenticationProvider>(
                builder: (context, provider, child) {
                  return provider.isLoading
                      ? const CircularProgressIndicator()
                      : MyButton(
                          btnLabel: "Sign Up",
                          paddingLeft: 70,
                          paddingRight: 70,
                          onPressed: () async {
                            try {
                              await provider.signUp(
                                nameController.text.trim(),
                                int.tryParse(ageController.text.trim()) ?? 0,
                                numberController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "✅ Sign up successful! Please check your email (and spam folder) to verify your account.",
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                await Future.delayed(
                                  const Duration(seconds: 2),
                                );

                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.login,
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("❌ Sign Up failed: $e")),
                              );
                            }
                          },
                        );
                },
              ),
              const SizedBox(height: 20),

              /// Navigate Login Screen Text
              Align(
                alignment: Alignment.bottomRight,
                child: MyText(
                  text: "Already have an account? LogIn",
                  size: 12,
                  color: themeProvider.primaryTextColor,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.right,
                  decoration: TextDecoration.underline,
                  onTap: () {
                    if (authProvider.isLoggedIn) {
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Sign Up failed, please try again"),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
