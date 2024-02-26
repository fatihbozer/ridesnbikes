import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:rides_n_bikes/helper/helper_functions.dart';
import 'package:rides_n_bikes/providers/user_provider.dart';
import 'package:rides_n_bikes/rnb_Screens/HomeScreen/Chats/chat_screen.dart';
import 'package:rides_n_bikes/rnb_Screens/HomeScreen/Home/my_drawer.dart';
import 'package:rides_n_bikes/rnb_Widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: UserProvider().refreshUser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance.collection('posts').orderBy('datePublished', descending: true).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => PostCard(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  );
                },
              );
            } else {
              displayMessageToUser;
              return Container();
            }
          }
          displayMessageToUser;
          return Container();
        },
      ),
    );
  }
}
