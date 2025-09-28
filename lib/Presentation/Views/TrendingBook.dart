import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:openlibrary_book_explorer/Providers/ChangeModeProvider.dart';
import 'package:openlibrary_book_explorer/Providers/FavoriteProvider.dart';
import 'package:openlibrary_book_explorer/Providers/LibraryProvider.dart';
import 'package:provider/provider.dart';
import '../CommonWidgets/AppBarWidget.dart';
import '../CommonWidgets/Drawer.dart';
import '../CommonWidgets/WaitingCard.dart';
import '../Elements/CustomContainer.dart';
import '../Elements/CustomText.dart';

class TrendingBook extends StatefulWidget {
  const TrendingBook({super.key});

  @override
  State<TrendingBook> createState() => _TrendingBookState();
}

class _TrendingBookState extends State<TrendingBook> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Fetch Trending Books
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<LibraryProvider>(context, listen: false).fetchTrendingBooks();
      final fav = Provider.of<FavoritesProvider>(context, listen: false);
      fav.listenToUserBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Theme Provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    /// Logical Provider
    final libraryProvider = Provider.of<LibraryProvider>(context);

    /// Favorite Book Selection Provider
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,

      /// AppBar Widget
      appBar: const AppBarWidget(
        titleText: "Trending Books",
        searchIcon: false,
      ),

      /// Drawer Widget
      drawer: const DrawerWidget(),

      /// Body Start
      body: MyContainer(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            libraryProvider.isLoading
                ? waitingCard(
                    "Please wait, fetching Trending Books may take some time...",
                  )
                : Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.65,
                          ),
                      itemCount: libraryProvider.books.length,
                      itemBuilder: (context, index) {
                        final book = libraryProvider.books[index];
                        final bookId =
                            (book['id'] ??
                                    book['ocaid'] ??
                                    book['key'] ??
                                    book['title'])
                                .toString();

                        final coverUrl =
                            book['coverUrl'] ??
                            (book['coverId'] != null
                                ? "https://covers.openlibrary.org/b/id/${book['coverId']}-M.jpg"
                                : null);

                        final title = (book['title'] ?? 'Unknown Book')
                            .toString();
                        final author = (book['author'] ?? 'Unknown Author')
                            .toString();

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
                                  content: Text(
                                    "❌ No PDF available for this book",
                                  ),
                                ),
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
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 6,
                                      offset: const Offset(2, 4),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Book Cover Photo
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
                                                      color:
                                                          Colors.grey.shade300,
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

                                    /// Book Name and Author Name
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
                                            maxLines: 1,
                                            textOverflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 6),
                                          MyText(
                                            text: author,
                                            size: 13,
                                            fontWeight: FontWeight.w500,
                                            color: themeProvider
                                                .primaryTextColor
                                                .withValues(alpha: 0.7),
                                            maxLines: 1,
                                            textOverflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// Favorite Icon on Stack
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () async {
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    if (user == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Please log in to save favorites.",
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    try {
                                      if (isFav) {
                                        await favoritesProvider.removeBook(
                                          bookId,
                                        );
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
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Error updating favorites: $e",
                                          ),
                                        ),
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
