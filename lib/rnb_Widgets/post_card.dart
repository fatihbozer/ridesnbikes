import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rides_n_bikes/helper/helper_functions.dart';
import 'package:rides_n_bikes/providers/user_provider.dart';
import 'package:rides_n_bikes/methods/firestore_methods.dart';
import 'package:rides_n_bikes/rnb_Screens/CommentScreen/comment_screen.dart';
import 'package:rides_n_bikes/rnb_Widgets/like_animation.dart';
import 'package:rides_n_bikes/rnb_Models/user.dart';

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
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments').get();

      commentLen = snap.docs.length;
    } catch (e) {
      displayMessageToUser(e.toString(), context);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
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

                      // falls kein Standort hinzugefügt wurde kein Icon und Standort anzeigen

                      if (widget.snap['location'] != null && widget.snap['location'].isNotEmpty)
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
              IconButton(
                onPressed: () {
                  if (widget.snap['uid'] == user.uid) {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          shrinkWrap: true,
                          children: [
                            'Delete',
                          ]
                              .map(
                                (e) => InkWell(
                                  onTap: () async {
                                    FirestoreMethods().deletePost(widget.snap['postId']);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                    child: Text(e),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.more_vert),
              )
            ],
          ),
        ),

        // IMAGE SECTION

        GestureDetector(
          onDoubleTap: () async {
            await FirestoreMethods().likePost(
              widget.snap['postId'],
              user.uid,
              widget.snap['likes'],
            );
            setState(() {
              isLikeAnimating = true;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.height * 0.4,
                child: Image.network(
                  widget.snap['postUrl'],
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
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                    onPressed: () async {
                      await FirestoreMethods().likePost(
                        widget.snap['postId'],
                        user.uid,
                        widget.snap['likes'],
                      );
                      setState(() {
                        isLikeAnimating = true;
                      });
                    },
                    icon: widget.snap['likes'].contains(user.uid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(Icons.favorite_border)),
              ),
              IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(
                      snap: widget.snap,
                    ),
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
              const Padding(padding: EdgeInsets.only(top: 8)),
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
                  widget.snap['datePublished'].toDate(),
                ),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(
                      snap: widget.snap,
                    ),
                  ),
                ),
                child: Text(
                  'view all $commentLen comments',
                  style: const TextStyle(color: Colors.grey),
                ),
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
