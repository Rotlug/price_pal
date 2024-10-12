import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:native_camera_sound/native_camera_sound.dart';
import 'package:price_pal/components/split_page.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:price_pal/providers/camera_provider.dart';

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
          const AIEffectContainer()
        ],
      ),
    );
  }

  void takePicture() {
    final camera = Provider.of<CameraProvider>(context, listen: false);
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

class CameraButton extends StatefulWidget {
  final VoidCallback? onPressed;
  static const int animationDuration = 250;
  const CameraButton({super.key, this.onPressed});

  @override
  State<CameraButton> createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: scale,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: CameraButton.animationDuration ~/ 2),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.5), width: 5),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: takePicture,
          backgroundColor: Colors.white,
          elevation: 0,
          shape: const CircleBorder(),
        ),
      ),
    );
  }

  void takePicture() {
    NativeCameraSound.playShutter();

    // Scale down
    setState(() {
      scale = 0.9;
    });

    // Scale Back up
    Future.delayed(
      const Duration(milliseconds: CameraButton.animationDuration ~/ 2),
      () => setState(
        () {
          scale = 1;
        },
      ),
    );

    if (widget.onPressed != null) widget.onPressed!();
  }
}

class AIEffectContainer extends StatelessWidget {
  const AIEffectContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            inset: true,
            spreadRadius: 12,
            blurRadius: 80,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ]),
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
