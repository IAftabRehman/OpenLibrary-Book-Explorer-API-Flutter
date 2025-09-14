import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LibraryProvider extends ChangeNotifier {
  bool isLoading = false;
  List<dynamic> books = [];

  Future<void> fetchBooksByCategory(String category) async {
    try {
      isLoading = true;
      notifyListeners();

      final url = Uri.parse(
        "https://openlibrary.org/subjects/$category.json?limit=10",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        books = data['works'] ?? []; 
      } else {
        books = [];
        debugPrint("❌ Failed to load books: ${response.statusCode}");
      }
    } catch (e) {
      books = [];
      debugPrint("❌ Error fetching books: $e");
    } finally {
      isLoading = false; // ✅ stop loading here always
      notifyListeners();
    }
  }
}
