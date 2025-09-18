import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookRead extends StatelessWidget {
  final String? bookUrl;
  const BookRead({super.key, this.bookUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read Book"),
        backgroundColor: Colors.deepPurple,
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(bookUrl!)),
      ),
    );
  }
}
