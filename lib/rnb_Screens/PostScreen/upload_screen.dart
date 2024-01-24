import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final XFile? image;

  UploadScreen({super.key, required this.image});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  XFile? image;
  TextEditingController descriptionTextEditingController = TextEditingController();
  TextEditingController locationTextEditingController = TextEditingController();

  removeImage() {
    setState(() {
      image = null;
    });
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
            onPressed: () {},
            child: const Text('Share'),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").doc(widget.currentUser.email).snapshots(),
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
