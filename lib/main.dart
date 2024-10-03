import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:price_pal/pages/landing_page.dart';
import 'package:price_pal/pages/no_permissions_page.dart';
import 'package:provider/provider.dart';

const backgroundColor = Color(0xff111111);

const TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 28,
    // fontFamily: "FakeReceipt",
  ),
  displayMedium: TextStyle(
    fontSize: 14,
    color: Color.fromRGBO(255, 255, 255, 0.5),
  ),
  titleSmall: TextStyle(
    color: Color.fromRGBO(255, 255, 255, 0.5),
    fontSize: 14,
    fontFamily: "Inter"
  )
);

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
          textTheme: textTheme,
          fontFamily: "FakeReceipt",
          useMaterial3: true,
          scaffoldBackgroundColor: backgroundColor,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff5E48FE),
              brightness: Brightness.dark,
              dynamicSchemeVariant: DynamicSchemeVariant.fidelity)),
      home: const NoPermissionsPage(),
    );
  }
}

class CameraModel extends ChangeNotifier {
  late final CameraDescription camera;
  CameraModel({required this.camera});
}
