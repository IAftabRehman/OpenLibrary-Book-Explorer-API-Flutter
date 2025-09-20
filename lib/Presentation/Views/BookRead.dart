import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookRead extends StatelessWidget {
  final String bookUrl;

  const BookRead({super.key, required this.bookUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Read Book")),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(bookUrl)),
      ),
    );
  }
}
