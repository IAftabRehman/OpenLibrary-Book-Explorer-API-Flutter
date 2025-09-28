import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  /// Favorite Means (Add To Favorite)
  static Future<void> toggleFavorite(Map<String, dynamic> book) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final favRef = _firestore
        .collection("users")
        .doc(user.uid)
        .collection("favorites")
        .doc(book["id"].toString());

    final snapshot = await favRef.get();

    if (snapshot.exists) {
      await favRef.delete();
    } else {
      await favRef.set({
        "title": book["title"],
        "author": book["author"],
        "coverId": book["coverId"],
        "ocaid": book["ocaid"],
        "timestamp": FieldValue.serverTimestamp(),
      });
    }
  }

  /// Showing there Favorite Books
  static Stream<bool> isFavorite(String bookId) {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    return _firestore
        .collection("users")
        .doc(user.uid)
        .collection("favorites")
        .doc(bookId)
        .snapshots()
        .map((doc) => doc.exists);
  }
}
