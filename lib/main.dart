import 'package:flutter/material.dart';
import 'package:rides_n_bikes/auth/auth.dart';
import 'package:rides_n_bikes/rides_screens/home_screen.dart';
import 'package:rides_n_bikes/rides_screens/search_screen.dart';
import 'package:rides_n_bikes/rides_screens/post_screen.dart';
import 'package:rides_n_bikes/rides_screens/bike_screen.dart';
import 'package:rides_n_bikes/rides_screens/profile_screen.dart';
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
      home: AuthPage(),
    );
  }
}

class MainFeedPage extends StatefulWidget {
  MainFeedPage({Key? key}) : super(key: key);

  @override
  _MainFeedState createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeedPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            activeIcon: Icon(Icons.home, color: Colors.orange),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white),
            activeIcon: Icon(Icons.search, color: Colors.orange),
            label: 'Suche',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Colors.white),
            activeIcon: Icon(Icons.add, color: Colors.orange),
            label: 'Beitrag erstellen',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.motorcycle, color: Colors.white),
            activeIcon: Icon(Icons.motorcycle, color: Colors.orange),
            label: 'Motorrad',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            activeIcon: Icon(Icons.person, color: Colors.orange),
            label: 'Profil',
            backgroundColor: Colors.black,
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _getScreen(_selectedIndex),
    );
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return SearchScreen();
      case 2:
        return EditScreen();
      case 3:
        return MotorcycleScreen();
      case 4:
        return ProfileScreen();
      default:
        return Container();
    }
  }
}
