import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
class CameraXView extends StatefulWidget {
  const CameraXView({super.key});

  @override
  State<CameraXView> createState() => _CameraXViewState();
}

class _CameraXViewState extends State<CameraXView> {
  late CameraController cameraController;
  late Future<void> cameraValue;
  List<CameraDescription> cameras = [];
  List<File> imagesList = [];

  bool isFlashOn = false;
  bool isRearCamera = true;
  bool isCapturing = false;

  void takePicture() async {
    if (!cameraController.value.isInitialized || cameraController.value.isTakingPicture) return;

    try {
      await cameraController.setFlashMode(isFlashOn ? FlashMode.torch : FlashMode.off);

      setState(() => isCapturing = true);
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() => isCapturing = false);

      final image = await cameraController.takePicture();
      setState(() {
        imagesList.add(File(image.path));
      });

      if (cameraController.value.flashMode == FlashMode.torch) {
        await cameraController.setFlashMode(FlashMode.off);
      }
    } catch (e) {
      debugPrint('Error capturing image: $e');
    }
  }

  void startCamera(int cameraIndex) {
    cameraController = CameraController(
      cameras[cameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );
    cameraValue = cameraController.initialize();
  }

  Future<void> initCamera() async {
    // Give UI a moment to render before doing heavy work
    await Future.delayed(const Duration(milliseconds: 200));

    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        startCamera(0);
      } else {
        debugPrint('No cameras available');
      }
    } catch (e) {
      debugPrint('Camera init failed: $e');
    }

    if (mounted) setState(() {}); // Refresh UI
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    if (cameraController.value.isInitialized) {
      cameraController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(255, 255, 255, .7),
        shape: const CircleBorder(),
        onPressed: takePicture,
        child: const Icon(Icons.camera_alt, size: 40, color: Colors.black87),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  cameraController.value.isInitialized) {
                return SizedBox(
                  width: size.width,
                  height: size.height,
                  child: AspectRatio(
                    aspectRatio: cameraController.value.aspectRatio,
                    child: CameraPreview(cameraController),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          if (isCapturing)
            Positioned.fill(
              child: Container(color: Colors.white.withOpacity(0.3)),
            ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 5, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() => isFlashOn = !isFlashOn);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(50, 0, 0, 0),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            isFlashOn ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () {
                        if (cameras.length < 2) return;
                        setState(() => isRearCamera = !isRearCamera);
                        isRearCamera ? startCamera(0) : startCamera(1);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(50, 0, 0, 0),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            isRearCamera ? Icons.camera_rear : Icons.camera_front,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 7, bottom: 75),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imagesList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FullImageView(file: imagesList[index]),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            imagesList[index],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullImageView extends StatelessWidget {
  final File file;
  const FullImageView({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Image.file(file),
      ),
    );
  }
}


