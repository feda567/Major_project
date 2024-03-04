

/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
// import 'package:google_translator/google_translator.dart';

class ImageRecognitionPage extends StatefulWidget {
  @override
  _ImageRecognitionPageState createState() => _ImageRecognitionPageState();
}

class _ImageRecognitionPageState extends State<ImageRecognitionPage> {
  File? _image;
  String _recognizedObject = '';

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      _recognizeObject();
    }
  }

  Future<void> _recognizeObject() async {
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(_image!);
    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();

    final List<ImageLabel> labels = await labeler.processImage(visionImage);

    for (ImageLabel label in labels) {
      // String translatedLabel = await GoogleTranslator.translate(label.text, from: 'en', to: 'ml');
      setState(() {
        // _recognizedObject = translatedLabel;
      });
      break; // Only translate the first label
    }

    labeler.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Recognition'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image != null
                ? Image.file(_image!)
                : const Text('No image selected'),
            const SizedBox(height: 20),
            Text('Recognized Object: $_recognizedObject'),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _getImage(ImageSource.gallery),
            tooltip: 'Pick Image',
            child: const Icon(Icons.photo_library),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () => _getImage(ImageSource.camera),
            tooltip: 'Take Picture',
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
*/