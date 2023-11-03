import 'package:flutter/material.dart';
import 'package:rides_n_bikes/screens/widgets.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        actions: const [
          Icon(
            Icons.settings,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20), // Abstand vom oberen Rand
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('99k', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text('Followers'),
                ],
              ),
              buildCoverImage(),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('14', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text('Following'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
