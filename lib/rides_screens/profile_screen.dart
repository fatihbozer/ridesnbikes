import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rides_screens/editprofile_screen.dart';
import 'package:rides_n_bikes/rides_widgets/my_button.dart';
import 'package:rides_n_bikes/rides_widgets/my_pictures.dart';
import 'package:rides_n_bikes/rides_widgets/rides_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //Benutzer
  final currentUser = FirebaseAuth.instance.currentUser!;

  /*Future<void> editField(String userData) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Profile"),
      ),
    );
  }
  */

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
            child: IconButton(
              icon: const Icon(Icons.settings),
              color: Colors.black,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
              },
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
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Zahl der Abonnenten

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

                            //Profilbild

                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: buildProfilPicture(),
                            ),

                            // Zahl der Nutzer denen man folgt

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
                        const SizedBox(height: 16),

                        //Name in der App

                        Text(
                          userData['name'],
                          style: const TextStyle(fontFamily: 'Formula1bold'),
                        ),

                        //Username in der App

                        Text(
                          "@${userData['username']}",
                          style: TextStyle(color: Colors.grey[700]),
                        ),

                        const SizedBox(height: 16),

                        //Bio im Profil

                        Text(
                          userData['bio'],
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 16),

                        //Button für Motorradwidget

                        MyButton(text: 'Test', onTap: () {}),

                        const SizedBox(height: 16),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyButton(text: 'Test', onTap: () {}),
                        MyButton(text: 'Test', onTap: () {})
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

                    // Bilder für Beiträge

                    const MyPictures(),
                    const MyPictures(),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
