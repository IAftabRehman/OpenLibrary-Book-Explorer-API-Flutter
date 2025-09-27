import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:openlibrary_book_explorer/Models/OnBoardingModel.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomBottom.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomImageView.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomText.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Configuration/SharedPreference.dart';
import '../../Providers/ChangeModeProvider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();

  List<OnBoardingModel> model = [
    OnBoardingModel(
      title: "Discover Books",
      subTitle:
          "Search millions of books by title, author. Find exactly what you’re looking for in seconds.",
      image: "assets/icons/onBoarding1.png",
    ),
    OnBoardingModel(
      title: "Explore Authors & Editions",
      subTitle:
          "Dive into author profiles, read book details, and browse different editions with ease.",
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller, // ✅ Assign controller here
                itemCount: model.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 200),

                          /// Image
                          CommonImageView(
                            imagePath: model[index].image,
                            scale: 3,
                          ),
                          const SizedBox(height: 20),

                          /// Title
                          MyText(
                            text: model[index].title.toString(),
                            size: 24,
                            color: themeProvider.primaryTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 10),

                          /// Subtitle
                          MyText(
                            text: model[index].subTitle.toString(),
                            size: 17,
                            color: themeProvider.secondaryTextColor,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// 🔵 SmoothPageIndicator at the bottom
            SmoothPageIndicator(
              controller: controller,
              count: model.length,
              effect: JumpingDotEffect(
                dotColor: Colors.white,
                activeDotColor: Colors.blue,
                spacing: 15,
                dotHeight: 13,
                dotWidth: 13,
              ),
              onDotClicked: (index) {
                controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
            const SizedBox(height: 20),

            /// Skip Button
            MyButton(
              paddingLeft: 100,
              paddingRight: 100,
              paddingBottom: 5,
              paddingTop: 10,
              btnLabel: "Skip",
              borderRadius: BorderRadius.circular(20),
              onPressed: () async {
                await AppPreferences.setOnBoardingSeen(true);
                Navigator.pushNamed(context, AppRoutes.home);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
