import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Center(
                  child: ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('H O M E'),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('TEST'),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('TEST'),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('TEST'),
                  onTap: () {},
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('L O G O U T'),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
