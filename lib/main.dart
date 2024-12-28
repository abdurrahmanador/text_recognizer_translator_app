import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/application/application.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

 // ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  //SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(TextRecognizer());
}

