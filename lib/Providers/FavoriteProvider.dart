import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FavoritesProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _userBooks = [];
  List<Map<String, dynamic>> get userBooks => _userBooks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _currentUid;
  String? get currentUid => _currentUid;

  /// Start listening to current user's saved books. If userId is null,
  /// this will use currently signed-in FirebaseAuth user (if any).
  void listenToUserBooks([String? userId]) {
    final uid = userId ?? FirebaseAuth.instance.currentUser?.uid;

    _currentUid = uid;
    if (uid == null) {
      _userBooks = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    _firestore
        .collection('createAccount')
        .doc(uid)
        .collection('books')
        .orderBy('savedAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      _userBooks = snapshot.docs.map((d) {
        final m = Map<String, dynamic>.from(d.data() as Map);
        // Ensure id present locally
        if (!m.containsKey('id')) {
          m['id'] = d.id;
        }
        return m;
      }).toList();

      _isLoading = false;
      notifyListeners();
    }, onError: (e) {
      debugPrint("Favorites listen error: $e");
      _isLoading = false;
      _userBooks = [];
      notifyListeners();
    });
  }

  /// Add book to the current user's favorites. bookData must contain title/author/coverUrl.
  Future<void> addBook(Map<String, dynamic> bookData) async {
    final uid = _currentUid ?? FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    // determine stable book id
    final bookId = (bookData['id'] ?? bookData['ocaid'] ?? bookData['key'] ?? bookData['title'])
        .toString();

    final docRef = _firestore
        .collection('createAccount')
        .doc(uid)
        .collection('books')
        .doc(bookId);

    final payload = {
      ...bookData,
      "id": bookId,
      "savedAt": FieldValue.serverTimestamp(),
    };

    await docRef.set(payload);
    // no need to update local list here — snapshot listener will update it.
  }

  /// Remove a saved book for current user
  Future<void> removeBook(String bookId) async {
    final uid = _currentUid ?? FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    try {
      await _firestore
          .collection('createAccount')
          .doc(uid)
          .collection('books')
          .doc(bookId)
          .delete();
    } catch (e) {
      debugPrint("Error removing favorite: $e");
      rethrow;
    }
  }

  /// Returns true if this book id exists in the user's saved list
  bool isBookSaved(String bookId) {
    if (bookId.isEmpty) return false;
    return _userBooks.any((b) => (b['id'] ?? '').toString() == bookId);
  }
}
