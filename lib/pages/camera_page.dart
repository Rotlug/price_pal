import 'dart:io';

import 'package:camera/camera.dart';
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
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return SplitPage(
      child1: Stack(
        children: [
          (image == null) ? const CameraView() : ImagePreview(image: image!),
          Column(
            children: [
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CameraButton(
                  onPressed: takePicture,
                ),
              )
            ],
          ),
        ],
      ),
      child2: const Center(
        child: Text("SplitPage Test"),
      ),
    );
  }

  void takePicture() {
    final camera = Provider.of<CameraModel>(context, listen: false);
    camera.takePicture().then(
      (value) {
        if (value != null) {
          setState(() {
            image = value;
          });
        }
      },
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
        shape: BoxShape.circle,
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const CircleBorder(),
      ),
    );
  }
}

class ImagePreview extends StatelessWidget {
  final XFile image;

  const ImagePreview({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: 100, // the actual width is not important here
          child: Image.file(
            File(image.path),
          ),
        ),
      ),
    );
  }
}
