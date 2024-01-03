import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Profile Settings'),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Change name'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('TEST'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('TEST'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('TEST'),
              onTap: () {},
            ),
          ],
        ));
  }
}
