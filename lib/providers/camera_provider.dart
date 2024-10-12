import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

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

  Future<XFile?> takePicture() async {
    if (_controller != null && _controller!.value.isInitialized) {
      try {
        return await _controller!.takePicture();
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