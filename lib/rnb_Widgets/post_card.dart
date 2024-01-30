import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rnb_Widgets/write_comment.dart';
import 'package:rides_n_bikes/rnb_Widgets/share_post.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String date;
  final String likes;
  final String comments;
  final String description;
  final String location;

  const PostCard({required this.username, this.date = "12:00", required this.likes, required this.comments, required this.description, required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //HEADER SECTION

        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ).copyWith(right: 0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30.0,
                backgroundImage: CachedNetworkImageProvider('https://i0.wp.com/sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png?ssl=1'),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(fontFamily: 'Formula1bold'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            date,
                            style: const TextStyle(fontSize: 12),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                              ),
                              Text(
                                location,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
            ],
          ),
        ),

        // IMAGE SECTION

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.height * 0.4,
          child: Image.network(
            'https://www.harley-davidson.com/content/dam/h-d/images/promo-images/2024/hero-cards/2-up/reveal-rg-hc2.jpg?impolicy=myresize&rw=1000',
            fit: BoxFit.cover,
          ),
        ),

        // LIKE COMMENT SECTION

        SizedBox(
          width: MediaQuery.of(context).size.height * 0.4,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite),
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
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),

        //DESCRIPTION

        SizedBox(
          width: MediaQuery.of(context).size.height * 0.4,
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

        // LIKES AND COMMENTS

        Container(
          width: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '$likes and $comments..',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),

        // DIVIDER

        const Divider(height: 50, indent: 20, endIndent: 20, color: Colors.grey),
      ],
    );
  }
}
