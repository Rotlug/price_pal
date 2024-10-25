import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:price_pal/providers/camera_provider.dart';
import 'package:provider/provider.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final CameraController? controller =
        Provider.of<CameraProvider>(context).controller;

    return controller != null
        ? SizedBox(
            width: size.width,
            height: size.height,
            child: FittedBox(
              fit: BoxFit.cover,
              child: OrientationBuilder(builder: (context, orientation) {
                return SizedBox(
                  width: orientation == Orientation.portrait ? 1 : null,
                  height: orientation == Orientation.landscape ? 1 : null,
                  child: CameraPreview(controller),);
              }),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
