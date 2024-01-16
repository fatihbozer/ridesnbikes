import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickImage() async {
  final ImagePicker picker = ImagePicker();
// Pick an image.
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
  if (image != null) {
    return await image.readAsBytes();
  }

  return null;
}
