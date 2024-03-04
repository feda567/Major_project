import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class UplaodingPage extends StatefulWidget {
  const UplaodingPage({Key? key}) : super(key: key);

  @override
  State<UplaodingPage> createState() => _UplaodingPageState();
}

class _UplaodingPageState extends State<UplaodingPage> {
  String recognizedTextOut = '';
  File? imageFile;
  TextRecognizer _textDetector = GoogleMlKit.vision.textRecognizer();

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      // Perform text recognition when the image is selected
      await _recognizeText();
    }
  }

  Future<void> _recognizeText() async {
    if (imageFile == null) return;

    final inputImage = InputImage.fromFile(imageFile!);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final text = await textRecognizer.processImage(inputImage);

    String recognizedText = '';

    for (TextBlock block in text.blocks) {
      for (TextLine line in block.lines) {
        // Check if the line contains Malayalam characters
        if (line.text.contains(RegExp(r'[ം-ൿ]'))) {
          recognizedText += line.text + '\n';
        }
        // recognizedText += line.text + '\n';
      }
    }

    // Handle the recognized text here, you can update the UI with the text
    print("Recognized Text: $recognizedText");
    setState(() {
      recognizedTextOut = recognizedText;
    });

    // Clean up resources
    textRecognizer.close();
  }

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
        children: [
          Container(
            width: 358,
            height: 252,
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
            decoration: ShapeDecoration(
              color: const Color(0xB2FAFAFA),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0,
                  color: Color(0xFF9E9E9E),
                ),
                borderRadius: BorderRadius.circular(8.66),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _getImage,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 16),
                    decoration: ShapeDecoration(
                      color: const Color(0x191A524E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Icon(Icons.upload,
                        color: Color.fromARGB(255, 151, 150, 150)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 52,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Text(
                          'Click here',
                          style: TextStyle(
                            color: Color(0xFF136DC7),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 0.12,
                          ),
                        ),
                        Text(
                          ' to upload the അക്ഷരം',
                          style: TextStyle(
                            color: Color(0xFF1A524E),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 0.12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 344,
            height: 231,
            margin: const EdgeInsets.only(top: 50),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Stack(
              children: [
                if (imageFile == null)
                  Image.asset('assets/scanning_page/ee1.png')
                else
                  Image.file(imageFile!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          imageFile = null;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: const ShapeDecoration(
                            color: Colors.red, shape: CircleBorder()),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 100,
            child: Text(
              'Recognized Text:\n$recognizedTextOut',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              // softWrap:
              //     true,
              // overflow: TextOverflow.clip,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textDetector.close();
    super.dispose();
  }
}
