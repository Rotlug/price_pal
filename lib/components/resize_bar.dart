import 'package:flutter/material.dart';

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