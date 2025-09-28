import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:provider/provider.dart';
import 'package:openlibrary_book_explorer/Providers/ChangeModeProvider.dart';
import '../../Models/CategoriesModel.dart';
import '../CommonWidgets/AppBarWidget.dart';
import '../CommonWidgets/Drawer.dart';
import '../Elements/CustomContainer.dart';
import '../Elements/CustomText.dart';
import '../Elements/CustomTextField.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool openSearch = false;
  String searchQuery = "";

  /// Categories Model
  List<CategoriesModel> categoriesModel = [
    CategoriesModel(name: "Architecture", link: "architecture"),
    CategoriesModel(name: "Art Instruction", link: "art__art_instruction"),
    CategoriesModel(
      name: "Art History",
      link: "history_of_art__art__design_styles",
    ),
    CategoriesModel(name: "Dance", link: "dance"),
    CategoriesModel(name: "Design", link: "design"),
    CategoriesModel(name: "Fashion", link: "fashion"),
    CategoriesModel(name: "Film", link: "film"),
    CategoriesModel(name: "Graphic Design", link: "graphic_design"),
    CategoriesModel(name: "Music", link: "music"),
    CategoriesModel(name: "Music Theory", link: "music_theory"),
    CategoriesModel(name: "Painting", link: "painting__paintings"),
    CategoriesModel(name: "Photography", link: "photography"),
    CategoriesModel(name: "Bears", link: "bears"),
    CategoriesModel(name: "Cats", link: "cats"),
    CategoriesModel(name: "Kittens", link: "kittens"),
    CategoriesModel(name: "Dogs", link: "dogs"),
    CategoriesModel(name: "Puppies", link: "puppies"),
    CategoriesModel(name: "Fantasy", link: "fantasy"),
    CategoriesModel(name: "Historical Fiction", link: "historical_fiction"),
    CategoriesModel(name: "Horror", link: "horror"),
    CategoriesModel(name: "Humor", link: "humor"),
    CategoriesModel(name: "Literature", link: "literature"),
    CategoriesModel(name: "Magic", link: "magic"),
    CategoriesModel(
      name: "Mystery and Detective Stories",
      link: "mystery_and_detective_stories",
    ),
    CategoriesModel(name: "Plays", link: "plays"),
    CategoriesModel(name: "Poetry", link: "poetry"),
    CategoriesModel(name: "Romance", link: "romance"),
    CategoriesModel(name: "Science Fiction", link: "science_fiction"),
    CategoriesModel(name: "Short Stories", link: "short_stories"),
    CategoriesModel(name: "Thriller", link: "thriller"),
    CategoriesModel(name: "Young Adult", link: "young_adult_fiction"),
    CategoriesModel(name: "Biology", link: "biology"),
    CategoriesModel(name: "Chemistry", link: "chemistry"),
    CategoriesModel(name: "Mathematics", link: "mathematics"),
    CategoriesModel(name: "Physics", link: "physics"),
    CategoriesModel(name: "Programming", link: "programming"),
    CategoriesModel(name: "Management", link: "management"),
    CategoriesModel(name: "Entrepreneurship", link: "entrepreneurship"),
    CategoriesModel(name: "Business Economics", link: "business__economics"),
    CategoriesModel(name: "Business Success", link: "success_in_business"),
    CategoriesModel(name: "Finance", link: "finance"),
    CategoriesModel(name: "Juvenile Literature", link: "juvenile_literature"),
    CategoriesModel(name: "Infancy", link: "infancy"),
    CategoriesModel(name: "Stories in Rhyme", link: "stories_in_rhyme"),
    CategoriesModel(name: "Bedtime Books", link: "bedtime"),
    CategoriesModel(name: "Picture Books", link: "picture_books"),
    CategoriesModel(name: "Ancient Civilization", link: "ancient_civilization"),
    CategoriesModel(name: "Archaeology", link: "archaeology"),
    CategoriesModel(name: "Anthropology", link: "anthropology"),
    CategoriesModel(name: "Mental Health", link: "mental_health"),
    CategoriesModel(name: "Exercise", link: "exercise"),
    CategoriesModel(name: "Nutrition", link: "nutrition"),
    CategoriesModel(name: "Self-help", link: "self-help"),
    CategoriesModel(name: "Autobiographies", link: "autonutritionbiography"),
    CategoriesModel(name: "Religion", link: "religion"),
    CategoriesModel(name: "Political Science", link: "political_science"),
    CategoriesModel(name: "Psychology", link: "psychology"),
  ];

  @override
  Widget build(BuildContext context) {
    /// Theme Provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    /// Categories Name Filtered by Search Bar
    List<CategoriesModel> filteredCategories = categoriesModel
        .where(
          (cat) => cat.name.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,

        /// AppBar Widget
        appBar: AppBarWidget(
          titleText: "Book Categories",
          searchIcon: true,
          onSearchToggle: (isOpen) {
            setState(() {
              openSearch = isOpen;
              if (!isOpen) searchQuery = ""; // reset filter when closed
            });
          },
        ),

        /// Drawer Widget
        drawer: const DrawerWidget(),

        /// Body Start
        body: MyContainer(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(gradient: themeProvider.backgroundColor),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Search Box
              if (openSearch)
                MyTextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  backgroundColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  textFieldBorder: Border.all(
                    width: 2,
                    color: themeProvider.primaryTextColor,
                  ),
                  hintText: "Search Categories...",
                  hintColor: themeProvider.primaryTextColor,
                  cursorColor: themeProvider.primaryTextColor,
                  textColor: themeProvider.primaryTextColor,
                  textSize: 16,
                ),
              const SizedBox(height: 10),

              /// Main Content
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: MyContainer(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.individualCategory,
                            arguments: {
                              "name": filteredCategories[index].name,
                              "link": filteredCategories[index].link,
                            },
                          );
                        },
                        height: 60,
                        width: double.infinity,
                        color: themeProvider.buttonBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: filteredCategories[index].name,
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
