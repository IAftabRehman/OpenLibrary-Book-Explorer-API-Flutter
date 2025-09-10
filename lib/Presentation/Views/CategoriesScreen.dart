import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/ChangeMode.dart';
import 'package:openlibrary_book_explorer/Models/CategoriesModel.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomText.dart';
import 'package:provider/provider.dart';

import '../Elements/CustomContainer.dart';
import '../Elements/CustomTextField.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool openSearch = false;

  List<CategoriesModel> categoriesModel = [
    CategoriesModel(name: "Fiction"),
    CategoriesModel(name: "Non-Fiction"),
    CategoriesModel(name: "Kids"),
    CategoriesModel(name: "Science"),
    CategoriesModel(name: "History"),
    CategoriesModel(name: "Technology"),
    CategoriesModel(name: "Kids"),
    CategoriesModel(name: "Businesses"),
    CategoriesModel(name: "History"),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: MyContainer(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  openSearch
                      ? Expanded(
                          child: MyTextField(
                            backgroundColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            textFieldBorder: Border.all(
                              width: 2,
                              color: themeProvider.primaryTextColor,
                            ),
                            hintText: "Search Book",
                            hintColor: themeProvider.primaryTextColor,
                            cursorColor: themeProvider.primaryTextColor,
                            textColor: themeProvider.primaryTextColor,
                            textSize: 16,
                          ),
                        )
                      : MyText(
                          text: "Book Categories",
                          size: 20,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.primaryTextColor,
                        ),
                  const SizedBox(width: 10),
                  MyIconContainer(
                    icon: openSearch ? Icons.close : Icons.search,
                    iconColor: themeProvider.primaryTextColor,
                    iconSize: 30,
                    onTap: () {
                      setState(() {
                        openSearch = !openSearch;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Expanded(
                child: ListView.builder(
                  itemCount: categoriesModel.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: MyContainer(
                        height: 70,
                        width: double.infinity,
                        color: themeProvider.buttonBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: categoriesModel[index].name,
                            size: 18,
                            fontWeight: FontWeight.bold,
                            color: themeProvider.primaryTextColor,
                          ),
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
