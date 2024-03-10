import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rides_n_bikes/helper/helper_functions.dart';
import 'package:rides_n_bikes/rnb_Screens/HomeScreen/Home/mainfeed.dart';
import 'package:rides_n_bikes/providers/user_provider.dart';
import 'package:rides_n_bikes/methods/firestore_methods.dart';
import 'package:rides_n_bikes/rnb_Widgets/brands_models.dart';
import 'package:rides_n_bikes/rnb_Models/user.dart';

class UploadScreen extends StatefulWidget {
  XFile? image;
  UploadScreen({super.key, required this.image});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  XFile? image;
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController locationTextEditingController = TextEditingController();
  bool _isLoading = false;
  String? selectedBrand;
  String? selectedModel;

  void postImage(
    String uid,
    String username,
    String profileImageUrl,
    XFile? image,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        descriptionTextEditingController.text,
        widget.image,
        uid,
        username,
        locationTextEditingController.text,
        profileImageUrl,
        selectedBrand ?? '',
        selectedModel ?? '',
      );

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainFeedPage()),
            (route) => false);
      } else {
        setState(() {
          _isLoading = false;
        });
        displayMessageToUser(res, context);
      }
    } catch (e) {
      displayMessageToUser(e.toString(), context);
    }
  }

  removeImage() {
    setState(() {
      image = null;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Teste, ob Ortungsdienste aktiviert sind
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Ortungsdienste sind deaktiviert.');
    }

    // Überprüfe die Berechtigungen
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Ortungsberechtigungen verweigert.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Ortungsberechtigungen wurden dauerhaft verweigert.');
    }

    // Wenn wir hier sind, sind die Berechtigungen erteilt und wir können die Position abrufen
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getUserCurrentLocation() async {
    try {
      // Bestimme die Position
      Position position = await _determinePosition();

      // Hole die Platzinformationen für die erhaltene Position
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      // Extrahiere die erste Platzmarkierung (Annahme: Es gibt mindestens eine Platzmarkierung)
      Placemark mPlaceMark = placeMarks[0];

      // Baue die vollständige Adresse
      String completeAddressInfo =
          '${mPlaceMark.subThoroughfare} ${mPlaceMark.thoroughfare}, ${mPlaceMark.subLocality} ${mPlaceMark.locality}, ${mPlaceMark.subAdministrativeArea} ${mPlaceMark.administrativeArea}, ${mPlaceMark.postalCode} ${mPlaceMark.country}';

      // Baue die spezifische Adresse
      String specificAddress = '${mPlaceMark.locality}, ${mPlaceMark.country}';

      // Setze die Adresse im Textfeld
      locationTextEditingController.text = specificAddress;
    } catch (e) {
      // Behandle Fehler, z.B. keine Berechtigungen oder deaktivierte Ortungsdienste
      print("Fehler beim Abrufen der Position: $e");
      // Hier kannst du eine Benachrichtigung an den Benutzer senden oder andere Aktionen durchführen
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            removeImage();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text('New Post'),
        actions: [
          TextButton(
            onPressed: () => postImage(
                user.uid, user.username, user.profileImageUrl, widget.image),
            child: const Text('Share'),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              // IMAGE

              SizedBox(
                height: 320,
                width: 320,
                child: widget.image != null &&
                        File(widget.image!.path).existsSync()
                    ? Image.file(
                        File(widget.image!.path),
                        fit: BoxFit.cover,
                      )
                    : const Placeholder(),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12),
              ),

              //DESCRIPTION

              ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(user.profileImageUrl),
                ),
                title: SizedBox(
                  width: 250,
                  child: TextField(
                    controller: descriptionTextEditingController,
                    decoration: const InputDecoration(
                        hintText: 'Write description here...',
                        border: InputBorder.none),
                  ),
                ),
              ),
              const Divider(indent: 20, endIndent: 20, color: Colors.grey),

              // SELECT BIKE

              ListTile(
                leading: const Icon(Icons
                    .motorcycle), // Fügen Sie das gewünschte Motorrad-Icon hinzu
                title: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    hintText: 'Select Brand...',
                    border: InputBorder.none,
                  ),
                  value: selectedBrand,
                  items: bikeBrands.map((String brand) {
                    return DropdownMenuItem<String>(
                      value: brand,
                      child: Text(brand),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedBrand = value;
                      selectedModel = null; // Reset model when brand changes
                    });
                  },
                ),
              ),
              if (selectedBrand != null)
                ListTile(
                  leading: const Icon(Icons
                      .motorcycle), // Fügen Sie das gewünschte Motorrad-Icon hinzu
                  title: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      hintText: 'Select Model...',
                      border: InputBorder.none,
                    ),
                    value: selectedModel,
                    items: bikeModels[selectedBrand!]!.map((String model) {
                      return DropdownMenuItem<String>(
                        value: model,
                        child: Text(model),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedModel = value;
                      });
                    },
                  ),
                ),
              const Divider(indent: 20, endIndent: 20, color: Colors.grey),

              //LOCATION

              ListTile(
                leading: const Icon(
                  Icons.person_pin_circle_outlined,
                  color: Colors.black,
                ),
                title: SizedBox(
                  width: 250,
                  child: TextField(
                    controller: locationTextEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Location...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const Divider(indent: 20, endIndent: 20, color: Colors.grey),
              Container(
                width: 250,
                alignment: Alignment.center,
                child: TextButton.icon(
                  onPressed: getUserCurrentLocation,
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                  label: const Text('Get my current Location.'),
                ),
              ),
            ],
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
