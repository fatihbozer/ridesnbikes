import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rnb_Screens/PostScreen/upload_screen.dart';
import 'package:rides_n_bikes/rnb_Widgets/Buttons/camera_button.dart';
import 'package:rides_n_bikes/rnb_Widgets/Imagepicker/pick_profile_picture.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
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
            onTap: () async {
              XFile? capturedImage = await cameraController.takePicture();
              if (mounted) {
                print('Picture saved to ${capturedImage.path}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadScreen(image: capturedImage),
                  ),
                );
              }
            },
            child: cameraButton(Icons.camera_alt_outlined, Alignment.bottomCenter),
          ),
          GestureDetector(
            onTap: pickProfilePicture,
            child: cameraButton(Icons.photo, Alignment.bottomRight),
          ),
        ],
      ),
    );
  }
}
