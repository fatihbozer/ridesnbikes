import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rnb_Widgets/comment_card.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: CommentCard(),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            FutureBuilder(
                future: getUserProfile(),
                builder: (context, snapshot) {
                  return CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider("${snapshot.data}"),
                    radius: 18,
                  );
                }),
            FutureBuilder(
                future: getUsername(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Comment as ${snapshot.data}',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  );
                }),
            InkWell(
              onTap: () async {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 8,
                ),
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

Future<String> getUserProfile() async {
  final user = FirebaseAuth.instance.currentUser;
  final userData = await FirebaseFirestore.instance.collection('Users').doc(user!.email).get();
  final profileImageUrl = userData['profileImageUrl'];

  return profileImageUrl;
}

Future<String> getUsername() async {
  final user = FirebaseAuth.instance.currentUser;
  final userData = await FirebaseFirestore.instance.collection('Users').doc(user!.email).get();
  final username = userData['username'];

  return username;
}
