import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LibraryProvider extends ChangeNotifier {
  bool isLoading = false;
  List<dynamic> books = [];
  List authors = [];

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


}
