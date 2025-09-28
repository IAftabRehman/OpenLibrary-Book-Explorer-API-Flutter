import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FavoritesProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> _userBooks = [];

  List<Map<String, dynamic>> get userBooks => _userBooks;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _currentUid;

  String? get currentUid => _currentUid;

  /// Replace Firestore doc ID with ('/' to '_')
  String _sanitizeId(String rawId) {
    return rawId.replaceAll('/', '_');
  }

  /// Start listening to favorites of the logged-in user
  void listenToUserBooks() {
    final uid = _auth.currentUser?.uid;
    _currentUid = uid;

    if (uid == null) {
      _userBooks = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    _firestore
        .collection('favorites')
        .doc(uid)
        .collection('books')
        .orderBy('savedAt', descending: true)
        .snapshots()
        .listen(
          (snapshot) {
            _userBooks = snapshot.docs.map((d) {
              final data = d.data();
              return {...data, "id": d.id};
            }).toList();

            _isLoading = false;
            notifyListeners();
          },
          onError: (e) {
            debugPrint("🔥 Favorites listen error: $e");
            _isLoading = false;
            _userBooks = [];
            notifyListeners();
          },
        );
  }

  /// Add book to favorites
  Future<void> addBook(Map<String, dynamic> bookData) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    String rawId =
        (bookData['id'] ??
                bookData['ocaid'] ??
                bookData['key'] ??
                bookData['title'])
            .toString();
    final bookId = _sanitizeId(rawId);

    final docRef = _firestore
        .collection('favorites')
        .doc(uid)
        .collection('books')
        .doc(bookId);

    final payload = {
      ...bookData,
      "id": bookId,
      "savedAt": FieldValue.serverTimestamp(),
    };

    await docRef.set(payload, SetOptions(merge: true));
  }

  /// Remove from favorites
  Future<void> removeBook(String rawId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    final bookId = _sanitizeId(rawId);

    try {
      await _firestore
          .collection('favorites')
          .doc(uid)
          .collection('books')
          .doc(bookId)
          .delete();
    } catch (e) {
      debugPrint("🔥 Error removing favorite: $e");
    }
  }

  /// Check if a book is already saved
  bool isBookSaved(String rawId) {
    final bookId = _sanitizeId(rawId);
    return _userBooks.any((b) => (b['id'] ?? '').toString() == bookId);
  }

  /// Direct FireStore stream for UI (optional)
  Stream<List<Map<String, dynamic>>> favoritesStream() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return _firestore
        .collection("favorites")
        .doc(uid)
        .collection("books")
        .orderBy("savedAt", descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((d) => {"id": d.id, ...d.data()}).toList(),
        );
  }
}
