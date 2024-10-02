import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:price_pal/pages/landing_page.dart';

const backgroundColor = Color(0xff111111);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: backgroundColor,
      statusBarColor: Colors.transparent);

  SystemChrome.setSystemUIOverlayStyle(
    mySystemTheme,
  );

  runApp(MainApp(
    camera: firstCamera,
  ));
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
          scaffoldBackgroundColor: backgroundColor,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff5E48FE),
              brightness: Brightness.dark,
              dynamicSchemeVariant: DynamicSchemeVariant.fidelity)),
      home: LandingPage(
        camera: camera,
      ),
    );
  }
}
