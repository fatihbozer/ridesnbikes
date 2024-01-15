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
      home: const AuthPage(),
    );
  }
}

class MainFeedPage extends StatefulWidget {
  const MainFeedPage({Key? key}) : super(key: key);

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
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home, color: Colors.white),
            activeIcon: Icon(Icons.home, color: Theme.of(context).colorScheme.primary),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search, color: Colors.white),
            activeIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
            label: 'Suche',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add, color: Colors.white),
            activeIcon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
            label: 'Beitrag erstellen',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.motorcycle, color: Colors.white),
            activeIcon: Icon(Icons.motorcycle, color: Theme.of(context).colorScheme.primary),
            label: 'Motorrad',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person, color: Colors.white),
            activeIcon: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
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
        return const HomeScreen();
      case 1:
        return const SearchScreen();
      case 2:
        return const EditScreen();
      case 3:
        return const MotorcycleScreen();
      case 4:
        return const ProfileScreen();
      default:
        return Container();
    }
  }
}
