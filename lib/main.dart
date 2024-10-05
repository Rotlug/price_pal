import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:price_pal/pages/landing_page.dart';
import 'package:provider/provider.dart';

const backgroundColor = Color(0xff111111);

// Unspecified fontFamily = FakeReceipt
const TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 28,
  ),
  displayMedium: TextStyle(
    fontSize: 14,
    color: Color.fromRGBO(255, 255, 255, 0.5),
  ),
  titleSmall: TextStyle(
    color: Color.fromRGBO(255, 255, 255, 0.5),
    fontSize: 14,
    fontFamily: "Inter",
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: backgroundColor,
      statusBarColor: Colors.transparent);

  SystemChrome.setSystemUIOverlayStyle(
    mySystemTheme,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => CameraModel(),
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
          textTheme: textTheme,
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
  CameraController? _controller;
  List<CameraDescription>? _cameras;

  CameraModel() {
    initializeCameras();
  }

  Future<void> initializeCameras() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras!.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _controller!.initialize();
      notifyListeners();
    }
  }

  CameraController? get controller => _controller;

  Future<XFile?> takePicture() async {
    if (_controller != null && _controller!.value.isInitialized) {
      try {
        return await _controller!.takePicture();
      } catch (e) {
        //
      }
    }
    return null;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}