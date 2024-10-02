import 'package:flutter/material.dart';
import 'package:price_pal/components/container.dart';
import 'package:price_pal/components/resize_bar.dart';
import 'package:price_pal/components/screen_base.dart';

class SplitPage extends StatefulWidget {
  final Widget? child1;
  final Widget? child2;

  const SplitPage({super.key, this.child1, this.child2});

  static const minHeight = 200;
  static const maxHeight = 300;

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  double height = 250;

  void setHeight(double delta) {
    setState(() {
      height -= delta;
      if (height > SplitPage.maxHeight || height < SplitPage.minHeight) {
        // Revert the change if height exceeds boundaries
        height += delta;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBase(child: MarginContainer(
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
              DecoratedContainer(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: orientation == Orientation.portrait
                        ? height
                        : double.infinity,
                    minWidth: orientation == Orientation.landscape
                        ? height
                        : double.infinity,
                  ),
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
