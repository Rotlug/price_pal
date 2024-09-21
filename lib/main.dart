import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        brightness: Brightness.dark,
        fontFamily: "FakeReceipt",
        useMaterial3: true,
      ),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: PriceyContainer(
                    child: Expanded(
                        child: Container(
                      color: Colors.brown,
                      // clipBehavior: Clip.antiAlias,
                    )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ), // Margin
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(minHeight: 200, maxHeight: 300),
                  child: const SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: PriceyContainer(
                      child: Center(
                        child: Text(
                          "ROTEM LUGASI & JONATHAN RASHI & YAIR GOLDSTEIN",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PriceyContainer extends StatelessWidget {
  final Widget? child;

  static const borderRadius = BorderRadius.all(Radius.circular(16));
  const PriceyContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(27, 27, 27, 1),
              borderRadius: borderRadius,
            ),
            child: child,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(
                  color: const Color.fromRGBO(255, 255, 255, 0.05),
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignInside,
                )),
          )
        ],
      ),
    );
  }
}
