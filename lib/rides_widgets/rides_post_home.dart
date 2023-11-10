import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rides_widgets/rides_widgets.dart';
import 'package:rides_n_bikes/rides_widgets/rides_write_comment.dart';
import 'package:rides_n_bikes/rides_widgets/rides_share_post.dart';

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
        Padding(
          padding: EdgeInsets.only(left: 40.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.heart_broken),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  Scaffold.of(context).showBottomSheet((context) => const PostComment());
                },
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  Scaffold.of(context).showBottomSheet((context) => const PostShare());
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
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
        const SizedBox(height: 12),
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
        const Divider(height: 50, indent: 20, endIndent: 20, color: Colors.grey),
      ],
    );
  }
}
