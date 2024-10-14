import 'package:flutter/material.dart';
import 'package:native_camera_sound/native_camera_sound.dart';

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
      duration:
      const Duration(milliseconds: CameraButton.animationDuration ~/ 2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.bottomCenter,
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
        ),
      ),
    );
  }

  void takePicture() {
    if (widget.onPressed != null) widget.onPressed!();

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
  }
}
