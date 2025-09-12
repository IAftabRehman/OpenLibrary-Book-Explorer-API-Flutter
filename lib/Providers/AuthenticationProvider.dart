import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Models/RegistrationModel.dart';
import 'package:openlibrary_book_explorer/Services/AuthenticationServices.dart';
import 'package:openlibrary_book_explorer/Services/RegistrationServices.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool isLoading = false;

  Future signUp(
    String name,
    int age,
    String phoneNumber,
    String email,
    String password,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      // Step 1: Register with Authentication Service
      await AuthenticationServices().registerUser(
        email: email,
        password: password,
      );

      // Step 2: Save user data in Firestore (or DB)
      await RegistrationServices().createAccount(
        RegistrationModel(
          docId: DateTime.now().toIso8601String(),
          createdAt: DateTime.now().microsecondsSinceEpoch,
          name: name,
          age: age,
          phoneNumber: phoneNumber,
          email: email,
          password: password,
        ),
      );

      // Success → stop loading
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint("SignUp Error: ${e.toString()}");
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      await AuthenticationServices().loginUser(
        email: email,
        password: password,
      );

      isLoading = false;
      notifyListeners();
      return true;

    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint("❌ Login Error: ${e.toString()}");
      return false; // ❌ failure
    }
  }

}
