import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:openlibrary_book_explorer/Providers/ChangeModeProvider.dart';
import 'package:openlibrary_book_explorer/Providers/CategoriesProvider.dart';
import '../CommonWidgets/AppBarWidget.dart';
import '../CommonWidgets/Drawer.dart';
import '../Elements/CustomContainer.dart';
import '../Elements/CustomTextField.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool openSearch = false;

  @override
  void initState() {
    super.initState();
    // Fetch science books on load
    Future.microtask(() {
      Provider.of<LibraryProvider>(context, listen: false)
          .fetchBooksByCategory("science");
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final libraryProvider = Provider.of<LibraryProvider>(context);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.transparent,
        appBar: AppBarWidget(
          titleText: "Book Categories",
          searchIcon: true,
        ),
        drawer: DrawerWidget(),
        body: MyContainer(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔍 Search Bar Toggle
              if (openSearch)
                MyTextField(
                  backgroundColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  textFieldBorder: Border.all(
                    width: 2,
                    color: themeProvider.primaryTextColor,
                  ),
                  hintText: "Search Author",
                  hintColor: themeProvider.primaryTextColor,
                  cursorColor: themeProvider.primaryTextColor,
                  textColor: themeProvider.primaryTextColor,
                  textSize: 16,
                ),

              const SizedBox(height: 10),

              Expanded(
                child: libraryProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  itemCount: libraryProvider.books.length,
                  itemBuilder: (context, index) {
                    final book = libraryProvider.books[index];
                    return ListTile(
                      title: Text(book['title'] ?? "No Title"),
                      subtitle: Text(
                        (book['authors'] != null &&
                            book['authors'].isNotEmpty)
                            ? book['authors'][0]['name']
                            : "Unknown Author",
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
