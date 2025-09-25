import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomContainer.dart';
import 'package:provider/provider.dart';

import '../../Configuration/Routes.dart';
import '../../Providers/LibraryProvider.dart';
import '../../Providers/ChangeModeProvider.dart';
import '../CommonWidgets/AppBarWidget.dart';
import '../CommonWidgets/Drawer.dart';
import '../Elements/CustomText.dart';
import '../Elements/CustomTextField.dart';

class IndividualCategory extends StatefulWidget {
  final String authorDetails;
  final String? categoryLink;

  const IndividualCategory({
    super.key,
    required this.authorDetails,
    this.categoryLink,
  });

  @override
  State<IndividualCategory> createState() => _IndividualCategoryState();
}

class _IndividualCategoryState extends State<IndividualCategory> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool openSearch = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<LibraryProvider>(
        context,
        listen: false,
      ).fetchBooksByCategory(widget.categoryLink.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final categoryProvider = Provider.of<LibraryProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.transparent,
      appBar: AppBarWidget(titleText: widget.authorDetails, searchIcon: true),
      drawer: DrawerWidget(),
      body: MyContainer(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (openSearch)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MyTextField(
                  backgroundColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  textFieldBorder: Border.all(
                    width: 1.5,
                    color: themeProvider.primaryTextColor,
                  ),
                  hintText: "Search in ${widget.authorDetails}",
                  hintColor: themeProvider.primaryTextColor,
                  cursorColor: themeProvider.primaryTextColor,
                  textColor: themeProvider.primaryTextColor,
                  textSize: 16,
                ),
              ),

            Expanded(
              child: categoryProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : categoryProvider.books.isEmpty
                  ? Center(
                      child: MyText(
                        text: "No books found in this category 📚",
                        size: 16,
                        fontWeight: FontWeight.w500,
                        color: themeProvider.primaryTextColor,
                      ),
                    )
                  : ListView.separated(
                      itemCount: categoryProvider.books.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final book = categoryProvider.books[index];

                        String title = book['title'] ?? "No Title";
                        String author =
                            (book['authors'] != null &&
                                book['authors'].isNotEmpty)
                            ? book['authors'][0]['name']
                            : "Unknown Author";

                        return MyContainer(
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
                                  content: Text(
                                    "No PDF available for this book",
                                  ),
                                ),
                              );
                            }
                          },
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(14),
                          color: themeProvider.buttonBackgroundColor,
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // Book Cover

                              // Book Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: title,
                                      size: 16,
                                      fontWeight: FontWeight.bold,
                                      color: themeProvider.primaryTextColor,
                                      maxLines: 2,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    MyText(
                                      text: author,
                                      size: 14,
                                      fontWeight: FontWeight.w500,
                                      color: themeProvider.primaryTextColor
                                          .withOpacity(0.8),
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: book["coverId"] != null
                                    ? Image.network(
                                        "https://covers.openlibrary.org/b/id/${book["coverId"]}-M.jpg",
                                        height: 90,
                                        width: 65,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        themeProvider.isNightMode
                                            ? "assets/icons/darkModeBook.png"
                                            : "assets/icons/lightModeBook.png",
                                        height: 90,
                                        width: 65,
                                        fit: BoxFit.cover,
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
