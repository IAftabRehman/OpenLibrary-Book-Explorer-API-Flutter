import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Providers/ChangeModeProvider.dart';
import 'package:provider/provider.dart';

import '../../Configuration/Routes.dart';
import '../Elements/CustomContainer.dart';
import '../Elements/CustomText.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
                          image: AssetImage('assets/images/background.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Spacer(),
                    MyText(
                      text: "Aftab Ur Rehman",
                      size: 16,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.primaryTextColor,
                    ),
                    MyText(
                      text: "iamaftabrehman@gmail.com",
                      size: 12,
                      color: themeProvider.primaryTextColor,
                    ),
                  ],
                ),
              ),

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
              ListTile(
                leading: Icon(
                  Icons.home_outlined,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(
                  text: "Home",
                  fontWeight: FontWeight.bold,
                ),
                onTap: (){
                  Navigator.pushNamed(context, AppRoutes.home);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.trending_up,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(
                  text: "Trending Book",
                  fontWeight: FontWeight.bold,
                ),
                onTap: (){
                  Navigator.pushNamed(context, AppRoutes.trendingBook);
                },
              ),
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
              ListTile(
                leading: Icon(
                  Icons.favorite_outline,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(text: "Favorite", fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: Icon(
                  themeProvider.isNightMode
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(
                  text: themeProvider.isNightMode
                      ? "Dark Mode"
                      : "Light Mode",
                  color: themeProvider.primaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  themeProvider.toggleTheme();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.question_mark_outlined,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(text: "Help", fontWeight: FontWeight.bold),
                onTap: (){
                  Navigator.pushNamed(context, AppRoutes.help);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: themeProvider.primaryTextColor,
                ),
                title: MyText(text: "LogOut", fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
