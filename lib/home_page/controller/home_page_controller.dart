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
      translatedTextString.value = "No Text to Translate";
      return;
    }

    final Uri uri = Uri.parse("https://libretranslate.de/translate");
    isLoading.value = true; // Start loading
    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'q': recognizedTextString.value,
            "source":"auto",
            "format": "text",

            'target': targetLanguageCode,
          },
        ),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final translatedText=jsonResponse['data']['translation']['translatedText'];
        translatedTextString.value = translatedText;
      } else {
        translatedTextString.value = "Translation failed: ${response.body}";
      }
    } catch (e) {
      translatedTextString.value = "Error during translation: $e";
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  @override
  void onClose() {
    textRecognizer.close();
    super.onClose();
  }
}
