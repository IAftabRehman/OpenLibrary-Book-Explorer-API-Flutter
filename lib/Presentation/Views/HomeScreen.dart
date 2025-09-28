import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/Drawer.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomImageView.dart';
import 'package:openlibrary_book_explorer/Providers/AuthenticationProvider.dart';
import 'package:openlibrary_book_explorer/Providers/ChangeModeProvider.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:openlibrary_book_explorer/Models/AuthorsModel.dart';
import 'package:openlibrary_book_explorer/Models/CategoriesModel.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomContainer.dart';
import 'package:openlibrary_book_explorer/Providers/FavoriteProvider.dart';
import 'package:provider/provider.dart';
import '../../Providers/LibraryProvider.dart';
import '../Elements/CustomText.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Categories Model (Categories Content)
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

  /// Authors Model (Some Authors Name That is Shown on Home Screen)
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

  final user = FirebaseAuth.instance.currentUser;

  /// Fetching Trending Book
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


  @override
  Widget build(BuildContext context) {

    /// Theme Provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    /// Favorite Book Shown Provider
    final favoriteProvider = Provider.of<FavoritesProvider>(context);

    /// Authentication Provider
    final authProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      /// AppBar Widget
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.2),
        elevation: 0,

        /// Leading Icon
        leading: MyIconContainer(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icons.menu,
          iconSize: 30,
          iconColor: Colors.white70,
        ),

        /// Main Title Text
        title: MyText(
          text: "OpenLibrary Book Explorer",
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          size: 22,
        ),
      ),

      /// Drawer Widget
      drawer: DrawerWidget(),

      /// Body Start
      body: SafeArea(
        child: Stack(
          children: [

            /// Background Image
            Positioned.fill(
              child: Image.asset(
                "assets/images/background.jpg",
                fit: BoxFit.cover,
              ),
            ),

            /// Foreground Content
            MyContainer(
              color: Colors.black.withValues(alpha: 0.6),
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Tending Books Section
                  Consumer<LibraryProvider>(
                    builder: (context, libraryProvider, _) {
                      if (libraryProvider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                  child: MyContainer(
                                    width: 120,
                                    // Already defined
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: themeProvider.backgroundColor,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.1,
                                          ),
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
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: MyContainer(
                                            height: 50,
                                            width: double.infinity,
                                            color: Colors.black54,
                                            child: CommonImageView(
                                              imagePath:
                                                  themeProvider.isNightMode
                                                  ? 'assets/icons/darkModeBook.png'
                                                  : 'assets/icons/lightModeBook.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
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
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 30),

                  /// Book Categories Section
                  listViewContainer(
                    context,
                    themeProvider,
                    "Book Categories",
                    () {
                      Navigator.pushNamed(context, AppRoutes.categories);
                    },
                    categoriesModel,
                  ),
                  const SizedBox(height: 30),

                  /// Authors Name Section
                  listViewContainer(context, themeProvider, "Book Authors", () {
                    Navigator.pushNamed(context, AppRoutes.authors);
                  }, authorsModel),
                  const SizedBox(height: 30),

                  /// Favorite Books Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              text: "Favorite Books",
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
                                  AppRoutes.favorite,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      !authProvider.isLoggedIn
                          ? Center(
                              child: MyContainer(
                                color: Colors.red.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(10),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: MyText(
                                  text: "Login to see your favorites",
                                  size: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : MyContainer(
                              height: 120,
                              child: StreamBuilder<List<Map<String, dynamic>>>(
                                stream: favoriteProvider.favoritesStream(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return Center(
                                      child: MyText(
                                        text: "No favorite books yet",
                                        color: Colors.white70,
                                      ),
                                    );
                                  }

                                  final favorites = snapshot.data!;

                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: favorites.length,
                                    itemBuilder: (context, index) {
                                      final book = favorites[index];

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (book["ocaid"] != null) {
                                              Navigator.pushNamed(
                                                context,
                                                AppRoutes.bookRead,
                                                arguments: {
                                                  "ocaid": book["ocaid"],
                                                },
                                              );
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "No PDF available",
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: MyContainer(
                                            width: 100,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5,
                                              vertical: 5,
                                            ),
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.green,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child:
                                                      book["coverUrl"] != null
                                                      ? Image.network(
                                                          book["coverUrl"],
                                                          height: 70,
                                                          width: 70,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Container(
                                                          height: 70,
                                                          width: 70,
                                                          color: Colors.grey,
                                                          child: const Icon(
                                                            Icons.book,
                                                            size: 40,
                                                          ),
                                                        ),
                                                ),
                                                const SizedBox(height: 6),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      MyText(
                                                        text:
                                                            book["title"] ??
                                                            "No Title",
                                                        size: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        maxLines: 1,
                                                        textOverflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Custom ListView Widget
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
                MyText(
                  text: titleName,
                  size: 18,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
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
