import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rnb_Widgets/Buttons/camera_button.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  int direction = 0;

  @override
  void initState() {
    startCamera(0);
    super.initState();
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {}); //to refresh widget
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: CameraPreview(cameraController)),
            GestureDetector(
              onTap: () {
                setState(() {
                  direction = direction == 0 ? 1 : 0;
                  startCamera(direction);
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
              onTap: () {},
              child: cameraButton(Icons.photo, Alignment.bottomRight),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
