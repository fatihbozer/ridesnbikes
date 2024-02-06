import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rides_n_bikes/providers/user_provider.dart';
import 'package:rides_n_bikes/resources/firestore_methods.dart';
import 'package:rides_n_bikes/rnb_Widgets/comment_card.dart';
import 'package:rides_n_bikes/rnb_models/user.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({super.key, required this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentTextEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    commentTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments').orderBy('datePublished', descending: false).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) => CommentCard(
              snap: (snapshot.data! as dynamic).docs[index].data(),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(user.profileImageUrl),
              radius: 18,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TextField(
                  controller: commentTextEditingController,
                  decoration: InputDecoration(
                    hintText: 'comment as ${user.username}...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await FirestoreMethods().postComment(
                  widget.snap['postId'],
                  commentTextEditingController.text,
                  user.uid,
                  user.username,
                  user.profileImageUrl,
                );
                setState(() {
                  commentTextEditingController.clear();
                });
              },
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
