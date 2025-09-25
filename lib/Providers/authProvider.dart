import 'package:flutter/material.dart';
import '../Models/RegistrationModel.dart';
import '../Services/AuthenticationServices.dart';
import '../Services/RegistrationServices.dart';

class AutheProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = false;

  String? _name;
  String? _email;
  String? _profilePic;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  String get name => _name ?? "Guest User";
  String get email => _email ?? "Login to continue";
  String get profilePic => _profilePic ?? "assets/images/default_user.png";

  /// 🔄 Update loading state
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// 📝 SIGNUP
  Future<void> signUp(
      String name,
      int age,
      String phoneNumber,
      String email,
      String password,
      ) async {
    try {
      isLoading = true;

      // Step 1: Firebase Auth Registration
      final user = await AuthenticationServices().registerUser(
        email: email,
        password: password,
      );

      if (user == null) {
        throw Exception("User registration failed!");
      }

      // Step 2: Save user details in Firestore
      await RegistrationServices().createAccount(
        RegistrationModel(
          docId: user.uid, // ✅ use Firebase UID instead of DateTime
          createdAt: DateTime.now().microsecondsSinceEpoch,
          name: name,
          age: age,
          phoneNumber: phoneNumber,
          email: email,
          password: password,
        ),
      );

      // Update local state
      _isLoggedIn = true;
      _name = name;
      _email = email;

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint("❌ SignUp Error: ${e.toString()}");
    }
  }

  /// 🔑 LOGIN
  Future<bool> login(String email, String password) async {
    try {
      isLoading = true;

      final user = await AuthenticationServices().loginUser(
        email: email,
        password: password,
      );

      if (user != null) {
        _isLoggedIn = true;
        _email = email;
        _name = user.displayName ?? "User"; // fallback if no displayName
        _profilePic = user.photoURL;
      }

      isLoading = false;
      notifyListeners();

      return user != null;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint("❌ Login Error: ${e.toString()}");
      return false;
    }
  }

  /// 🔓 LOGOUT
  Future<void> logout() async {
    await AuthenticationServices().logoutUser();

    _isLoggedIn = false;
    _name = null;
    _email = null;
    _profilePic = null;

    notifyListeners();
  }

  /// 🔄 RESET PASSWORD
  Future<void> resetPassword(String email) async {
    try {
      await AuthenticationServices().resetPassword(email);
    } catch (e) {
      debugPrint("❌ Reset Password Error: ${e.toString()}");
    }
  }
}
