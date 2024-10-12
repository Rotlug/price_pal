import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:price_pal/pages/landing_page.dart';
import 'package:price_pal/providers/camera_provider.dart';
import 'package:price_pal/providers/storage_provider.dart';
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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CameraProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => StorageProvider(),
        )
      ],
      child: const MainApp(),
    ),
  );
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
