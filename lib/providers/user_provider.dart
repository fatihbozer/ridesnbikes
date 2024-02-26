import 'package:flutter/material.dart';
import 'package:rides_n_bikes/methods/auth_methods.dart';
import 'package:rides_n_bikes/rnb_Models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  User get getUser => _user!;

  Future<User?> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    return _user;
  }
}
