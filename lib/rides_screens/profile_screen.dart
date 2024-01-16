import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rides_screens/editprofile_screen.dart';
import 'package:rides_n_bikes/rides_widgets/my_button.dart';
import 'package:rides_n_bikes/rides_widgets/my_pictures.dart';
import 'package:rides_n_bikes/rides_widgets/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  Uint8List? _image;

  //Profilbild bearbeiten
  void selectImage() async {
    _image = await pickImage();
    setState(() {});
  }

  // Funktion zum Bearbeiten der Profilinformationen
  Future<void> editProfile() async {
    String newName = "";
    String newBio = "";
    String newUsername = "";

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(labelText: 'New Username', border: OutlineInputBorder()),
                onChanged: (value) {
                  newUsername = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(labelText: 'New Name', border: OutlineInputBorder()),
                onChanged: (value) {
                  newName = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(labelText: 'New Bio', border: OutlineInputBorder()),
                onChanged: (value) {
                  newBio = value;
                },
              ),
            ),
          ],
        ),
        actions: [
          MyButton(
            text: 'Cancel',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 8,
          ),
          MyButton(
            onTap: () async {
              // Überprüfe, ob die nicht leeren Textfelder die Mindestlänge erreichen
              bool isNameValid = newName.isEmpty || (newName.isNotEmpty && newName.length >= 3);
              bool isUsernameValid = newUsername.isEmpty || (newUsername.isNotEmpty && newUsername.length >= 3);

              if (isNameValid && isUsernameValid) {
                // Aktualisiere nur die nicht leeren und gültigen Profilinformationen in der Datenbank
                Map<String, dynamic> updateData = {};
                if (newName.isNotEmpty) updateData['name'] = newName;
                if (newBio.isNotEmpty) updateData['bio'] = newBio;
                if (newUsername.isNotEmpty) updateData['username'] = newUsername;

                await FirebaseFirestore.instance.collection("Users").doc(currentUser.email).update(updateData);
                Navigator.pop(context);
              } else {
                // Zeige eine Meldung an, wenn die Mindestlänge für Name und Username nicht erreicht ist
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Please enter valid values for Name, Bio, and Username.'),
                        Text('Minimum length for Name and Username is 3 characters.'),
                      ],
                    ),
                  ),
                );
              }
            },
            text: 'Save',
          ),
        ],
      ),
    );
  }

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
                              child: Stack(
                                children: [
                                  _image != null
                                      ? CircleAvatar(
                                          radius: 64,
                                          backgroundImage: MemoryImage(_image!),
                                        )
                                      : const CircleAvatar(
                                          radius: 64.0,
                                          backgroundImage: CachedNetworkImageProvider('https://i0.wp.com/sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png?ssl=1'),
                                        ),
                                  Positioned(
                                    bottom: -10,
                                    left: 80,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                        onPressed: selectImage,
                                        icon: const Icon(Icons.add_a_photo),
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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

                        MyButton(text: 'edit Profile', onTap: editProfile),

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
