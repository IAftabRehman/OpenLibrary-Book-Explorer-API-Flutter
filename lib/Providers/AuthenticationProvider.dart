import 'package:flutter/cupertino.dart';
import 'package:openlibrary_book_explorer/Models/RegistrationModel.dart';
import 'package:openlibrary_book_explorer/Services/AuthenticationServices.dart';
import 'package:openlibrary_book_explorer/Services/RegistrationServices.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool isLoading = false;

  void SignUp(
    String name,
    int age,
    String phoneNumber,
    String email,
    String password,
  ) async {
    try {
      isLoading = true;
      notifyListeners();
      AuthenticationServices().registerUser(email: email, password: password);
      RegistrationServices().createAccount(
        RegistrationModel(
          docId: DateTime.now().toString(),
          createdAt: DateTime.now().microsecondsSinceEpoch,
          name: name,
          age: age,
          phoneNumber: phoneNumber,
          email: email,
          password: password,
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
