import 'package:flutter/material.dart';
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
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.transparent,
      appBar: AppBarWidget(titleText: "Authors", searchIcon: true),
      drawer: DrawerWidget(),
      body: SafeArea(
        child: MyContainer(
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: MyContainer(
                              height: 70,
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
                                  Expanded(
                                    child: MyText(
                                      text: libraryProvider.books[index].toString(),
                                      size: 18,
                                      fontWeight: FontWeight.bold,
                                      color: themeProvider.primaryTextColor,
                                    ),
                                  ),
                                  Image.asset('assets/icons/author.png', height: 50, width: 50, fit: BoxFit.cover,)
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
