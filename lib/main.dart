import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:price_pal/pages/main_page.dart';

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
      // home: SafeArea(
      //   child: Scaffold(
      //     backgroundColor: Colors.black,
      //     body: Container(
      //       margin: const EdgeInsets.all(10),
      //       child: Column(
      //         children: [
      //           Expanded(
      //             flex: 2,
      //             child: PriceyContainer(
      //               child: Expanded(
      //                   child: Container(
      //                 color: Colors.brown,
      //                 // clipBehavior: Clip.antiAlias,
      //               )),
      //             ),
      //           ),
      //           const SizedBox(
      //             height: 10,
      //           ), // Margin
      //           ConstrainedBox(
      //             constraints:
      //                 const BoxConstraints(minHeight: 200, maxHeight: 300),
      //             child: const SizedBox(
      //               width: double.infinity,
      //               height: 200,
      //               child: PriceyContainer(
      //                 child: Center(
      //                   child: Text(
      //                     "ROTEM LUGASI & JONATHAN RASHI & YAIR GOLDSTEIN",
      //                     textAlign: TextAlign.center,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      home: MainPage(),
    );
  }
}