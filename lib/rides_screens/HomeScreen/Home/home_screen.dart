import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rides_screens/HomeScreen/Chats/chat_screen.dart';
import 'package:rides_n_bikes/rides_widgets/my_drawer.dart';
import 'package:rides_n_bikes/rides_widgets/rides_post_home.dart';

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
      body: ListView(
        children: const [
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
          RidePostWidget(
            username: "Fatih",
            likes: "213 Persons liked this.",
            comments: "Show Comments...",
            description: "Description",
            time: "13:00",
          ),
        ],
      ),
    );
  }
}
