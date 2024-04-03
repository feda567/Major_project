// import 'dart:html';
import 'dart:io';
import 'package:brainburst/models/image_process.dart';
import 'package:brainburst/screens/scanning_pages/scanning_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/flutter_camera.dart';
import 'package:translator/translator.dart';


class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 852,
      width: 393,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.39, 0.92),
          end: Alignment(-0.39, -0.92),
          colors: [Color(0xFFF7D5E5), Color(0x00FA99C8)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ScanningPageLogo(),
          Padding(
            padding: const EdgeInsets.only(bottom: 400),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CameraPreview()));
              },
              child: const Text('Click here to take a picture'),
            ),
          ),
        ],
      ),
    );
  }
}



class CameraPreview extends StatefulWidget {
  const CameraPreview({Key? key}) : super(key: key);

  @override
  State<CameraPreview> createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<CameraPreview> {
  String objectName = '';
  String objectNameInMalayalam = '';

  Future<String> translateToMalayalam() async {
    final translator = GoogleTranslator();

    try {
      Translation translation = await translator.translate(objectName, from: 'en', to: 'ml');
        objectNameInMalayalam = translation.text;
    } catch (error) {
      print("Translation Error: $error");
        objectNameInMalayalam = "Translation Error";
    }
    return objectNameInMalayalam;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterCamera(
        color: Colors.amber,
        onImageCaptured: (value) async {
          final path = value.path;
          print("::::::::::::::::::::::::::::::::: $path");
          if (path.contains('.jpg')) {
            showDialog(
              context: context,
              builder: (context) {
                return FutureBuilder<String?>(
                  future: ImageProcess().imageProcess(path),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(body: Center(
                        
                        child: SizedBox(height: 80,width: 80, child: CircularProgressIndicator(),)),);
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final result = snapshot.data ?? '';
                      objectName = result;
                      translateToMalayalam();
                      return AlertDialog(
                        content: Column(
                          children: [
                            Image.file(File(path)),
                            Text("In English: $result"),
                            FutureBuilder<String>(
                              future: translateToMalayalam(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Text("Translating...");
                                } else if (snapshot.hasError) {
                                  return Text('Translation Error: ${snapshot.error}');
                                } else {
                                  return Text("In Malayalam: ${snapshot.data ?? ''}");
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}




