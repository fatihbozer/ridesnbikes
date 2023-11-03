import 'package:flutter/material.dart';
import 'package:rides_n_bikes/screens/homescreen.dart';
import 'package:rides_n_bikes/screens/searchscreen.dart';
import 'package:rides_n_bikes/screens/editscreen.dart';
import 'package:rides_n_bikes/screens/bikescreen.dart';
import 'package:rides_n_bikes/screens/profilescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'rides n Bikes',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
