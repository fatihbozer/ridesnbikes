import 'package:flutter/material.dart';
import 'package:rides_n_bikes/resources/auth_methods.dart';
import 'package:rides_n_bikes/rnb_models/user.dart';
/*
class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
*/

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser =>
      _user ??
      User(
        email: '', // Füge hier Standardwerte ein oder lass es leer, je nach Bedarf
        username: '',
        name: '',
        bio: '',
        profileImageUrl: '',
        uid: '',
        followers: [],
        following: [],
      );

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
