import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../recongnization_page/view/recognization_page_view.dart';
import '../controller/home_page_controller.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.put(HomePageController());

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // Top Card
                Card(
                  color: Colors.deepPurpleAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            await homePageController.translateText("bn");
                            Get.defaultDialog(
                              title: "Translated Text",
                              content: Obx(
                                    () => SingleChildScrollView(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    homePageController.translatedTextString.value.isEmpty
                                        ? "No text to translate"
                                        : homePageController.translatedTextString.value,
                                    style: const TextStyle(fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.grey.shade100,
                              titleStyle: const TextStyle(color: Colors.black),
                            );
                          },
                          child: const Icon(Icons.g_translate, size: 25, color: Colors.white),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.defaultDialog(
                              title: "Recognized Text",
                              content: Obx(
                                    () => SingleChildScrollView(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    homePageController.recognizedTextString.value.isEmpty
                                        ? "No text recognized"
                                        : homePageController.recognizedTextString.value,
                                    style: const TextStyle(fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.grey.shade100,
                              titleStyle: const TextStyle(color: Colors.black),
                            );
                          },
                          child: const Icon(Icons.document_scanner_outlined, size: 25, color: Colors.white),
                        ),
                        const Spacer(),
                        const Icon(Icons.enhance_photo_translate, size: 25, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                // Display Selected Image
                Obx(
                      () => homePageController.image.value != null
                      ? Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: Image.file(
                      homePageController.image.value!,
                      fit: BoxFit.contain,
                    ),
                  )
                      : Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurpleAccent),
                    ),
                    child: const Text(
                      "No image selected",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ),
                const Spacer(),

                // Bottom Card
                Card(
                  color: Colors.deepPurpleAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.refresh, size: 25, color: Colors.white),
                        const Spacer(),
                        const Icon(Icons.photo_camera, size: 25, color: Colors.white),
                        const Spacer(),
                        InkWell(
                          onTap: () => homePageController.pickImage(),
                          child: const Icon(Icons.album, size: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Loading Indicator
          Obx(
                () => homePageController.isLoading.value
                ? Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
