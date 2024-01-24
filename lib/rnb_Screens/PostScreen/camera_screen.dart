import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rnb_Screens/ProfileScreen/Profile/ProfilePic/pick_image.dart';
import 'package:rides_n_bikes/rnb_Widgets/Buttons/camera_button.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  int direction = 0;

  late Future<void> _cameraInitialization;

  @override
  void initState() {
    _cameraInitialization = initializeCamera();
    super.initState();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _cameraInitialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildCameraWidget();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget buildCameraWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: CameraPreview(cameraController)),
          GestureDetector(
            onTap: () {
              setState(() {
                direction = direction == 0 ? 1 : 0;
                _cameraInitialization = initializeCamera();
              });
            },
            child: cameraButton(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
          ),
          GestureDetector(
            onTap: () {
              cameraController.takePicture().then((XFile? image) {
                if (mounted) {
                  if (image != null) {
                    print('Picture saved to ${image.path}');
                  }
                }
              });
            },
            child: cameraButton(Icons.camera_alt_outlined, Alignment.bottomCenter),
          ),
          GestureDetector(
            onTap: pickImage,
            child: cameraButton(Icons.photo, Alignment.bottomRight),
          ),
        ],
      ),
    );
  }
}
