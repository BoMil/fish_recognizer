import 'dart:io';
import 'package:fish_recognizer/utils/fish_breeds.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'camera_view/camera_view.dart';
import 'theme/app_colors.dart';

void main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  CameraDescription? firstCamera;
  try {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();
    // Get a specific camera from the list of available cameras.
    firstCamera = cameras.first;
  } catch (e) {
    debugPrint('error');
  }

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription? camera;
  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Satoshi'),
      home: MyHomePage(title: 'Fish recognizer', camera: camera),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CameraDescription? camera;

  const MyHomePage({super.key, required this.title, required this.camera});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _uploadedImage;
  final ImagePicker _uploadedImagePicker = ImagePicker();
  List _output = [];
  String fishName = '';
  String fishDescription = '';

  @override
  initState() {
    super.initState();
    _loadModel();
  }

  _loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  _pickImage() async {
    var image = await _uploadedImagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }
    _uploadedImage = File(image.path);
    _classsifyImage(image);
  }

  _classsifyImage(XFile image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _output = output ?? [];
      double confidence = _output[0]['confidence'] ?? 0;
      // print('Confidence: ${confidence}');
      if (confidence < 0.7) {
        fishName = 'Sorry we can\'t recognize the fish.';
        fishDescription = '';
      } else {
        fishName = _output.isNotEmpty ? '${_output[0]['label']}'.replaceAll(RegExp(r'[0-9]'), '').trim() : '';
        fishDescription = FishBreeds.getFishDescription(fishName);
      }
    });
  }

  _goToCameraView() async {
    await Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => CameraView(
              camera: widget.camera,
            ),
          ),
        )
        .then(
          (value) => {
            if (value.isNotEmpty)
              {
                // Photo taken from the CameraView
                _uploadedImage = File(value[0].path),
                _classsifyImage(value[0]),
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30),
              Text(
                'Chose the photo of the fish from your phone or take a photo with the camera.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 30),
              if (_uploadedImage != null) ...[
                SizedBox(
                  height: 500,
                  width: MediaQuery.of(context).size.width - 200,
                  child: Image.file(_uploadedImage!),
                )
              ] else ...[
                const Center(
                  child: Icon(
                    Icons.insert_photo_rounded,
                    color: AppColors.baseGray,
                    size: 300,
                  ),
                )
              ],
              if (_output.isNotEmpty) ...[
                Text(
                  fishName,
                  style: TextStyle(color: AppColors.textGray, fontSize: 26),
                ),
                const SizedBox(height: 20),
                Text(
                  fishDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textGray, fontSize: 18),
                ),
                const SizedBox(height: 160),
              ],
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MaterialButton(
            minWidth: (MediaQuery.of(context).size.width * 0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: const EdgeInsets.all(15),
            color: Colors.blue.shade600,
            onPressed: () => _goToCameraView(),
            child: const Text(
              'Take a photo',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          MaterialButton(
            minWidth: (MediaQuery.of(context).size.width * 0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: const EdgeInsets.all(15),
            color: Colors.blue.shade600,
            onPressed: () => _pickImage(),
            child: const Text(
              'Upload the photo',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
