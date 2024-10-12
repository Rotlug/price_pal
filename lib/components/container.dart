import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class DecoratedContainer extends StatefulWidget {
  final Widget? child;
  final double radius;

  const DecoratedContainer({super.key, this.child, this.radius = 16});

  @override
  State<DecoratedContainer> createState() => _DecoratedContainerState();
}

class _DecoratedContainerState extends State<DecoratedContainer> {
  late final BorderRadius borderRadius;

  @override
  void initState() {
    super.initState();
    borderRadius = BorderRadius.circular(widget.radius);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xff1B1B1B),
              borderRadius: borderRadius,
            ),
            child: widget.child,
          ),
          ContainerInnerShadows(borderRadius: borderRadius),
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(
                  color: const Color(0xff272727).withOpacity(0.3),
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerInnerShadows extends StatelessWidget {
  final BorderRadius borderRadius;

  const ContainerInnerShadows({super.key, required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Transform.scale(
        scaleX: 1.5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                  inset: true,
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: Offset(0, 5),
                  color: Color.fromRGBO(0, 0, 0, 0.6))
            ],
          ),
        ),
      ),
    );
  }
}
