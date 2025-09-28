import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Models/HelpModel.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/AppBarWidget.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/Drawer.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomContainer.dart';
import 'package:provider/provider.dart';
import '../../Providers/ChangeModeProvider.dart';
import '../Elements/CustomText.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Help Question Answer Model Content
  List<HelpModel> model = [
    HelpModel(
      title: "What is this app used for?",
      content:
          "This app helps you discover, explore, and read millions of books. You can search by title, author, or ISBN and quickly find what you’re looking for.",
    ),
    HelpModel(
      title: "Is the app free to use?",
      content:
          "Yes, the app is free. You can explore books, authors, and categories without any cost. Some advanced features may require login for personalization.",
    ),
    HelpModel(
      title: "How do I search for books?",
      content:
          "Use the search bar on the home screen. Type the book title, author name to instantly find results.",
    ),
    HelpModel(
      title: "How do I explore Categories?",
      content:
          "Open the Categories section to browse books by genre such as Fiction, Science, History, Technology, or Trending Collections.",
    ),
    HelpModel(
      title: "What are Trending Books?",
      content:
          "Trending Books are popular titles updated regularly. This section helps you quickly discover what other readers are enjoying right now.",
    ),
    HelpModel(
      title: "Can I explore Authors & Editions?",
      content:
          "Yes, you can visit author profiles, check all editions of a book, and see related works easily inside the app.",
    ),
    HelpModel(
      title: "How do I save my favorite books?",
      content:
          "Sign in to create your personal library. You can bookmark books, save them to your favorites, and access them anytime in one place.",
    ),
    HelpModel(
      title: "Can I read books inside the app?",
      content:
          "Yes, if a book has a digital copy available, you can read it directly inside the app. Otherwise, you will see details and editions.",
    ),
    HelpModel(
      title: "Can I use this app offline?",
      content:
          "Basic browsing requires internet. However, if you save books to your library, you can access them offline for quick reference.",
    ),
    HelpModel(
      title: "What are the benefits of using this app?",
      content:
          "You get instant access to millions of books, easy author exploration, categorized browsing, trending suggestions, and the ability to save favorites — all in one simple app.",
    ),
    HelpModel(
      title: "Do I need an account to use the app?",
      content:
          "No, you can explore books and authors without an account. But if you want to save favorites or sync across devices, you’ll need to sign in.",
    ),
    HelpModel(
      title: "Does the app support multiple devices?",
      content:
          "Yes, once you log in with the same account, your saved books and favorites will sync across your devices.",
    ),
    HelpModel(
      title: "How often is the content updated?",
      content:
          "The book database is updated regularly, ensuring you always have access to the latest titles, editions, and trending books.",
    ),
    HelpModel(
      title: "Can I change the app theme?",
      content:
          "Yes, the app supports light and dark mode. You can switch themes anytime from the settings.",
    ),
    HelpModel(
      title: "Is my data secure?",
      content:
          "Yes, your data is safely stored. Passwords are never shared or stored in plain text, and your information is protected with Firebase authentication.",
    ),
    HelpModel(
      title: "How do I reset my password?",
      content:
          "If you forget your password, go to the Login screen and tap on 'Forgot Password'. Enter your email, and we’ll send you a reset link.",
    ),
  ];

  @override
  Widget build(BuildContext context) {

    /// Theme Provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.transparent,

      /// AppBar Widget
      appBar: AppBarWidget(
        titleText: "Help",
        searchIcon: false,
        contactIcon: true,
      ),

      /// Drawer Widget
      drawer: DrawerWidget(),

      /// Body Start
      body: MyContainer(
        decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          itemCount: model.length,
          itemBuilder: (context, index) {
            final faq = model[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeProvider.buttonBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [

                    /// Title (Question)
                    ListTile(
                      title: Text(
                        faq.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: themeProvider.primaryTextColor,
                        ),
                      ),

                      /// Icon
                      trailing: MyIconContainer(
                        onTap: () {
                          setState(() {
                            faq.isOpen = !faq.isOpen;
                          });
                        },
                        icon: faq.isOpen
                            ? CupertinoIcons.chevron_up
                            : CupertinoIcons.chevron_down,
                        iconColor: themeProvider.primaryTextColor,
                      ),
                    ),

                    /// Subtitle (Answer of Question)
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: faq.isOpen
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              child: MyText(
                                text: faq.content,
                                size: 15,
                                color: themeProvider.primaryTextColor,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
