import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Providers/ChangeModeProvider.dart';
import 'package:provider/provider.dart';

import '../../Configuration/Routes.dart';
import '../../Providers/LibraryProvider.dart';
import '../CommonWidgets/AppBarWidget.dart';
import '../CommonWidgets/Drawer.dart';
import '../Elements/CustomContainer.dart';
import '../Elements/CustomText.dart';
import '../Elements/CustomTextField.dart';

class TrendingBook extends StatefulWidget {
  const TrendingBook({super.key});

  @override
  State<TrendingBook> createState() => _TrendingBookState();
}

class _TrendingBookState extends State<TrendingBook> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool openSearch = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<LibraryProvider>(context, listen: false).fetchTrendingBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final libraryProvider = Provider.of<LibraryProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.transparent,
      appBar: AppBarWidget(titleText: "Trending Book", searchIcon: true),
      drawer: DrawerWidget(),
      body: MyContainer(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            openSearch
                ? MyTextField(
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
                  )
                : SizedBox(),

            Expanded(
              child: libraryProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: libraryProvider.books.length,
                itemBuilder: (context, index) {
                  var book = libraryProvider.books[index];

                  List<dynamic> authors = book['author_details'] ?? [];
                  String authorNames = authors.isNotEmpty
                      ? authors.map((a) => a['name'] ?? "Unknown Author").join(", ")
                      : "Unknown Author";

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: MyContainer(
                      onTap: () async {
                        Navigator.pushNamed(context, AppRoutes.bookRead, arguments: {"bookUrl": book["bookUrl"]});
                      },
                      width: double.infinity,
                      color: themeProvider.buttonBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: ListTile(
                        title: MyText(
                          text: book['title'] ?? "Unknown Book",
                          size: 18,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.primaryTextColor,
                        ),
                        subtitle: MyText(
                          text: authorNames,
                          size: 16,
                          fontWeight: FontWeight.w500,
                          color: themeProvider.primaryTextColor.withOpacity(0.8),
                        ),
                        trailing: book["cover_i"] != null
                            ? Image.network(
                          "https://covers.openlibrary.org/b/id/${book["cover_i"]}-M.jpg",
                          height: 70,
                          width: 50,
                          fit: BoxFit.cover,
                        )
                            : const Icon(Icons.book, size: 50),
                      ),
                    ),
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
