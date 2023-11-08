import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rides_widgets/rides_widgets.dart';

class RidePostWidget extends StatelessWidget {
  final String username;
  final String time;
  final String likes;
  final String comments;
  final String description;

  const RidePostWidget({required this.username, this.time = "12:00", required this.likes, required this.comments, required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 36.0),
          child: Row(
            children: [
              Container(
                child: buildPostPicture(),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(fontFamily: 'Formula1bold'),
                  ),
                  Text(
                    time,
                    style: TextStyle(fontSize: 12),
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
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.only(left: 36.0),
          child: Row(
            children: [
              Text(
                username,
                style: TextStyle(fontFamily: 'Formula1bold', overflow: TextOverflow.ellipsis),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(description),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.only(right: 52.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                comments,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
