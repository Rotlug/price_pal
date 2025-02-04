import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:price_pal/pages/camera_page.dart';
import 'package:price_pal/pages/landing_page.dart';
import 'package:price_pal/pages/splash_page.dart';
import 'package:price_pal/providers/camera_provider.dart';
import 'package:price_pal/providers/history_provider.dart';
import 'package:price_pal/providers/storage_provider.dart';
import 'package:provider/provider.dart';

const backgroundColor = Color(0xff111111);

// Unspecified fontFamily = FakeReceipt
const TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 24,
  ),
  displayMedium: TextStyle(
    fontSize: 14,
    color: Color(0xff4B4B4B),
  ),
  displaySmall: TextStyle(
    fontSize: 14,
    color: Color(0xff777777),
  ),
  titleSmall: TextStyle(
    color: Color(0xff777777),
    fontSize: 14,
    fontFamily: "Inter",
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: backgroundColor,
      statusBarColor: Colors.transparent);

  SystemChrome.setSystemUIOverlayStyle(
    mySystemTheme,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CameraProvider()),
        ChangeNotifierProvider(create: (context) => StorageProvider()),
        ChangeNotifierProvider(create: (context) => HistoryProvider())
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<StorageProvider>(context)
          .storage
          .read(key: "apiKey")
          .then(
        (value) {
          return SplashPage(
            destination:
                value == null ? const LandingPage() : const CameraPage(),
          );
        },
      ),
      initialData: const SizedBox(),
      builder: (context, snapshot) {
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
                    dynamicSchemeVariant: DynamicSchemeVariant.fidelity)
                .copyWith(
              surfaceContainer: const Color(0xff1B1B1B),
              secondaryContainer: const Color(0xff282828),
            ),
          ),
          home: snapshot.data,
        );
      },
    );
  }
}
