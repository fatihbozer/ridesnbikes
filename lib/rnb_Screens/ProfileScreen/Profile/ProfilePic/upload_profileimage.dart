import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future<void> uploadProfileImage(Uint8List imageBytes, String userEmail) async {
  try {
    print('Start uploading profile image...');
    String fileName = 'profile_images/$userEmail.jpg';

    await firebase_storage.FirebaseStorage.instance.ref(fileName).putData(imageBytes);

    // Nach dem Upload kannst du den Download-URL abrufen, um es im Profil anzuzeigen oder es in der Firestore-Datenbank zu speichern.
    String downloadURL = await firebase_storage.FirebaseStorage.instance.ref(fileName).getDownloadURL();

    // Speichere den Download-URL in der Firestore-Datenbank oder aktualisiere das vorhandene Benutzerdokument.
    await FirebaseFirestore.instance.collection("Users").doc(userEmail).update({
      'profileImageUrl': downloadURL,
    });
    print('Profile image uploaded successfully!');
  } catch (error) {
    print('Error uploading profile image: $error');
  }
}
