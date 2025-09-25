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
  String searchQuery = "";

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

    final filteredBooks = searchQuery.isEmpty
        ? libraryProvider.books
        : libraryProvider.books.where((book) {
      final title = (book['title'] ?? "").toString().toLowerCase();
      final author = (book['author'] ?? "").toString().toLowerCase();
      return title.contains(searchQuery.toLowerCase()) ||
          author.contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: AppBarWidget(
        titleText: "Trending Books",
        searchIcon: true,
        onSearchToggle: (isOpen) {
          setState(() {
            openSearch = isOpen;
            if (!isOpen) searchQuery = ""; // reset when closed
          });
        },
      ),
      drawer: DrawerWidget(),
      body: MyContainer(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (openSearch)
              MyTextField(
                backgroundColor: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                textFieldBorder: Border.all(
                  width: 2,
                  color: themeProvider.primaryTextColor,
                ),
                hintText: "Search Book or Author",
                hintColor: themeProvider.primaryTextColor,
                cursorColor: themeProvider.primaryTextColor,
                textColor: themeProvider.primaryTextColor,
                textSize: 16,
                onChanged: (val) {
                  setState(() {
                    searchQuery = val;
                  });
                },
              ),

            const SizedBox(height: 10),

            Expanded(
              child: libraryProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 books per row
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65, // taller cards
                ),
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  var book = filteredBooks[index];
                  String authorName =
                      book["author"] ?? "Unknown Author";

                  return GestureDetector(
                    onTap: () {
                      if (book["ocaid"] != null) {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.bookRead,
                          arguments: {"ocaid": book["ocaid"]},
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("❌ No PDF available for this book"),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeProvider.buttonBackgroundColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 📕 Book cover
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: book["coverId"] != null
                                ? Image.network(
                              "https://covers.openlibrary.org/b/id/${book["coverId"]}-M.jpg",
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                                : Container(
                              height: 160,
                              width: double.infinity,
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Icons.book,
                                size: 60,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // 📝 Book title
                          MyText(
                            text: book['title'] ?? "Unknown Book",
                            size: 16,
                            fontWeight: FontWeight.bold,
                            color: themeProvider.primaryTextColor,
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 6),

                          // 👨‍💻 Author name
                          MyText(
                            text: authorName,
                            size: 14,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.primaryTextColor
                                .withOpacity(0.7),
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
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
    );
  }
}
