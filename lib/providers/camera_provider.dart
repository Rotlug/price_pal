import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as img;

class CameraProvider extends ChangeNotifier {
  CameraController? _controller;
  List<CameraDescription>? _cameras;

  CameraProvider() {
    initializeCameras();
  }

  Future<void> initializeCameras() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras!.first,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _controller!.initialize();
      notifyListeners();
    }
  }

  CameraController? get controller => _controller;

  Future<Uint8List?> takePicture() async {
    if (_controller != null && _controller!.value.isInitialized) {
      try {
        final XFile picture = await _controller!.takePicture();
        final DeviceOrientation orientation = _controller!.value.deviceOrientation;

        // Load image into memory
        final File imageFile = File(picture.path);
        final img.Image image = img.decodeImage(await imageFile.readAsBytes())!;

        img.Image fixedImage;
        switch (orientation) {
          case DeviceOrientation.portraitUp:
            // No Rotation Needed
            fixedImage = image;
            break;
          case DeviceOrientation.portraitDown:
            fixedImage = img.copyRotate(image, angle: 180);
            break;
          case DeviceOrientation.landscapeLeft:
            fixedImage = img.copyRotate(image, angle: -90);
            break;
          case DeviceOrientation.landscapeRight:
            fixedImage = img.copyRotate(image, angle: 90);
            break;
          default:
            fixedImage = image; // No rotation if unknown orientation
        }


        return img.encodePng(fixedImage);
      } catch (e) {
        //
      }
    }
    return null;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}