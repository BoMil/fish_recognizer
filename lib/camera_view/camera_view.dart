import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraView extends StatefulWidget {
  final CameraDescription? camera;
  const CameraView({super.key, required this.camera});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  XFile? _imageFromCamera;

  late Future<void> _initializeControllerFuture;

  @override
  initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  _initializeCamera() {
    // To display the current output from the Camera,
    // create a CameraController.
    if (widget.camera == null) {
      return;
    }
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera!,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  _takePhoto() async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Attempt to take a picture and get the file `image`
      // where it was saved.
      final image = await _controller.takePicture();

      if (!mounted) return;

      _imageFromCamera = image;

      if (_imageFromCamera == null) return;

      Navigator.of(context).pop([_imageFromCamera]);
    } catch (e) {
      // If an error occurs, log the error to the console.
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          _takePhoto();
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
