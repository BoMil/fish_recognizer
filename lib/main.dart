import 'dart:io';
import 'package:fish_recognizer/utils/fish_breeds.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:flutter/material.dart';

import 'theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Satoshi'),
      home: const MyHomePage(title: 'Fish recognizer app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  final ImagePicker _imagePicker = ImagePicker();
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
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }

    setState(() {
      _image = File(image.path);
    });
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
      fishName = _output.isNotEmpty ? '${_output[0]['label']}'.replaceAll(RegExp(r'[0-9]'), '').trim() : '';
      fishDescription = FishBreeds.getFishDescription(fishName);
    });
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
                'Chose the photo of the fish from your phone.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 30),
              if (_image != null) ...[
                Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width - 200,
                  child: Image.file(_image!),
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
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 70),
              ],
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MaterialButton(
        minWidth: 300,
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
    );
  }
}
