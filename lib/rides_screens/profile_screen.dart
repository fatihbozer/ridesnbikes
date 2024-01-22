import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rides_screens/editprofile_screen.dart';
import 'package:rides_n_bikes/rides_widgets/default_profile_image.dart';
import 'package:rides_n_bikes/rides_widgets/my_button.dart';
import 'package:rides_n_bikes/rides_widgets/my_pictures.dart';
import 'package:rides_n_bikes/rides_widgets/utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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

  Future<void> uploadProfileImage(Uint8List imageBytes, String userEmail) async {
    try {
      print('Start uploading profile image...');
      String fileName = 'profile_images/$userEmail.jpg';

      await firebase_storage.FirebaseStorage.instance.ref(fileName).putData(imageBytes);

      // Nach dem Upload kannst du den Download-URL abrufen, um es im Profil anzuzeigen oder es in der Firestore-Datenbank zu speichern.
      String downloadURL = await firebase_storage.FirebaseStorage.instance.ref(fileName).getDownloadURL();

      // Speichere den Download-URL in der Firestore-Datenbank oder aktualisiere das vorhandene Benutzerdokument.
      await FirebaseFirestore.instance.collection("Users").doc(userEmail).update({
        'profileImageUrl': downloadURL,
      });
      print('Profile image uploaded successfully!');
    } catch (error) {
      print('Error uploading profile image: $error');
    }
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
                                      : userData.containsKey('profileImageUrl')
                                          ? CircleAvatar(
                                              radius: 64.0,
                                              backgroundImage: CachedNetworkImageProvider(userData['profileImageUrl']),
                                            )
                                          : CircleAvatar(
                                              radius: 64.0,
                                              backgroundImage: CachedNetworkImageProvider(defaultProfileImageUrl),
                                            ),
                                  Positioned(
                                    bottom: -10,
                                    left: 80,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                        onPressed: () async {
                                          Uint8List? pickedImage = await pickImage();
                                          if (pickedImage != null) {
                                            uploadProfileImage(pickedImage, currentUser.email!);
                                            setState(() {
                                              _image = pickedImage;
                                            });
                                          }
                                        },
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

                        MyButton(
                          text: 'edit Profile',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                          },
                        ),

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
