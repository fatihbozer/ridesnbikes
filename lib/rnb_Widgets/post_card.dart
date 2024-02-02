import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rides_n_bikes/rnb_Screens/CommentScreen/comment_screen.dart';
import 'package:rides_n_bikes/rnb_Widgets/like_animation.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    required this.snap,
    super.key,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    bool isCurrentUserLiked = widget.snap['likes'].contains(currentUser?.uid);

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
                backgroundImage: CachedNetworkImageProvider(widget.snap['profileImageUrl']),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.snap['username'],
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
                                widget.snap['location'],
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

        GestureDetector(
          onDoubleTap: () {
            setState(() {
              isLikeAnimating = true;
            });

            // Überprüfe, ob der Benutzer den Beitrag bereits geliked hat
            if (isCurrentUserLiked) {
              // Entferne Like aus der Datenbank
              removeLikeFromPost(widget.snap['postId']);
            } else {
              // Füge Like zur Datenbank hinzu
              addLikeToPost(widget.snap['postId']);
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.height * 0.4,
                child: Image.network(
                  widget.snap['imageUrl'],
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: isLikeAnimating,
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                  onEnd: () {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  },
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 120,
                  ),
                ),
              ),
            ],
          ),
        ),

        // LIKE COMMENT ICONS SECTION

        SizedBox(
          width: MediaQuery.of(context).size.height * 0.4,
          child: Row(
            children: [
              LikeAnimation(
                  isAnimating: isCurrentUserLiked,
                  smallLike: true,
                  child: IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      if (isCurrentUserLiked) {
                        // Entferne Like aus der Datenbank
                        removeLikeFromPost(widget.snap['postId']);
                      } else {
                        // Füge Like zur Datenbank hinzu
                        addLikeToPost(widget.snap['postId']);
                      }
                    },
                  )),
              IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {},
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

        //LIKES AND DESCRIPTION

        SizedBox(
          width: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.snap['likes'].length} user liked this..',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Padding(padding: EdgeInsets.only(top: 8)),
              Row(
                children: [
                  Text(
                    widget.snap['username'],
                    style: const TextStyle(fontFamily: 'Formula1bold', overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(width: 10.0), // Abstand zwischen Username und Beschreibung
                  Expanded(
                    child: Text(
                      widget.snap['description'],
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMMd().format(
                  widget.snap['timestamp'].toDate(),
                ),
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                '${widget.snap['likes'].length} likes..',
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
