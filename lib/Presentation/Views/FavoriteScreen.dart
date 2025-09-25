import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/AppBarWidget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: "Favorite", searchIcon: false),
    );
  }
}
