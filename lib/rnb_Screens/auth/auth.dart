import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rides_n_bikes/mainfeed.dart';
import 'package:rides_n_bikes/rnb_Screens/auth/Login_or_Register/Login/login_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              //Ladeindikator anzeigen
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              //Fehlermeldung anzeigen, wenn ein Fehler auftritt
              return Text('${snapshot.error}');
            } else if (snapshot.hasData) {
              //Wenn Nutzer eingeloggt ist, Homepage anzeigen
              return const MainFeedPage();
            } else {
              //Wenn Nutzer nicht eingeloggt ist, Anmeldungs- oder Registrierungsseite anzeigen
              return const LoginPage();
            }
          }),
    );
  }
}
