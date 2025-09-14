import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/AppBarWidget.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/Drawer.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomContainer.dart';
import 'package:provider/provider.dart';

import '../../Providers/ChangeModeProvider.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.transparent,
      appBar: AppBarWidget(titleText: "Help", searchIcon: false),
      drawer: DrawerWidget(),
      body: MyContainer(
        decoration: BoxDecoration(
          gradient: themeProvider.backgroundColor
        ),
      ),
    );
  }
}
