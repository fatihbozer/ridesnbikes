import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rides_widgets/rides_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //Benutzer
  final currentUser = FirebaseAuth.instance.currentUser!;

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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
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
                        Text(
                          userData['name'],
                          style: TextStyle(fontFamily: 'Formula1bold'),
                        ),
                        Text("@${userData['username']}"),
                        const SizedBox(height: 16), //Abstand zwischen Benutzername und Profil-Bio
                        Text(
                          userData['bio'],
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: 180,
                            width: 180,
                            child: Image(
                              image: AssetImage('assets/images/harley-davidson1.jpg'),
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                            height: 180,
                            width: 180,
                            child: Image(
                              image: AssetImage('assets/images/harley-davidson2.jpg'),
                              fit: BoxFit.cover,
                            )),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: 180,
                            width: 180,
                            child: Image(
                              image: AssetImage('assets/images/harley-davidson3.jpg'),
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                            height: 180,
                            width: 180,
                            child: Image(
                              image: AssetImage('assets/images/harley-davidson4.jpg'),
                              fit: BoxFit.cover,
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
