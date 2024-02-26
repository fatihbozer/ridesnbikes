import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/helper/helper_functions.dart';
import 'package:rides_n_bikes/methods/firestore_methods.dart';
import 'package:rides_n_bikes/rnb_Screens/ProfileScreen/EditProfile/editprofile_screen.dart';
import 'package:rides_n_bikes/rnb_Screens/ProfileScreen/Profile/ProfilePic/default_profile_image.dart';
import 'package:rides_n_bikes/rnb_Widgets/Buttons/follow_button.dart';
import 'package:rides_n_bikes/rnb_Widgets/Imagepicker/pick_profile_picture.dart';
import 'package:rides_n_bikes/rnb_Widgets/post_card.dart';
import 'package:rides_n_bikes/theme/theme.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  bool isGridMode = true;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  Uint8List? _image;
  bool isLoading = true;

  //Profilbild bearbeiten
  void selectImage() async {
    _image = await pickProfilePicture();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance.collection('Users').doc(widget.uid).get();

      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap.data()!['followers'].contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      displayMessageToUser(e.toString(), context);
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //Zahl der Abonnenten

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    followers.toString(),
                                    style: const TextStyle(fontFamily: 'Formula1bold'),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text('Followers'),
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
                                      child: FirebaseAuth.instance.currentUser!.uid == widget.uid
                                          ? CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: IconButton(
                                                onPressed: () async {
                                                  Uint8List? pickedImage = await pickProfilePicture();
                                                  if (pickedImage != null) {
                                                    FirestoreMethods().uploadProfileImage(pickedImage, userData['uid']);
                                                    setState(() {
                                                      _image = pickedImage;
                                                    });
                                                  }
                                                },
                                                icon: const Icon(Icons.add_a_photo),
                                                color: Colors.black,
                                              ),
                                            )
                                          : SizedBox.shrink(), // Wenn es nicht das eigene Profil ist, wird ein leeres Widget zurückgegeben (unsichtbarer Button).
                                    ),
                                  ],
                                ),
                              ),

                              // Zahl der Nutzer denen man folgt

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    following.toString(),
                                    style: const TextStyle(fontFamily: 'Formula1bold'),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text('Following'),
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

                          //Button für Interaktionen
                          FirebaseAuth.instance.currentUser!.uid == widget.uid
                              ? FollowButton(
                                  backgroundColor: rideMode.colorScheme.primary,
                                  text: 'Edit Profile',
                                  function: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProfileScreen(),
                                      ),
                                    );
                                  },
                                )
                              : isFollowing
                                  ? FollowButton(
                                      backgroundColor: Colors.grey,
                                      text: 'Unfollow',
                                      function: () async {
                                        await FirestoreMethods().followUser(
                                          FirebaseAuth.instance.currentUser!.uid,
                                          userData['uid'],
                                        );
                                        setState(() {
                                          isFollowing = false;
                                          followers--;
                                        });
                                      },
                                    )
                                  : FollowButton(
                                      backgroundColor: rideMode.colorScheme.secondary,
                                      text: 'Follow',
                                      function: () async {
                                        await FirestoreMethods().followUser(
                                          FirebaseAuth.instance.currentUser!.uid,
                                          userData['uid'],
                                        );
                                        setState(() {
                                          isFollowing = true;
                                          followers++;
                                        });
                                      },
                                    ),

                          const SizedBox(height: 16),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isGridMode = true;
                              });
                            },
                            icon: Icon(Icons.grid_on),
                          ),
                          Container(
                            height: 24, // Die gewünschte Höhe des Trennstrichs
                            width: 1, // Die gewünschte Breite des Trennstrichs
                            color: Colors.grey,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isGridMode = false;
                              });
                            },
                            icon: Icon(Icons.format_list_bulleted),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Beiträge

                      FutureBuilder(
                        future: FirebaseFirestore.instance.collection('posts').where('uid', isEqualTo: widget.uid).get(),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return isGridMode
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: (snapshot.data! as dynamic).docs.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                  ),
                                  itemBuilder: ((context, index) {
                                    DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                                    return Image(
                                      image: CachedNetworkImageProvider(snap['postUrl']),
                                      fit: BoxFit.cover,
                                    );
                                  }),
                                )
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: (snapshot.data! as dynamic).docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                                    return PostCard(
                                      snap: snap.data(),
                                    );
                                  },
                                );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
