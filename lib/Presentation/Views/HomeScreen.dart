import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomContainer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background.jpg",
              fit: BoxFit.cover,
            ),
          ),
          MyContainer(
            color: Colors.black.withOpacity(0.6)
          ),
          Center(
            child: Text(
              "OpenLibrary Book Explorer",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ],
      )
    );
  }
}
