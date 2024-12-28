import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_page/controller/home_page_controller.dart';

class RecognizationPageView extends StatelessWidget {
  const RecognizationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.find<HomePageController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          "Recognized Text",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
              () => Text(
            homePageController.recognizedTextString.value.isEmpty
                ? "No text recognized"
                : homePageController.recognizedTextString.value,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
