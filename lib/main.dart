import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rnb_Screens/auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rides_n_bikes/theme/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: rideMode,
      title: "rides n' Bikes",
      home: const AuthPage(),
    );
  }
}
