import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rides_n_bikes/rnb_Widgets/Buttons/my_button.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> editProfile(BuildContext context) async {
    String newName = nameController.text.trim();
    String newBio = bioController.text.trim();
    String newUsername = usernameController.text.trim();

    // Überprüfe, ob die nicht leeren Textfelder die Mindestlänge erreichen
    bool isNameValid = newName.isNotEmpty && newName.length >= 3;
    bool isUsernameValid = newUsername.isNotEmpty && newUsername.length >= 3 && newUsername.length <= 20; // Hinzugefügt: Überprüfung für die maximale Länge

    if (isNameValid && isUsernameValid) {
      // Aktualisiere nur die nicht leeren und gültigen Profilinformationen in der Datenbank
      Map<String, dynamic> updateData = {};
      if (newName.isNotEmpty) updateData['name'] = newName;
      if (newBio.isNotEmpty) updateData['bio'] = newBio;
      if (newUsername.isNotEmpty) updateData['username'] = newUsername;

      await FirebaseFirestore.instance.collection("Users").doc(currentUser.email).update(updateData);

      // Optional: Zurück zum vorherigen Screen
      Navigator.pop(context);
    } else {
      // Zeige eine Meldung an, wenn die Mindestlänge für Name und Username nicht erreicht ist
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please enter valid values for Name, Bio, and Username.'),
              Text('Minimum length for Name and Username is 3 characters.'),
              Text('Username must be 20 characters or less.'), // Hinzugefügt: Meldung für die maximale Länge
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'New Username', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'New Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bioController,
              decoration: const InputDecoration(labelText: 'New Bio', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            MyButton(
              text: 'Save',
              onTap: () => editProfile(context),
            ),
          ],
        ),
      ),
    );
  }
}
