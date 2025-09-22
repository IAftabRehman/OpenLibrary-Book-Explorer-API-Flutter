import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LibraryProvider extends ChangeNotifier {
  bool isLoading = false;
  List<dynamic> books = [];
  List authors = [];
  List selectedAuthor = [];

  /// Fetch Trending Books + Author Details
  Future<void> fetchTrendingBooks() async {
    try {
      isLoading = true;
      notifyListeners();

      final url = Uri.parse("https://openlibrary.org/trending/now.json?limit=10");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final works = (data['works'] as List?) ?? [];

        // Enrich each work with author details
        books = await Future.wait(works.map((work) async {
          final authors = work['author_key'] as List?;
          List<Map<String, dynamic>> authorDetails = [];

          if (authors != null) {
            for (final key in authors) {
              try {
                final authorUrl =
                Uri.parse("https://openlibrary.org/authors/$key.json");
                final authorResponse = await http.get(authorUrl);

                if (authorResponse.statusCode == 200) {
                  final authorData = json.decode(authorResponse.body);
                  authorDetails.add(authorData);
                }
              } catch (e) {
                debugPrint("🔥 Error fetching author $key: $e");
              }
            }
          }

          // ✅ fallback to basic names if details missing
          if (authorDetails.isEmpty && work['author_name'] != null) {
            authorDetails = (work['author_name'] as List)
                .map((name) => {"name": name})
                .toList();
          }

          String? bookUrl;
          if (work['availability'] != null && work['availability']['status'] == 'open') {
            bookUrl = "https://archive.org/stream/${work['availability']['ia']}?ui=embed";
          }
          return {
            ...work,
            "author_details": authorDetails,
            "bookUrl": bookUrl, // 👈 new field
          };
        }).toList());
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




  /// Fetch Book by Categories
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
        books = data['works'] ?? [];
      } else {
        books = [];
        debugPrint("Failed to load books: ${response.statusCode}");
      }
    } catch (e) {
      books = [];
      debugPrint("Error fetching books: $e");
    } finally {
      isLoading = false; // ✅ stop loading here always
      notifyListeners();
    }
  }

  /// Fetch Authors Name by characters
  Future<void> fetchAllAuthors() async {
    try {
      isLoading = true;
      notifyListeners();

      List allAuthors = [];

      for (var char in 'abcdefghijklmnopqrstuvwxyz'.split('')) {
        final url = Uri.parse("https://openlibrary.org/search/authors.json?q=$char");
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final docs = data['docs'] ?? [];
          allAuthors.addAll(docs);
        }
      }

      authors = allAuthors; // store in your provider
    } catch (e) {
      authors = [];
      debugPrint("❌ Error fetching authors: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Fetch Author Details
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


  /// Fetch a readable link for a book (if available)
  Future<String?> fetchReadableLink(String workKey) async {
    try {
      final url =
      Uri.parse("https://openlibrary.org$workKey/editions.json?limit=1");
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



}
