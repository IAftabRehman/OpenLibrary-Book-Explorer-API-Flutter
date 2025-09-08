import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/Colors.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:openlibrary_book_explorer/Models/OnBoardingModel.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomBottom.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomImageView.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomText.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> model = [
    OnBoardingModel(
      title: "Discover Books",
      subTitle:
          "Search millions of books by title, author, or ISBN.Find exactly what you’re looking for in seconds",
      image: "assets/icons/onBoarding1.png",
    ),
    OnBoardingModel(
      title: "Explore Authors & Editions",
      subTitle:
          "Dive into author profiles, read book details,and browse different editions with ease.",
      image: "assets/icons/onBoarding2.png",
    ),
    OnBoardingModel(
      title: "Save Your Favorites",
      subTitle:
          "Sign in to build your personal library. Access your saved books anytime, anywhere.",
      image: "assets/icons/onBoarding3.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.background,
      body: PageView.builder(
        itemCount: model.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                CommonImageView(imagePath: model[index].image, scale: 3),
                SizedBox(height: 20),
                MyText(
                  text: model[index].title.toString(),
                  size: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10),
                MyText(
                  text: model[index].subTitle.toString(),
                  size: 16,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: MyButton(
        paddingLeft: 100,
        paddingRight: 100,
        paddingBottom: 10,
        paddingTop: 10,
        btnLabel: "Skip",
        borderRadius: BorderRadius.circular(20),
        onPressed: () => AppRoutes.home
      ),
    );
  }
}
