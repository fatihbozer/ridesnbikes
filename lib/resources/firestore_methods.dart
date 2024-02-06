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
}
