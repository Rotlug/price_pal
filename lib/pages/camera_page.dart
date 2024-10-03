import 'package:flutter/material.dart';
import 'package:price_pal/components/split_page.dart';
import 'package:price_pal/main.dart';

import '../components/camera_view.dart';
import 'package:provider/provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
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
          Consumer<CameraModel>(builder: (BuildContext context, CameraModel value, Widget? child) {
            return CameraView(camera: value.camera);
          }),
          Column(children: [
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CameraButton(
                onPressed: () {},
              ),
            )
          ],),
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
          border: Border.all(color: Colors.white.withOpacity(0.5), width: 5),
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