import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickImage() async {
  final ImagePicker picker = ImagePicker();
// Bild auswählen
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// Bild aufnehmen
  if (image != null) {
    return await image.readAsBytes();
  }
  return null;
}
