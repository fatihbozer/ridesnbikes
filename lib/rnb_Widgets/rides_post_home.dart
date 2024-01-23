import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rnb_Widgets/write_comment.dart';
import 'package:rides_n_bikes/rnb_Widgets/share_post.dart';

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
              const CircleAvatar(
                radius: 30.0,
                backgroundImage: CachedNetworkImageProvider('https://i0.wp.com/sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png?ssl=1'),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(fontFamily: 'Formula1bold'),
                  ),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(width: 320, height: 320, color: Colors.black),
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.heart_broken),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () {
                  Scaffold.of(context).showBottomSheet((context) => const PostComment());
                },
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  Scaffold.of(context).showBottomSheet((context) => const PostShare());
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('213 Persons liked this.'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 36.0),
          child: Row(
            children: [
              Text(
                username,
                style: const TextStyle(fontFamily: 'Formula1bold', overflow: TextOverflow.ellipsis),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(description),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 52.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                comments,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        const Divider(height: 50, indent: 20, endIndent: 20, color: Colors.grey),
      ],
    );
  }
}
