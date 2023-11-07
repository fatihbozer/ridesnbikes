import 'package:flutter/material.dart';
import 'package:rides_n_bikes/screens/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const Icon(
              Icons.chat_bubble_outline,
              color: Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 36.0),
                child: Row(
                  children: [
                    Container(
                      child: buildPostPicture(),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(fontFamily: 'Formula1bold'),
                        ),
                        Text(
                          '13 minutes ago',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(width: 320, height: 320, color: Colors.black),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.only(left: 52.0),
                child: Row(
                  children: [
                    Icon(Icons.heart_broken),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      child: Icon(Icons.comment),
                    ),
                    Icon(Icons.send),
                    Padding(
                      padding: EdgeInsets.only(left: 52.0),
                      child: Text('213 Persons liked this.'),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              const Padding(
                padding: EdgeInsets.only(left: 36.0),
                child: Row(
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(fontFamily: 'Formula1bold'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text('Description'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.only(right: 52.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'show comments..',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
