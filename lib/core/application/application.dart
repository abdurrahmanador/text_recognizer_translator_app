import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_page/view/home_page_view.dart';

class TextRecognizer extends StatelessWidget {
  const TextRecognizer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePageView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
