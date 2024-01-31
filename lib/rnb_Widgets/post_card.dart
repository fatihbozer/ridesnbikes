import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rides_n_bikes/rnb_Widgets/write_comment.dart';
import 'package:rides_n_bikes/rnb_Widgets/share_post.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({
    required this.snap,
    super.key,
  });
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
              CircleAvatar(
                radius: 30.0,
                backgroundImage: CachedNetworkImageProvider(snap['profileImageUrl']),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snap['username'],
                        style: const TextStyle(fontFamily: 'Formula1bold'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                              ),
                              Text(
                                snap['location'],
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
            snap['imageUrl'],
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
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                ),
                child: Text(
                  '${snap['likes'].length} likes..',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Row(
                children: [
                  Text(
                    snap['username'],
                    style: const TextStyle(fontFamily: 'Formula1bold', overflow: TextOverflow.ellipsis),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(snap['description']),
                  ),
                ],
              ),
            ],
          ),
        ),

        //COMMENTS

        Container(
          width: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${snap['likes'].length} likes..',
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
