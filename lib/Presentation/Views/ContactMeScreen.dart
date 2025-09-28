import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/AppBarWidget.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/Drawer.dart';
import 'package:provider/provider.dart';
import '../../Providers/ChangeModeProvider.dart';
import '../../Providers/ContactProvider.dart';
import '../Elements/CustomContainer.dart';
import '../Elements/CustomText.dart';

class ContactMeScreen extends StatelessWidget {
  ContactMeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    /// Theme Provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    /// Contact Provider
    final contactProvider = Provider.of<ContactProvider>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,

      /// AppBar Widget
      appBar: AppBarWidget(titleText: "Contact Me", searchIcon: false),

      /// Drawer Widget
      drawer: DrawerWidget(),

      /// Body Start
      body: MyContainer(
        height: double.infinity,
        decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            /// Phone Number
            GestureDetector(
              onTap: () => contactProvider.phoneNumber("03323220916"),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Icon(Icons.phone,
                      color: themeProvider.primaryTextColor),
                  title: MyText(
                    text: "0332 3220916",
                    size: 16,
                    fontWeight: FontWeight.w600,
                    color: themeProvider.primaryTextColor,
                  ),
                  subtitle: MyText(
                    text: "Mobile Number",
                    size: 14,
                    color: themeProvider.secondaryTextColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            /// Email Address
            GestureDetector(
              onTap: () =>
                  contactProvider.emailLink("iamaftabrehman@gmail.com"),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Icon(Icons.email,
                      color: themeProvider.primaryTextColor),
                  title: MyText(
                    text: "iamaftabrehman@gmail.com",
                    size: 16,
                    fontWeight: FontWeight.w600,
                    color: themeProvider.primaryTextColor,
                  ),
                  subtitle: MyText(
                    text: "Email Address",
                    size: 14,
                    color: themeProvider.secondaryTextColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            /// Linkedin Profile
            GestureDetector(
              onTap: () => contactProvider.linkedinLink(
                  "https://www.linkedin.com/in/aftab-rehman/"),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Icon(Icons.link,
                      color: themeProvider.primaryTextColor),
                  title: MyText(
                    text: "LinkedIn Profile",
                    size: 16,
                    fontWeight: FontWeight.w600,
                    color: themeProvider.primaryTextColor,
                  ),
                  subtitle: MyText(
                    text: "Tap to visit",
                    size: 14,
                    color: themeProvider.secondaryTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
