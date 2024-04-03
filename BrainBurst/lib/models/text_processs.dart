import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

class TextProcess {
  Future<String?> textProcess(String path) async {
    // final apiKey = Platform.environment['AIzaSyCWMrbbfq_WL3iWaB-74ak-LlhYYU1e7e8'];
    const apiKey = 'AIzaSyCWMrbbfq_WL3iWaB-74ak-LlhYYU1e7e8';

    // print('API_KEY: $apiKey');
    if (apiKey == null) {
      print('No \$API_KEY environment variable');
      exit(1);
    }

    final model = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);

    try {
      final imageBytes = await File(path).readAsBytes();

      final prompt = TextPart(
          "Check weather the given text contains any malayalam letter or not if it contains only one malayalam letter first display the message true and then display only the letter in malayalam not in hindi and if it doesnt contain any malayalam letter diplay no letters is discoverd and if it contains more than onle letter display message that it contains more than one letter   ");
      final imagePart = DataPart('image/jpeg', imageBytes);

      final response = await model.generateContent([
        Content.multi([prompt, imagePart])
      ]);

      if (response != null && response.text != null) {
        print(response.text);
        return response.text;
      } else {
        print('No text response received.');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
