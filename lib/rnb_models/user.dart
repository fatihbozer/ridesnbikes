import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String name;
  final String bio;
  final dynamic profileImageUrl;
  final String uid;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.username,
    required this.name,
    required this.bio,
    required this.profileImageUrl,
    required this.uid,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'name': name,
        'bio': bio,
        'profileImageUrl': profileImageUrl,
        'uid': uid,
        'followers': followers,
        'following': following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'],
      username: snapshot['username'],
      name: snapshot['name'],
      bio: snapshot['bio'],
      profileImageUrl: snapshot['profileImageUrl'],
      uid: snapshot['uid'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
