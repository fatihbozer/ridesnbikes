import 'package:flutter/material.dart';
import 'package:rides_n_bikes/screens/widgets.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
              const SizedBox(height: 20), // Abstand vom oberen Rand
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
                        child: buildCoverImage(),
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
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(
                      'All',
                      style: TextStyle(fontFamily: 'Formula1bold'),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Photos',
                      style: TextStyle(fontFamily: 'Formula1bold'),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Videos',
                      style: TextStyle(fontFamily: 'Formula1bold'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(height: 150, width: 150, color: Colors.black),
                  Container(height: 150, width: 150, color: Colors.black),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(height: 150, width: 150, color: Colors.black),
                  Container(height: 150, width: 150, color: Colors.black),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
