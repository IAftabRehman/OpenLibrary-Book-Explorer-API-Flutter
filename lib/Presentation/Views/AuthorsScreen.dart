import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/WaitingCard.dart';
import 'package:openlibrary_book_explorer/Providers/LibraryProvider.dart';
import 'package:provider/provider.dart';
import '../../Providers/ChangeModeProvider.dart';
import '../CommonWidgets/AppBarWidget.dart';
import '../CommonWidgets/Drawer.dart';
import '../Elements/CustomContainer.dart';
import '../Elements/CustomText.dart';
import '../Elements/CustomTextField.dart';

class AuthorsScreen extends StatefulWidget {
  const AuthorsScreen({super.key});

  @override
  State<AuthorsScreen> createState() => _AuthorsScreenState();
}

class _AuthorsScreenState extends State<AuthorsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool openSearch = false;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<LibraryProvider>(context, listen: false).fetchAllAuthors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final libraryProvider = Provider.of<LibraryProvider>(context);

    // 🔍 Filter authors by search
    final filteredAuthors = libraryProvider.authors.where((author) {
      final name = (author["name"] ?? "").toLowerCase();
      return name.contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.transparent,
      appBar: AppBarWidget(
        titleText: "Authors",
        searchIcon: true,
        onSearchToggle: (isOpen) {
          setState(() {
            openSearch = isOpen;
            if (!isOpen) searchQuery = ""; // reset filter
          });
        },
      ),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: MyContainer(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (openSearch)
                MyTextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  backgroundColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  textFieldBorder: Border.all(
                    width: 2,
                    color: themeProvider.primaryTextColor,
                  ),
                  hintText: "Search Author...",
                  hintColor: themeProvider.primaryTextColor,
                  cursorColor: themeProvider.primaryTextColor,
                  textColor: themeProvider.primaryTextColor,
                  textSize: 16,
                ),

              const SizedBox(height: 10),

              libraryProvider.isLoading
                  ? waitingCard("Please wait, fetching all authors may take some time...")
                  : Expanded(
                    child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: filteredAuthors.length,
                                    itemBuilder: (context, index) {
                    var author = filteredAuthors[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: MyContainer(
                        onTap: () async {
                          String authorKey = author['key'] ?? "";
                          if (!authorKey.startsWith("/authors/")) {
                            authorKey = "/authors/$authorKey";
                          }

                          final details = await libraryProvider
                              .fetchAuthorDetails(authorKey);

                          if (context.mounted) {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.authorDetails,
                              arguments: {
                                "authorDetails": details ?? {},
                              },
                            );
                          }
                        },
                        height: 70,
                        width: double.infinity,
                        color: themeProvider.buttonBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: MyText(
                                text: author["name"] ?? "Unknown Author",
                                size: 18,
                                fontWeight: FontWeight.bold,
                                color: themeProvider.primaryTextColor,
                              ),
                            ),
                            Image.asset(
                              'assets/icons/author.png',
                              height: 45,
                              width: 45,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    );
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
