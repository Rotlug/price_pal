import 'package:flutter/material.dart';

class ResizeBar extends StatelessWidget {
  final Function(double) resizeFunc;
  final bool vertical;

  /// Displays a bar that detects resizing gestures from the user and
  /// triggers a given function with a parameter (`double`) that represents the distance scrolled.
  const ResizeBar({
    super.key,
    required this.resizeFunc,
    required this.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: vertical ? double.infinity : 17,
        height: vertical ? 17 : double.infinity,
        child: Center(
          child: Container(
            width: vertical ? 100 : 4,
            height: vertical ? 4 : 100,
            decoration: const BoxDecoration(
                color: Color(0xff282828),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
      ),
      onVerticalDragUpdate: (details) {
        if (vertical) {
          resizeFunc(details.delta.dy);
        }
      },
      onHorizontalDragUpdate: (details) {
        if (!vertical) {
          resizeFunc(details.delta.dx);
        }
      },
    );
  }
}
