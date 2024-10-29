import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:price_pal/components/container.dart';
import 'package:price_pal/components/resize_bar.dart';
import 'package:price_pal/components/screen_base.dart';

class SplitPage extends StatefulWidget {
  final Widget? child1;
  final Widget? child2;
  final List<DeviceOrientation>? allowedOrientations;

  final int minHeight;
  final int maxHeight;

  /// A Page with two containers, `child1` and `child2`, and a `ResizeBar`
  /// to change the size of `child2`.
  const SplitPage({
    super.key,
    this.child1,
    this.child2,
    this.allowedOrientations,
    this.minHeight = 200,
    this.maxHeight = 300,
  });

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  late double height;

  @override
  void initState() {
    super.initState();
    height = (widget.minHeight + widget.maxHeight) / 2; // Start in the middle
  }

  void setHeight(double delta) {
    setState(
      () {
        height -= delta;
        if (height > widget.maxHeight || height < widget.minHeight) {
          // Revert the change if height exceeds boundaries
          height += delta;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
        allowedOrientations: widget.allowedOrientations,
        child: MarginContainer(
          child: OrientationBuilder(
            builder: (context, orientation) {
              return Flex(
                direction: oriToAxis(orientation),
                children: [
                  Expanded(
                    child: DecoratedContainer(
                      child: widget.child1,
                    ),
                  ),
                  ResizeBar(
                      resizeFunc: setHeight,
                      vertical: orientation == Orientation.portrait),
                  SizedBox(
                    height: orientation == Orientation.portrait
                        ? height
                        : double.infinity,
                    width: orientation == Orientation.landscape
                        ? height
                        : double.infinity,
                    child: DecoratedContainer(
                      child: widget.child2,
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}

Axis oriToAxis(Orientation orientation) {
  return orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal;
}
