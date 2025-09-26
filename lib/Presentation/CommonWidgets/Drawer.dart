import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Providers/ChangeModeProvider.dart';
import 'package:provider/provider.dart';
import '../../Configuration/Routes.dart';
import '../../Providers/AuthenticationProvider.dart';
import '../Elements/CustomContainer.dart';
import '../Elements/CustomText.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthenticationProvider>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        child: MyContainer(
          decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
          child: Column(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    MyContainer(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: authProvider.isLoggedIn
                              ? AssetImage(authProvider.profilePic)
                              : AssetImage("assets/images/default_user.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Spacer(),
                    MyText(
                      text: authProvider.name,
                      size: 16,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.primaryTextColor,
                    ),
                    MyText(
                      text: authProvider.email,
                      size: 12,
                      color: themeProvider.primaryTextColor,
                    ),
                  ],
                ),
              ),

              /// My Library
              ListTile(
                leading: Icon(
                  Icons.library_books_outlined,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(
                  text: "My Library",
                  fontWeight: FontWeight.bold,
                ),
              ),

              /// Home
              ListTile(
                leading: Icon(
                  Icons.home_outlined,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(
                  text: "Home",
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.home);
                },
              ),

              /// Trending Book
              ListTile(
                leading: Icon(
                  Icons.trending_up,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(
                  text: "Trending Book",
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.trendingBook);
                },
              ),

              /// Categories
              ListTile(
                leading: Icon(
                  Icons.category_outlined,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(
                  text: "Categories",
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.categories);
                },
              ),

              /// Authors
              ListTile(
                leading: Icon(
                  Icons.person_outlined,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(text: "Authors", fontWeight: FontWeight.bold),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.authors);
                },
              ),

              /// Favorite (Login Check)
              ListTile(
                leading: Icon(
                  Icons.favorite_outline,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(text: "Favorite", fontWeight: FontWeight.bold),
                onTap: () {
                  if (authProvider.isLoggedIn) {
                    Navigator.pushNamed(context, AppRoutes.favorite);
                  } else {
                    Navigator.pushNamed(context, AppRoutes.login);
                  }
                },
              ),

              /// Theme Mode
              ListTile(
                leading: Icon(
                  themeProvider.isNightMode
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(
                  text: themeProvider.isNightMode ? "Dark Mode" : "Light Mode",
                  color: themeProvider.primaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  themeProvider.toggleTheme();
                },
              ),

              /// Help
              ListTile(
                leading: Icon(
                  Icons.question_mark_outlined,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(text: "Help", fontWeight: FontWeight.bold),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.help);
                },
              ),

              /// Login / Logout
              authProvider.isLoggedIn
                  ? ListTile(
                leading: Icon(
                  Icons.logout,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(text: "LogOut", fontWeight: FontWeight.bold),
                onTap: () {
                  authProvider.logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.login, (route) => false);
                },
              )
                  : ListTile(
                leading: Icon(
                  Icons.login,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(text: "Login", fontWeight: FontWeight.bold),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
