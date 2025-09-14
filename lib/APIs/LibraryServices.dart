import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenLibraryService {
  Future<List<dynamic>> fetchCategoryBooks(String category) async {
    final url = Uri.parse("https://openlibrary.org/subjects/$category.json");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['works'];
    } else {
      throw Exception("Failed to load books for $category");
    }
  }
}
