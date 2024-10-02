import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:price_pal/pages/landing_page.dart';
import 'package:provider/provider.dart';

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

  runApp(ChangeNotifierProvider(
    create: (context) => CameraModel(camera: firstCamera),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
      home: const LandingPage(),
    );
  }
}

class CameraModel extends ChangeNotifier {
  late final CameraDescription camera;
  CameraModel({required this.camera});
}
