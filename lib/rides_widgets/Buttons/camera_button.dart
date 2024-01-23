import 'package:flutter/material.dart';

Widget cameraButton(IconData icon, Alignment alignment) {
  return Align(
    alignment: alignment,
    child: Container(
      margin: const EdgeInsets.only(left: 20, bottom: 50, right: 20),
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    ),
  );
}
