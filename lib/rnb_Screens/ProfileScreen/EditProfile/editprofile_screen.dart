import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rides_n_bikes/methods/auth_methods.dart';
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

    AuthMethods authMethods = AuthMethods();

    String updateResult = await authMethods.updateUserProfile(
      newName: newName,
      newUsername: newUsername,
      newBio: newBio,
    );

    if (updateResult == 'success') {
      // Optional: Navigate back or show a success message
      Navigator.pop(context);
    } else {
      // Handle the error, show a message, etc.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(updateResult),
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
