import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/Drawer.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomImageView.dart';
import 'package:openlibrary_book_explorer/Providers/ChangeModeProvider.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:openlibrary_book_explorer/Models/AuthorsModel.dart';
import 'package:openlibrary_book_explorer/Models/CategoriesModel.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomContainer.dart';
import 'package:provider/provider.dart';

import '../../Models/FavouriteBookModel.dart';
import '../../Providers/LibraryProvider.dart';
import '../Elements/CustomText.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  List<AuthorsModel> authorsModel = [
    AuthorsModel(name: "J.K. Rowling"),
    AuthorsModel(name: "George R.R. Martin"),
    AuthorsModel(name: "Jane Austen"),
    AuthorsModel(name: "Charles Dickens"),
    AuthorsModel(name: "Mark Twain"),
    AuthorsModel(name: "Agatha Christie"),
    AuthorsModel(name: "Ernest Hemingway"),
    AuthorsModel(name: "J.R.R. Tolkien"),
    AuthorsModel(name: "Leo Tolstoy"),
    AuthorsModel(name: "Stephen King"),
    AuthorsModel(name: "Joseph D. Bates, Jr."),
    AuthorsModel(name: "James D. Lester, Sr."),
    AuthorsModel(name: "Robert Deward Mason"),
    AuthorsModel(name: "Charles Dana Gibson"),
    AuthorsModel(name: "Thomas Dionysius Clark"),
    AuthorsModel(name: "M. D. D. Evans"),
    AuthorsModel(name: "Hugh D.Young"),
    AuthorsModel(name: "Donald D. Spencer"),
    AuthorsModel(name: "Anthony D. Smith"),
    AuthorsModel(name: "Christian d' Elvert"),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<LibraryProvider>(
        context,
        listen: false,
      ).fetchTrendingBookForHome();
    });
  }

  List<FavouriteBookModel> favouriteBookModel = [
    FavouriteBookModel(name: "Fiction"),
    FavouriteBookModel(name: "Non-Fiction"),
    FavouriteBookModel(name: "Science"),
    FavouriteBookModel(name: "History"),
    FavouriteBookModel(name: "Technology"),
    FavouriteBookModel(name: "Kids"),
    FavouriteBookModel(name: "Businesses"),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // final libraryProvider = Provider.of<LibraryProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.2),
        elevation: 0, // remove shadow
        leading: MyIconContainer(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icons.menu,
          iconSize: 30,
          iconColor: Colors.white70,
        ),
        title: MyText(
          text: "OpenLibrary Book Explorer",
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          size: 22,
        ),
      ),
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/background.jpg",
                fit: BoxFit.cover,
              ),
            ),
            MyContainer(
              color: Colors.black.withOpacity(0.6),
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  Consumer<LibraryProvider>(
                    builder: (context, libraryProvider, _) {
                      if (libraryProvider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔹 Header
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  text: "Trending Books",
                                  size: 18,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                                MyText(
                                  text: "See All",
                                  color: Colors.green,
                                  decoration: TextDecoration.underline,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.trendingBook,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          MyContainer(
                            height: 110,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: libraryProvider.trendingBooks.length,
                              itemBuilder: (context, index) {
                                var book = libraryProvider.trendingBooks[index];
                                return GestureDetector(
                                  onTap: () {
                                    if (book["ocaid"] != null) {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.bookRead,
                                        arguments: {"ocaid": book["ocaid"]},
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("No PDF available"),
                                        ),
                                      );
                                    }
                                  },
                                  child: Expanded(
                                    child: MyContainer(
                                      width: 120,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            themeProvider.buttonBackgroundColor,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: const Offset(2, 3),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(6),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // 📕 Small Book Cover
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: MyContainer(
                                              height: 50,
                                              width: double.infinity,
                                              color: Colors.black54,
                                              child: CommonImageView(imagePath: themeProvider.isNightMode ? 'assets/icons/darkModeBook.png' : 'assets/icons/lightModeBook.png', fit: BoxFit.contain,)
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                    
                                          // 📝 Smaller Title
                                          MyText(
                                            text: book['title'] ?? "Unknown",
                                            size: 14,
                                            fontWeight: FontWeight.bold,
                                            color: themeProvider.primaryTextColor,
                                            maxLines: 2,
                                            textOverflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 50),

                  listViewContainer(
                    context,
                    themeProvider,
                    "Book Categories",
                    () {
                      Navigator.pushNamed(context, AppRoutes.categories);
                    },
                    categoriesModel,
                  ),

                  const SizedBox(height: 50),

                  listViewContainer(context, themeProvider, "Book Authors", () {
                    Navigator.pushNamed(context, AppRoutes.authors);
                  }, authorsModel),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  MyContainer listViewContainer(
    BuildContext context,
    ThemeProvider themeProvider,
    String titleName,
    VoidCallback? onTap,
    List modelName,
  ) {
    return MyContainer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(text: titleName, size: 18, color: Colors.white70, fontWeight: FontWeight.bold),
                MyText(
                  text: "See All",
                  color: Colors.green,
                  decoration: TextDecoration.underline,
                  onTap: onTap,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: modelName.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: MyContainer(
                    onTap: () {
                      titleName == "Book Categoires"
                          ? Navigator.pushNamed(
                              context,
                              AppRoutes.individualCategory,
                              arguments: {
                                "name": categoriesModel[index].name,
                                "link": categoriesModel[index].link,
                              },
                            )
                          : Navigator.pushNamed(context, AppRoutes.authors);
                    },
                    decoration: BoxDecoration(
                      gradient: themeProvider.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Center(
                      child: MyText(
                        text: modelName[index].name,
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
    );
  }
}
