import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:openlibrary_book_explorer/Providers/ChangeModeProvider.dart';
import 'package:openlibrary_book_explorer/Providers/FavoriteProvider.dart';
import 'package:openlibrary_book_explorer/Providers/LibraryProvider.dart';
import 'package:provider/provider.dart';
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
      // fetch trending books
      Provider.of<LibraryProvider>(context, listen: false).fetchTrendingBooks();

      // start listening to favorites for the currently logged-in user
      final fav = Provider.of<FavoritesProvider>(context, listen: false);
      fav.listenToUserBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final libraryProvider = Provider.of<LibraryProvider>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

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
        searchIcon: false,
        onSearchToggle: (isOpen) {
          setState(() {
            openSearch = isOpen;
            if (!isOpen) searchQuery = "";
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

            // main content
            Expanded(
              child: libraryProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  final book = filteredBooks[index];

                  // compute stable book id
                  final bookId = (book['id'] ??
                      book['ocaid'] ??
                      book['key'] ??
                      book['title'])
                      .toString();

                  final coverUrl = book['coverUrl'] ??
                      (book['coverId'] != null
                          ? "https://covers.openlibrary.org/b/id/${book['coverId']}-M.jpg"
                          : null);

                  final title =
                  (book['title'] ?? 'Unknown Book').toString();
                  final author =
                  (book['author'] ?? 'Unknown Author').toString();

                  final isFav = favoritesProvider.isBookSaved(bookId);

                  return GestureDetector(
                    onTap: () {
                      if (book['ocaid'] != null) {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.bookRead,
                          arguments: {"ocaid": book['ocaid']},
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                              Text("❌ No PDF available for this book")),
                        );
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: coverUrl != null
                                    ? Image.network(
                                  coverUrl,
                                  height: 160,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return Container(
                                      height: 160,
                                      width: double.infinity,
                                      color: Colors.grey.shade300,
                                      child: const Icon(
                                        Icons.broken_image,
                                        size: 50,
                                        color: Colors.black54,
                                      ),
                                    );
                                  },
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

                              // Wrap texts in Flexible to prevent overflow
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: title,
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                      color:
                                      themeProvider.primaryTextColor,
                                      maxLines: 2,
                                      textOverflow:
                                      TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    MyText(
                                      text: author,
                                      size: 13,
                                      fontWeight: FontWeight.w500,
                                      color: themeProvider.primaryTextColor
                                          .withOpacity(0.7),
                                      maxLines: 1,
                                      textOverflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // favorite button
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () async {
                              final user =
                                  FirebaseAuth.instance.currentUser;
                              if (user == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Please log in to save favorites.")),
                                );
                                return;
                              }

                              try {
                                if (isFav) {
                                  await favoritesProvider
                                      .removeBook(bookId);
                                } else {
                                  await favoritesProvider.addBook({
                                    "id": bookId,
                                    "title": title,
                                    "author": author,
                                    "coverUrl": coverUrl,
                                    "ocaid": book['ocaid'],
                                    "key": book['key'],
                                  });
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Error updating favorites: $e")),
                                );
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white70,
                              child: Icon(
                                isFav
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFav ? Colors.red : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
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
