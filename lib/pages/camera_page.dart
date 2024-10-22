import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:price_pal/components/camera_button.dart';
import 'package:price_pal/components/result_area.dart';
import 'package:price_pal/components/revealer.dart';
import 'package:price_pal/components/split_page.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:price_pal/providers/camera_provider.dart';
import 'package:price_pal/providers/history_provider.dart';

import '../components/camera_view.dart';
import 'package:provider/provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  Image? image;
  bool canTakePicture = true;
  bool displayChoiceButtons = false;
  bool displayAIEffect = false;
  late HistoryProvider historyProvider;

  @override
  Widget build(BuildContext context) {
    historyProvider = Provider.of<HistoryProvider>(context);

    return SplitPage(
      // allowedOrientations: const [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft],
      child1: Stack(
        children: [
          (image == null) ? const CameraView() : ImagePreview(image: image!),
          Revealer(
            revealed: canTakePicture,
            hiddenOffset: const Offset(0, 108),
            child: CameraButton(
              onPressed: takePicture,
            ),
          ),
          Revealer(
            revealed: displayChoiceButtons,
            hiddenOffset: const Offset(0, 108),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ChoiceButtons(
                onCancel: onPictureCanceled,
                onAccept: onPictureAccepted,
              ),
            ),
          ),
          AIEffectContainer(
            visible: displayAIEffect,
          )
        ],
      ),
      child2: ResultArea(
        productName: "************",
        analysing: image != null,
      ),
    );
  }

  void takePicture() {
    if (!canTakePicture) return;

    final camera = Provider.of<CameraProvider>(context, listen: false);
    camera.takePicture().then(
      (value) {
        if (value != null) {
          setState(
            () {
              image = value;
              canTakePicture = false;
              displayChoiceButtons = true;

              historyProvider.addToHistory(Purchase("hello", "3.50"));
            },
          );
        }
      },
    );
  }

  void onPictureCanceled() {
    setState(() {
      image = null;
      canTakePicture = true;
      displayChoiceButtons = false;
    });
  }

  void onPictureAccepted() {
    setState(
      () {
        displayChoiceButtons = false;
        displayAIEffect = true;

        Future.delayed(
          const Duration(seconds: 5),
          () {
            setState(
              () {
                displayAIEffect = false;
              },
            );
          },
        );
      },
    );
  }
}

class AIEffectContainer extends StatelessWidget {
  final bool visible;

  const AIEffectContainer({super.key, this.visible = true});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedContainer(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              inset: true,
              spreadRadius: visible ? 12 : 0,
              blurRadius: visible ? 80 : 50,
              color: visible
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Colors.transparent,
            ),
          ],
        ),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeIn,
      )
          .animate(
            autoPlay: true,
            onPlay: (controller) => controller.repeat(reverse: false),
          )
          .shimmer(
            color: Colors.deepPurple,
            duration: const Duration(seconds: 3),
          ),
    );
  }
}

class ImagePreview extends StatelessWidget {
  final Image image;

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
          child: image,
        ),
      ),
    );
  }
}

class ChoiceButtons extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onAccept;

  const ChoiceButtons({super.key, this.onAccept, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: onCancel,
            backgroundColor: const Color(0xffFF4747),
            shape: const CircleBorder(),
            child: const Icon(Icons.delete_outline),
          ),
          const SizedBox(
            width: 100,
          ),
          FloatingActionButton(
            onPressed: onAccept,
            shape: const CircleBorder(),
            child: const Icon(Icons.check),
          )
        ],
      ),
    );
  }
}
