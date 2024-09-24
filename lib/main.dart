import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:price_pal/pages/landing_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(const MainApp());
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade700, brightness: Brightness.dark, dynamicSchemeVariant: DynamicSchemeVariant.fidelity)
      ),
      home: const LandingPage(),
    );
  }
}