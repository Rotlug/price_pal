import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:price_pal/components/split_page.dart';

import '../components/camera_view.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({super.key, required this.camera});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  static const minHeight = 200;
  static const maxHeight = 300;
  double height = 250;

  void setHeight(double delta) {
    setState(() {
      height -= delta;
      if (height > maxHeight || height < minHeight) {
        // Revert the change if height exceeds boundaries
        height += delta;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplitPage(
      child1: Stack(
        children: [
          CameraView(camera: widget.camera),
          Column(children: [
            Expanded(child: Container()),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CameraButton(),
            )
          ],)
        ],
      ),
      child2: const Center(child: Text("SplitPage Test"),),
    );
  }
}

class CameraButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CameraButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withAlpha(255 ~/ 2), width: 5),
          shape: BoxShape.circle),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const CircleBorder(),
      ),
    );
  }
}

Axis oriToAxis(Orientation orientation) {
  return orientation == Orientation.landscape ? Axis.horizontal : Axis.vertical;
}
