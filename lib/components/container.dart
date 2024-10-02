
import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  final Widget? child;

  static const borderRadius = BorderRadius.all(Radius.circular(16));
  const DecoratedContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xff1B1B1B),
              borderRadius: borderRadius,
            ),
            child: child,
          ),
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  border: Border.all(
                    color: const Color.fromRGBO(255, 255, 255, 0.02),
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignInside,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
