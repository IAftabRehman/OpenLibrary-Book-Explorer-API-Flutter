import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/AppBarWidget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BookRead extends StatelessWidget {
  final String ocaid;

  const BookRead({super.key, required this.ocaid});

  @override
  Widget build(BuildContext context) {
    final pdfUrl = "https://archive.org/download/$ocaid/$ocaid.pdf";
    return Scaffold(
      appBar: AppBarWidget(titleText: "Book Read", searchIcon: false),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
