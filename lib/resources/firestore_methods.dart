import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rides_n_bikes/rnb_models/post.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadPost(
    String description,
    XFile? image,
    String uid,
    String username,
    String location,
    String profileImageUrl,
  ) async {
    print('Image before upload: $image');
    String res = 'some error occurred';
    try {
      String fileName = 'posts/$uid.jpg';

      await _storage.ref(fileName).putFile(File(image!.path));
      String photoUrl = await _storage.ref(fileName).getDownloadURL();

      String postId = Uuid().v1();

      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        location: location,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profileImageUrl: profileImageUrl,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
    } catch (err) {
      print('Error during upload: $err');
      res = err.toString();
    }
    print('Image after upload: $image');
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([
            uid
          ]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([
            uid
          ]),
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<void> postComment(String postId, String text, String uid, String username, String profileImageUrl) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
          'profileImageUrl': profileImageUrl,
          'username': username,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
      } else {
        print('Text is empty');
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }
}
