import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rnb_Screens/BikeScreen/bike_screen.dart';
import 'package:rides_n_bikes/rnb_Screens/HomeScreen/Home/home_screen.dart';
import 'package:rides_n_bikes/rnb_Screens/PostScreen/camera_screen.dart';
import 'package:rides_n_bikes/rnb_Screens/ProfileScreen/Profile/profile_screen.dart';
import 'package:rides_n_bikes/rnb_Screens/SearchScreen/search_screen.dart';

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
        return const CameraScreen();
      case 3:
        return const MotorcycleScreen();
      case 4:
        return const ProfileScreen();
      default:
        return Container();
    }
  }
}
