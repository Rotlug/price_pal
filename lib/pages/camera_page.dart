import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:price_pal/backend/openai.dart';
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
  Uint8List? imageBytes;
  bool canTakePicture = true;
  bool displayChoiceButtons = false;
  bool displayAIEffect = false;
  String cheapestProduct = "************";

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
              onPressed: takePicture
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
        productName: cheapestProduct,
        analysing: displayAIEffect,
      ),
    );
  }

  Future<void> takePicture() async {
    if (!canTakePicture) return;

    final camera = Provider.of<CameraProvider>(context, listen: false);
    Uint8List? pic = await camera.takePicture();
    if (pic == null) return;

    setState(() {
      canTakePicture = false;
      image = Image.memory(pic);
      imageBytes = pic;
      displayChoiceButtons = true;
    });
  }

  void onPictureCanceled() {
    setState(() {
      image = null;
      canTakePicture = true;
      displayAIEffect = false;
      displayChoiceButtons = false;
    });
  }

  Future<void> takePictureTest() async {
    setState(() {
      displayAIEffect = true;
      displayChoiceButtons = false;
    });

    await Future.delayed(const Duration(seconds: 1));

    Purchase testPurchase = Purchase("Splog", "\$15");

    setState(() {
      cheapestProduct = testPurchase.item;
      historyProvider.addToHistory(testPurchase);
      onPictureCanceled();
    });
  }

  void onPictureAccepted() async {
    if (imageBytes == null) return;

    setState(() {
      displayAIEffect = true;
      displayChoiceButtons = false;
    });

    String response = await sendToChatGPT(context, imageBytes!) ?? "No Product Found";

    response = response.toLowerCase();

    onPictureCanceled();
    Purchase? purchase;

    try {
      String productName = response.split("product:")[1].split("price")[0];
      String price = response.split("price:")[1];
      purchase = Purchase(productName.trim(), price.trim());
    } catch (e) {
      setState(() {
        cheapestProduct = "No Product Found";
      });
      return;
    }

    setState(() {
      displayAIEffect = false;
      cheapestProduct = purchase!.item;
      historyProvider.addToHistory(purchase);
      onPictureCanceled();
    });
  }
}

Future<Uint8List> assetToBytes(String assetPath) async {
  ByteData data = await rootBundle.load(assetPath);
  return data.buffer.asUint8List();
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
            color: const Color(0xffDFDAFF),
            angle: 70,
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
            heroTag: "deleteBtn",
            onPressed: onCancel,
            backgroundColor: const Color(0xffFF4747),
            shape: const CircleBorder(),
            child: const Icon(Icons.delete_outline),
          ),
          const SizedBox(
            width: 100,
          ),
          FloatingActionButton(
            heroTag: "acceptBtn",
            onPressed: onAccept,
            shape: const CircleBorder(),
            child: const Icon(Icons.check),
          )
        ],
      ),
    );
  }
}
