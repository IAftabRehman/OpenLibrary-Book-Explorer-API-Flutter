import 'package:cloud_firestore/cloud_firestore.dart';

class BookStoreService {
  final _firestore = FirebaseFirestore.instance;

  /// Save book under a specific user
  Future<void> saveBookForUser({
    required String userDocId,
    required Map<String, dynamic> bookData,
  }) async {
    final bookId =
        bookData["id"]?.toString() ??
        bookData["ocaid"]?.toString() ??
        bookData["title"];

    await _firestore
        .collection("createAccount")
        .doc(userDocId)
        .collection("books")
        .doc(bookId)
        .set({...bookData, "savedAt": FieldValue.serverTimestamp()});
  }

  /// Get all books of a specific user
  Stream<List<Map<String, dynamic>>> getUserBooks(String userDocId) {
    return _firestore
        .collection("createAccount")
        .doc(userDocId)
        .collection("books")
        .orderBy("savedAt", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  /// Remove a book for a specific user
  Future<void> removeBookForUser({
    required String userDocId,
    required String bookId,
  }) async {
    await _firestore
        .collection("createAccount")
        .doc(userDocId)
        .collection("books")
        .doc(bookId)
        .delete();
  }
}
