import 'package:image_picker/image_picker.dart';

Future<XFile?> pickPicture() async {
  final ImagePicker picker = ImagePicker();

  // Bild aus der Galerie auswählen
  final XFile? file = await picker.pickImage(source: ImageSource.gallery);

  // Rückgabe des ausgewählten XFile
  return file;
}
