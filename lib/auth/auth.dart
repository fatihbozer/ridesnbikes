import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rides_n_bikes/auth/login_or_register.dart';
import 'package:rides_n_bikes/main.dart';
import 'package:rides_n_bikes/rides_screens/home_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("waiting");
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              print("error");
              return Text('Ein Fehler ist aufgetreten!');
            } else if (snapshot.hasData) {
              print("logged in");
              return MainFeedPage();
            } else {
              print("not logged in");
              return const LoginOrRegister();
            }
          }),
    );
  }
}
