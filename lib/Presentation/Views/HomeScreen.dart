import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Providers/ChangeModeProvider.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:openlibrary_book_explorer/Models/AuthorsModel.dart';
import 'package:openlibrary_book_explorer/Models/CategoriesModel.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomContainer.dart';
import 'package:provider/provider.dart';

import '../../Models/FavouriteBookModel.dart';
import '../Elements/CustomText.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<CategoriesModel> categoriesModel = [
    CategoriesModel(name: "Fiction"),
    CategoriesModel(name: "Non-Fiction"),
    CategoriesModel(name: "Science"),
    CategoriesModel(name: "History"),
    CategoriesModel(name: "Technology"),
    CategoriesModel(name: "Kids"),
    CategoriesModel(name: "Businesses"),
  ];

  List<AuthorsModel> authorsModel = [
    AuthorsModel(name: "J.K. Rowling"),
    AuthorsModel(name: "George R.R. Martin"),
    AuthorsModel(name: "Jane Austen"),
    AuthorsModel(name: "Charles Dickens"),
    AuthorsModel(name: "Mark Twain"),
    AuthorsModel(name: "Agatha Christie"),
    AuthorsModel(name: "Ernest Hemingway"),
    AuthorsModel(name: "J.R.R. Tolkien"),
    AuthorsModel(name: "Leo Tolstoy"),
    AuthorsModel(name: "Stephen King"),
  ];

  List<FavouriteBookModel> favouriteBookModel = [
    FavouriteBookModel(name: "Fiction"),
    FavouriteBookModel(name: "Non-Fiction"),
    FavouriteBookModel(name: "Science"),
    FavouriteBookModel(name: "History"),
    FavouriteBookModel(name: "Technology"),
    FavouriteBookModel(name: "Kids"),
    FavouriteBookModel(name: "Businesses"),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.2),
        elevation: 0, // remove shadow
        leading: MyIconContainer(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icons.menu,
          iconSize: 30,
          iconColor: Colors.white70,
        ),
        title: MyText(
          text: "OpenLibrary Book Explorer",
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          size: 22,
        ),
      ),
      drawer: SizedBox(
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
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/background.jpg",
                fit: BoxFit.cover,
              ),
            ),
            MyContainer(
              color: Colors.black.withOpacity(0.6),
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  listViewContainer(
                    context,
                    themeProvider,
                    "Book Categories",
                    () {
                      Navigator.pushNamed(context, AppRoutes.categories);
                    },
                    categoriesModel,
                  ),

                  const SizedBox(height: 50),

                  listViewContainer(context, themeProvider, "Book Authors", () {
                    Navigator.pushNamed(context, AppRoutes.authors);
                  }, authorsModel),

                  const SizedBox(height: 50),

                  listViewContainer(context, themeProvider, "Book Authors", () {
                    Navigator.pushNamed(context, AppRoutes.authors);
                  }, favouriteBookModel),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  MyContainer listViewContainer(
    BuildContext context,
    ThemeProvider themeProvider,
    String titleName,
    VoidCallback? onTap,
    List modelName,
  ) {
    return MyContainer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(text: titleName, size: 16, color: Colors.white70),
                MyText(
                  text: "See All",
                  color: Colors.green,
                  decoration: TextDecoration.underline,
                  onTap: onTap,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: modelName.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: MyContainer(
                    decoration: BoxDecoration(
                      gradient: themeProvider.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Center(
                      child: MyText(
                        text: modelName[index].name,
                        size: 18,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.primaryTextColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
