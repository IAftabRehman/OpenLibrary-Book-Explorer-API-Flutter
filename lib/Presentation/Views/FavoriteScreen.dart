import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/AppBarWidget.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomContainer.dart';
import 'package:openlibrary_book_explorer/Providers/ChangeModeProvider.dart';
import 'package:provider/provider.dart';

import '../CommonWidgets/Drawer.dart';
import '../Elements/CustomText.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,
      appBar: AppBarWidget(titleText: "Favorite Books", searchIcon: false),
      drawer: DrawerWidget(),
      body: MyContainer(
        decoration: BoxDecoration(
          gradient: themeProvider.backgroundColor
        ),
        child: user == null
            ? const Center(child: Text("Please log in to see favorites"))
            : StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("favorites")
              .doc(user!.uid)
              .collection("books")
              .orderBy("savedAt", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No favorite books yet."));
            }

            final favorites = snapshot.data!.docs;

            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final book = favorites[index].data() as Map<String, dynamic>;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: MyContainer(
                    border: Border.all(width: 1, color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                    child: ListTile(
                      leading: book["coverUrl"] != null
                          ? Image.network(book["coverUrl"], width: 50, fit: BoxFit.cover)
                          : const Icon(Icons.book),
                      title: MyText(text: book["title"] ?? "No Title", fontWeight: FontWeight.bold, textOverflow: TextOverflow.ellipsis, maxLines: 1,),
                      subtitle: MyText(text: book["author"] ?? "Unknown Author", textOverflow: TextOverflow.ellipsis, maxLines: 1,),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("favorites")
                              .doc(user!.uid)
                              .collection("books")
                              .doc(favorites[index].id)
                              .delete();
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      )
    );
  }
}

