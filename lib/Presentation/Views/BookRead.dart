import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/AppBarWidget.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/Drawer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BookRead extends StatelessWidget {
  final String ocaid;

  BookRead({super.key, required this.ocaid});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    /// PDF URL
    final pdfUrl = "https://archive.org/download/$ocaid/$ocaid.pdf";
    return Scaffold(
      key: _scaffoldKey,

      /// AppBar Widget
      appBar: AppBarWidget(titleText: "Book Read", searchIcon: false),

      /// Drawer Widget
      drawer: DrawerWidget(),

      /// Body Start
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
