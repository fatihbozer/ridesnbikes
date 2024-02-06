import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String username;
  final String location;
  final String postId;
  final datePublished;
  final String uid;
  final String profileImageUrl;
  final likes;
  final String postUrl;

  const Post({
    required this.description,
    required this.username,
    required this.location,
    required this.postId,
    required this.datePublished,
    required this.uid,
    required this.profileImageUrl,
    required this.likes,
    required this.postUrl,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'username': username,
        'location': location,
        'postId': postId,
        'datePublished': datePublished,
        'uid': uid,
        'profileImageUrl': profileImageUrl,
        'likes': likes,
        'postUrl': postUrl,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      description: snapshot['description'],
      username: snapshot['username'],
      location: snapshot['location'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      uid: snapshot['uid'],
      profileImageUrl: snapshot['profileImageUrl'],
      likes: snapshot['likes'],
      postUrl: snapshot['postUrl'],
    );
  }
}
