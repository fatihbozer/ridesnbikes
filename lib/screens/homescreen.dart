import 'package:flutter/material.dart';
import 'package:rides_n_bikes/screens/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(left: 52.0),
                child: Row(
                  children: [
                    Icon(Icons.heart_broken),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                      child: Icon(Icons.comment),
                    ),
                    Icon(Icons.send),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(left: 36.0),
                child: Row(
                  children: [
                    Text('Username'),
                    Text('Description'),
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
