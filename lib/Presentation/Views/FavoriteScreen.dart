import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Presentation/CommonWidgets/AppBarWidget.dart';

import '../CommonWidgets/Drawer.dart';

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
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.red,
      appBar: AppBarWidget(titleText: "Favorite Books", searchIcon: false),
      drawer: DrawerWidget(),
      body: user == null
          ? const Center(child: Text("Please log in to see favorites"))
          : StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user?.uid)
            .collection("favorites")
            .orderBy("timestamp", descending: true)
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

              return ListTile(
                leading: book["coverUrl"] != null
                    ? Image.network(book["coverUrl"], width: 50, fit: BoxFit.cover)
                    : const Icon(Icons.book),
                title: Text(book["title"] ?? "No Title"),
                subtitle: Text(book["author"] ?? "Unknown Author"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(user?.uid)
                        .collection("favorites")
                        .doc(favorites[index].id)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

