import 'package:flutter/material.dart';
import 'package:price_pal/components/container.dart';
import 'package:price_pal/components/screen_base.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double infoHeight = 100.0;

  void setHeight(Offset offset) {
    setState(() {
      infoHeight -= offset.dy;
      if (infoHeight < 99 || infoHeight > 400) {infoHeight += offset.dy;}
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Expanded(child: DecoratedContainer()),
            ResizeBar(
              resizeFunc: setHeight,
            ),
            SizedBox(
              height: infoHeight,
              child: const DecoratedContainer(),
            ),
          ],
        ),
      ),
    );
  }
}

class ResizeBar extends StatelessWidget {
  final Function resizeFunc;
  const ResizeBar({super.key, required this.resizeFunc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.black,
        width: double.infinity,
        height: 17,
        child: Center(
          child: Container(
            width: 100,
            height: 4,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
      ),
      onVerticalDragUpdate: (details) {
        resizeFunc(details.delta);
      },
    );
  }
}
