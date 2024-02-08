import 'dart:io';
import 'dart:typed_data';
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
    String selectedBrand,
    String selectedModel,
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
        selectedBrand: selectedBrand,
        selectedModel: selectedModel,
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

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap = await _firestore.collection('Users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('Users').doc(followId).update({
          'followers': FieldValue.arrayRemove([
            uid
          ])
        });

        await _firestore.collection('Users').doc(uid).update({
          'following': FieldValue.arrayRemove([
            followId
          ])
        });
      } else {
        await _firestore.collection('Users').doc(followId).update({
          'followers': FieldValue.arrayUnion([
            uid
          ])
        });

        await _firestore.collection('Users').doc(uid).update({
          'following': FieldValue.arrayUnion([
            followId
          ])
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<void> uploadProfileImage(Uint8List imageBytes, String uid) async {
    try {
      print('Start uploading profile image...');
      String fileName = 'profile_images/$uid.jpg';

      await _storage.ref(fileName).putData(imageBytes);

      // Nach dem Upload kannst du den Download-URL abrufen, um es im Profil anzuzeigen oder es in der Firestore-Datenbank zu speichern.
      String downloadURL = await _storage.ref(fileName).getDownloadURL();

      // Speichere den Download-URL in der Firestore-Datenbank oder aktualisiere das vorhandene Benutzerdokument.
      await FirebaseFirestore.instance.collection("Users").doc(uid).update({
        'profileImageUrl': downloadURL,
      });

      // Beiträge des Benutzers abrufen
      final userPostsCollection = FirebaseFirestore.instance.collection('posts').where('uid', isEqualTo: uid);
      final userPosts = await userPostsCollection.get();

      // Profilbild-URL in jedem Beitrag aktualisieren
      for (final postDoc in userPosts.docs) {
        final postId = postDoc.id;
        await FirebaseFirestore.instance.collection('posts').doc(postId).update({
          'profileImageUrl': downloadURL,
        });
      }

      print('Profile image uploaded successfully!');
    } catch (error) {
      print('Error uploading profile image: $error');
    }
  }
}
