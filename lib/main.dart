import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:price_pal/pages/landing_page.dart';
import 'package:price_pal/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MainApp(camera: firstCamera,));
}

class MainApp extends StatelessWidget {
  final CameraDescription camera;
  const MainApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "FakeReceipt",
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff5E48FE), brightness: Brightness.dark, dynamicSchemeVariant: DynamicSchemeVariant.fidelity)
      ),
      home: MainPage(camera: camera,),
    );
  }
}