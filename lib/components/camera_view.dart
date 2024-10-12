import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:price_pal/providers/camera_provider.dart';
import 'package:provider/provider.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  // final CameraDescription camera;

  // const CameraView({super.key, required this.camera});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late final Provider<CameraProvider>camera;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final cameraProvider = Provider.of<CameraProvider>(context);

    return cameraProvider.controller != null
        ? SizedBox(
            width: size.width,
            height: size.height,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: 100, // the actual width is not important here
                child: CameraPreview(cameraProvider.controller!),
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
