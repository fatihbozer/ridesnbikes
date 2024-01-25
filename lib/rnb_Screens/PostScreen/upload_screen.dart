import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:rides_n_bikes/main.dart';
import 'package:rides_n_bikes/rnb_Screens/HomeScreen/Home/home_screen.dart';

class UploadScreen extends StatefulWidget {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final XFile? image;

  UploadScreen({super.key, required this.image});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  XFile? image;
  TextEditingController descriptionTextEditingController = TextEditingController();
  TextEditingController locationTextEditingController = TextEditingController();

  removeImage() {
    setState(() {
      image = null;
    });
  }

/*
getUserCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  List<Placemark> placeMarks = await Geolocator.placemarkFromCoordinates(position.latitude, position.longitude);
  if (placeMarks.isNotEmpty) {
    Placemark mPlaceMark = placeMarks[0];
    String completeAddressInfo = '${mPlaceMark.subThoroughfare} ${mPlaceMark.thoroughfare}, ${mPlaceMark.subLocality} ${mPlaceMark.locality}, ${mPlaceMark.subAdministrativeArea} ${mPlaceMark.administrativeArea}, ${mPlaceMark.postalCode} ${mPlaceMark.country}';
    String specificAddress = '${mPlaceMark.locality}, ${mPlaceMark.country}';
    locationTextEditingController.text = specificAddress;
  } else {
    print('Keine Adresse gefunden');
  }
}
*/

  Future<void> uploadPost() async {
    try {
      final String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      final firebase_storage.Reference storageReference = firebase_storage.FirebaseStorage.instance.ref().child("posts/$imageName.jpg");

      final firebase_storage.UploadTask uploadTask = storageReference.putFile(File(widget.image!.path));

      await uploadTask.whenComplete(() async {
        final imageUrl = await storageReference.getDownloadURL();
        print('Bild hochgeladen: $imageUrl');

        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final userPostsCollection = FirebaseFirestore.instance.collection('Users').doc(currentUser.email).collection('posts');

          final postDocRef = await userPostsCollection.add({
            'imageUrl': imageUrl,
            'description': descriptionTextEditingController.text,
            'location': locationTextEditingController.text,
            'timestamp': FieldValue.serverTimestamp(),
            'likes': {}
          });

          print('Beitrag hochgeladen mit ID: ${postDocRef.id}');

          // Optional: Hier könntest du zur Hauptseite oder einer anderen Seite navigieren

          Navigator.push(context, MaterialPageRoute(builder: (context) => const MainFeedPage()));
        }
      });
    } catch (error) {
      print('Fehler beim Hochladen des Beitrags: $error');
      // Hier könntest du eine Fehlermeldung anzeigen oder andere Maßnahmen ergreifen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            removeImage();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text('New Post'),
        actions: [
          TextButton(
            onPressed: uploadPost,
            child: const Text('Share'),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
              children: [
                Container(
                  height: 320,
                  width: 320,
                  child: widget.image != null && File(widget.image!.path).existsSync()
                      ? Image.file(
                          File(widget.image!.path),
                          fit: BoxFit.cover,
                        )
                      : const Placeholder(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      userData['profileImageUrl'],
                    ),
                  ),
                  title: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: descriptionTextEditingController,
                      decoration: const InputDecoration(hintText: 'Write description here...', border: InputBorder.none),
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.person_pin_circle_outlined,
                    color: Colors.black,
                  ),
                  title: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: locationTextEditingController,
                      decoration: const InputDecoration(
                        hintText: 'Location...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                Container(
                  width: 250,
                  alignment: Alignment.center,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.black,
                    ),
                    label: const Text('Get my current Location.'),
                  ),
                ),
              ],
            );
          } else {
            // Handle the case when snapshot data is not available
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
