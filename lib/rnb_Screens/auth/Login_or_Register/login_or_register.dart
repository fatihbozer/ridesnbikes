import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rnb_Screens/auth/Login_or_Register/Login/login_screen.dart';
import 'package:rides_n_bikes/rnb_Screens/auth/Login_or_Register/Register/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    //Methode um zwischen Anmelde- und Registrierungsseite umzuschalten
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
