import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class CameraButton extends StatefulWidget {
  final VoidCallback? onPressed;
  static const int animationDuration = 250;

  /// `CameraButton` is a styled `FloatingActionButton` that acts as a CameraButton,
  /// aligning itself to the bottom of the available space.
  /// Pressing the button also plays a custom shutter sound.
  const CameraButton({super.key, this.onPressed});

  @override
  State<CameraButton> createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  double scale = 1;
  late final AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

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
              border:
                  Border.all(color: Colors.white.withOpacity(0.5), width: 5),
              shape: BoxShape.circle,
            ),
            child: FloatingActionButton(
              heroTag: "cameraBtn",
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
    player.play(AssetSource("sounds/camera.mp3"), volume: 1);

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
