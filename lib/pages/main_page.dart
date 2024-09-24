import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:price_pal/components/container.dart';
import 'package:price_pal/components/screen_base.dart';

class MainPage extends StatefulWidget {
  final CameraDescription camera;
  const MainPage({super.key, required this.camera});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double infoHeight = 250.0;

  void setHeight(double distance) {
    setState(() {
      infoHeight -= distance;
      if (infoHeight < 249 || infoHeight > 400) {
        infoHeight += distance;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      child: MarginContainer(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Flex(
              direction: orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal,
            children: [
              Expanded(child: DecoratedContainer(
                child: CameraView(camera: widget.camera))),
              ResizeBar(
                resizeFunc: setHeight,
                vertical: orientation == Orientation.portrait,
              ),
              SizedBox(
                height: orientation == Orientation.portrait ? infoHeight : null,
                width: orientation == Orientation.landscape ? infoHeight : null,
                child: const DecoratedContainer(),
              ),
            ],
          );}
        ),
      ),
    );
  }
}

class ResizeBar extends StatelessWidget {
  final Function resizeFunc;
  final bool vertical;
  const ResizeBar(
      {super.key, required this.resizeFunc, required this.vertical});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.black,
        width: vertical ? double.infinity : 17,
        height: vertical ? 17 : double.infinity,
        child: Center(
          child: Container(
            width: vertical ? 100 : 4,
            height: vertical ? 4 : 100,
            decoration: const BoxDecoration(
                color: Color(0xff272727),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
      ),
      onVerticalDragUpdate: (details) {
        if (vertical) {resizeFunc(details.delta.dy);}
      },
      onHorizontalDragUpdate: (details) {
        if (!vertical) {resizeFunc(details.delta.dx);}
      },
    );
  }
}

class CameraView extends StatefulWidget {
  final CameraDescription camera;
  const CameraView({super.key, required this.camera});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();

    // to prevent scaling down, invert the value

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * _controller.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;

    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation

    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return Transform.scale(
              scale: scale,
              child: CameraPreview(_controller));
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    )
    ;
  }
}
