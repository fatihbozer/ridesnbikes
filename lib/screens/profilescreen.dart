import 'package:flutter/material.dart';
import 'package:rides_n_bikes/screens/widgets.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16), // Abstand vom oberen Rand
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '99k',
                            style: TextStyle(fontFamily: 'Formula1bold'),
                          ),
                          SizedBox(height: 2),
                          Text('Followers'),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: buildProfilPicture(),
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '14',
                            style: TextStyle(fontFamily: 'Formula1bold'),
                          ),
                          SizedBox(height: 2),
                          Text('Following'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), //Abstand zwischen Bild und Benutzername
                  const Text(
                    'RideBike',
                    style: TextStyle(fontFamily: 'Formula1bold'),
                  ),
                  const Text('@RidesnBikes'),
                  const SizedBox(height: 16), //Abstand zwischen Benutzername und Profil-Bio
                  const Text(
                    'My Name is Ride. I like riding my Harley and meet some new Bikers.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 100,
                    height: 50,
                    color: Colors.black,
                  ), //Platzhalter für Motorradwidget
                  const SizedBox(height: 16),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    color: Colors.black,
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'All',
                    style: TextStyle(fontFamily: 'Formula1bold'),
                  ),
                  Text(
                    'Photos',
                    style: TextStyle(fontFamily: 'Formula1bold'),
                  ),
                  Text(
                    'Videos',
                    style: TextStyle(fontFamily: 'Formula1bold'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(height: 180, width: 180, color: Colors.black),
                  Container(height: 180, width: 180, color: Colors.black),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(height: 180, width: 180, color: Colors.black),
                  Container(height: 180, width: 180, color: Colors.black),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
