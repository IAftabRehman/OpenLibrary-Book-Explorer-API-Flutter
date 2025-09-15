import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomContainer.dart';
import 'package:provider/provider.dart';

import '../../Providers/LibraryProvider.dart';
import '../../Providers/ChangeModeProvider.dart';
import '../CommonWidgets/AppBarWidget.dart';
import '../CommonWidgets/Drawer.dart';
import '../Elements/CustomText.dart';
import '../Elements/CustomTextField.dart';

class IndividualCategory extends StatefulWidget {
  final String categoryName;
  final String? categoryLink;

  const IndividualCategory({super.key, required this.categoryName, this.categoryLink});

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
      appBar: AppBarWidget(
        titleText: widget.categoryName.toString(),
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
              child: categoryProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: categoryProvider.books.length,
                itemBuilder: (context, index) {
                  final book = categoryProvider.books[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: MyContainer(
                      width: double.infinity,
                      color: themeProvider.buttonBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: book['title'] ?? "No Title",
                                  size: 16,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.primaryTextColor,
                                  maxLines: 3,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                MyText(
                                  text: (book['authors'] != null &&
                                      book['authors'].isNotEmpty)
                                      ? book['authors'][0]['name']
                                      : "Unknown Author",
                                  size: 15,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.primaryTextColor,
                                ),
                              ],
                            ),
                          ),

                          // Image
                          Image.asset(
                            themeProvider.isNightMode ?
                            "assets/icons/darkModeBook.png" : "assets/icons/lightModeBook.png",
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}
