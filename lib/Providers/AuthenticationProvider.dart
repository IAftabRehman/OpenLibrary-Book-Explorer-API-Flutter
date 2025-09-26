import 'package:flutter/material.dart';
import '../Models/RegistrationModel.dart';
import '../Services/AuthenticationServices.dart';
import '../Services/RegistrationServices.dart';

class AuthenticationProvider with ChangeNotifier {
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

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// 📝 SIGNUP
  Future<bool> signUp(
      String name,
      int age,
      String phoneNumber,
      String email,
      String password,
      ) async {
    try {
      isLoading = true;

      final user = await AuthenticationServices().registerUser(
        email: email,
        password: password,
      );

      if (user == null) throw Exception("User registration failed!");

      await user.updateDisplayName(name);
      await user.reload();

      await RegistrationServices().createAccount(
        RegistrationModel(
          docId: user.uid,
          createdAt: DateTime.now().microsecondsSinceEpoch,
          name: name,
          age: age,
          phoneNumber: phoneNumber,
          email: email,
          password: "", // ❌ don’t store raw password
        ),
      );

      _isLoggedIn = true;
      _name = name;
      _email = email;

      return true; // ✅ success
    } catch (e) {
      debugPrint("❌ SignUp Error: ${e.toString()}");
      return false; // ❌ failed
    } finally {
      isLoading = false;
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
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          throw Exception("Please verify your email before logging in.");
        }

        _isLoggedIn = true;
        _email = email;
        _name = user.displayName ?? "User";
        _profilePic = user.photoURL;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("❌ Login Error: ${e.toString()}");
      return false;
    } finally {
      isLoading = false;
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
