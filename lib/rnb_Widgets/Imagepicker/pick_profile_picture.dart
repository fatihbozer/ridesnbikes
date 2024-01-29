import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickProfilePicture() async {
  final ImagePicker picker = ImagePicker();
// Bild auswählen
  final XFile? image = await picker.pickImage(source: ImageSource.camera);
// Bild aufnehmen
  if (image != null) {
    return await image.readAsBytes();
  }
  return null;
}
