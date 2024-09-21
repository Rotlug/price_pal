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

  void setHeight(double distance) {
    setState(() {
      infoHeight -= distance;
      if (infoHeight < 99 || infoHeight > 400) {
        infoHeight += distance;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Expanded(child: DecoratedContainer(
              child: Center(child: Text("The Camera is Here :)", style: TextStyle(fontSize: 24), textAlign: TextAlign.center,)),
            )),
            ResizeBar(
              resizeFunc: setHeight,
              vertical: true,
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
  final bool vertical;
  const ResizeBar(
      {super.key, required this.resizeFunc, required this.vertical});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.black,
        width: vertical ? double.infinity : 17,
        height: vertical ? 17 : double.infinity,
        child: Center(
          child: Container(
            width: vertical ? 100 : 4,
            height: vertical ? 4 : 100,
            decoration: const BoxDecoration(
                color: Color(0xff272727),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
      ),
      onVerticalDragUpdate: (details) {
        if (vertical) {resizeFunc(details.delta.dy);}
      },
      onHorizontalDragUpdate: (details) {
        if (!vertical) {resizeFunc(details.delta.dx);}
      },
    );
  }
}
