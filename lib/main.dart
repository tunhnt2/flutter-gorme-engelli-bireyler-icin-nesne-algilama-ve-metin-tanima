import 'dart:async';
import 'package:bitirme2/home.dart';
import 'package:bitirme2/test.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

// kullanılabilir bir kamera var mı? 
late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Hata: $e.message');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Nesne Algılama Uygulaması',
      debugShowCheckedModeBanner: false,
      home: HomePage(cameras),
      // home: TestView(),
    );
  }
}