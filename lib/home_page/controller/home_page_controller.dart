import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  RxString recognizedTextString = "".obs;
  RxString translatedTextString = "".obs;
  RxBool isLoading = false.obs; // Track loading state

  // Method to pick an image
  Future<void> pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image.value = File(pickedImage.path);
      await recognizeText(); // Process the image for text recognition
    }
  }

  // Method to recognize text from the image
  Future<void> recognizeText() async {
    if (image.value == null) return;

    isLoading.value = true; // Start loading
    try {
      final inputImage = InputImage.fromFile(image.value!);
      final recognizedText = await textRecognizer.processImage(inputImage);

      recognizedTextString.value = recognizedText.text;
    } catch (e) {
      print('Error recognizing text: $e');
      recognizedTextString.value = "Error processing image";
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  // Method to translate text
  Future<void> translateText(String targetLanguageCode) async {
    if (recognizedTextString.isEmpty) {
      print('Translation Error: No text to translate');
      translatedTextString.value = "No Text to Translate";
      return;
    }

    print('Starting translation process...');
    print('Text to translate: ${recognizedTextString.value}');
    print('Target language: $targetLanguageCode');

    // Using MyMemory API which is free
    final encodedText = Uri.encodeComponent(recognizedTextString.value);
    final Uri uri = Uri.parse(
        "https://api.mymemory.translated.net/get?q=$encodedText&langpair=en|$targetLanguageCode"
    );
    isLoading.value = true;

    try {
      print('Sending translation request to server...');
      print('Request URL: $uri');

      final response = await http.get(uri).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Translation request timed out');
        },
      );

      print('Response received from server');
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('Successfully parsed JSON response: $jsonResponse');

        if (jsonResponse['responseData'] != null &&
            jsonResponse['responseData']['translatedText'] != null) {
          final translatedText = jsonResponse['responseData']['translatedText'];
          print('Extracted translated text: $translatedText');
          translatedTextString.value = translatedText;
          print('Translation completed successfully');
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        print('Translation failed with status code: ${response.statusCode}');
        translatedTextString.value = "Translation service unavailable. Please try again later.";
      }
    } catch (e, stackTrace) {
      print('Translation error occurred:');
      print('Error: $e');
      print('Stack trace: $stackTrace');

      if (e.toString().contains('SocketException')) {
        translatedTextString.value = "Network error. Please check your internet connection.";
      } else if (e.toString().contains('TimeoutException')) {
        translatedTextString.value = "Translation timed out. Please try again.";
      } else {
        translatedTextString.value = "Translation error. Please try again later.";
      }
    } finally {
      print('Translation process finished');
      isLoading.value = false;
    }
  }  @override
  void onClose() {
    textRecognizer.close();
    super.onClose();
  }
}
