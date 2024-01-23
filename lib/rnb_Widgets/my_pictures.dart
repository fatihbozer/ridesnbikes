import 'package:flutter/material.dart';

class MyPictures extends StatelessWidget {
  const MyPictures({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              height: 180,
              width: 180,
              child: Image(
                image: AssetImage('assets/images/harley-davidson1.jpg'),
                fit: BoxFit.cover,
              )),
          SizedBox(
              height: 180,
              width: 180,
              child: Image(
                image: AssetImage('assets/images/harley-davidson2.jpg'),
                fit: BoxFit.cover,
              )),
        ],
      ),
      SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              height: 180,
              width: 180,
              child: Image(
                image: AssetImage('assets/images/harley-davidson3.jpg'),
                fit: BoxFit.cover,
              )),
          SizedBox(
              height: 180,
              width: 180,
              child: Image(
                image: AssetImage('assets/images/harley-davidson4.jpg'),
                fit: BoxFit.cover,
              )),
        ],
      ),
      SizedBox(height: 16),
    ]);
  }
}
