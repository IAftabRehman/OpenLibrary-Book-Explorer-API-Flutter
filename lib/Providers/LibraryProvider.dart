import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LibraryProvider extends ChangeNotifier {
  bool isLoading = false;
  List<dynamic> trendingBooks = [];
  List<dynamic> books = [];
  List authors = [];
  List selectedAuthor = [];

  /// Fetching Trending Book For Home Screen
  Future<void> fetchTrendingBookForHome() async {
    isLoading = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse("https://openlibrary.org/trending/daily.json?limit=10"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      trendingBooks = data["works"] ?? [];
    }

    isLoading = false;
    notifyListeners();
  }

  /// Fetching Trending Books For Trending Screen (Book and Author name)
  Future<void> fetchTrendingBooks() async {
    try {
      isLoading = true;
      notifyListeners();

      final url = Uri.parse(
        "https://openlibrary.org/trending/now.json?limit=20",
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final works = (data['works'] as List?) ?? [];

        books = works.map<Map<String, dynamic>>((work) {
          final workKey = work['key'];
          final ocaid = (work['ia'] != null && work['ia'].isNotEmpty)
              ? work['ia'][0]
              : null;
          final coverId = work['cover_i'];
          final String id =
              (workKey ?? ocaid ?? coverId?.toString() ?? work['title'])
                  .toString();

          final String? coverUrl = coverId != null
              ? "https://covers.openlibrary.org/b/id/$coverId-M.jpg"
              : null;

          return {
            "id": id,
            "key": workKey,
            "title": work["title"] ?? "Unknown Title",
            "coverId": coverId,
            "coverUrl": coverUrl,
            "ocaid": ocaid,
            "author":
                (work["author_name"] != null && work["author_name"].isNotEmpty)
                ? work["author_name"][0]
                : "Unknown Author",
          };
        }).toList();
      } else {
        books = [];
        debugPrint("❌ Failed to load books: ${response.statusCode}");
      }
    } catch (e) {
      books = [];
      debugPrint("🔥 Error fetching books: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Fetching Book by Categories
  Future<void> fetchBooksByCategory(String category) async {
    try {
      isLoading = true;
      notifyListeners();

      final url = Uri.parse(
        "https://openlibrary.org/subjects/$category.json?limit=100",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        books = (data['works'] as List)
            .map(
              (book) => {
                "title": book["title"],
                "authors": book["authors"],
                "coverId": book["cover_id"], // ✅ cover_id for book images
                "key": book["key"], // unique identifier
              },
            )
            .toList();
      } else {
        books = [];
        debugPrint("Failed to load books: ${response.statusCode}");
      }
    } catch (e) {
      books = [];
      debugPrint("Error fetching books: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Fetching Authors Name by characters
  Future<void> fetchAllAuthors() async {
    try {
      isLoading = true;
      notifyListeners();

      List allAuthors = [];

      for (var char in 'abcdefghijklmnopqrstuvwxyz'.split('')) {
        final url = Uri.parse(
          "https://openlibrary.org/search/authors.json?q=$char",
        );
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final docs = data['docs'] ?? [];
          allAuthors.addAll(docs);
        }
      }

      authors = allAuthors;
    } catch (e) {
      authors = [];
      debugPrint("❌ Error fetching authors: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Fetching Author Name
  Future<Map<String, dynamic>?> fetchAuthorDetails(String authorKey) async {
    try {
      isLoading = true;
      notifyListeners();

      final url = Uri.parse("https://openlibrary.org$authorKey.json");
      debugPrint("📡 Fetching: $url");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        debugPrint("❌ Failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("❌ Error fetching author details: $e");
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Fetching a readable link for a book (if available)
  Future<String?> fetchReadableLink(String workKey) async {
    try {
      final url = Uri.parse(
        "https://openlibrary.org$workKey/editions.json?limit=1",
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['entries'] != null && data['entries'].isNotEmpty) {
          final edition = data['entries'][0];

          // ✅ If edition has an Internet Archive ID → readable online
          if (edition['ocaid'] != null) {
            return "https://archive.org/stream/${edition['ocaid']}";
          }

          // ✅ Fallback: edition URL on OpenLibrary
          if (edition['key'] != null) {
            return "https://openlibrary.org${edition['key']}";
          }
        }
      } else {
        debugPrint("❌ Failed to load editions: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("🔥 Error fetching readable link: $e");
    }

    return null; // no readable copy
  }

  /// Fetching Favorite Books
  Future<void> addToFavorites(Map<String, dynamic> book) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("favorites")
        .doc(book["id"]);

    await docRef.set({
      "title": book["title"],
      "author": book["author"],
      "coverUrl": book["coverUrl"],
      "timestamp": FieldValue.serverTimestamp(),
    });
  }
}
