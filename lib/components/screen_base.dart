import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenBase extends StatefulWidget {
  final Widget child;
  final List<DeviceOrientation>? allowedOrientations;

  const ScreenBase({super.key, required this.child, this.allowedOrientations});

  @override
  State<ScreenBase> createState() => _ScreenBaseState();
}

class _ScreenBaseState extends State<ScreenBase> {
  @override
  void initState() {
    super.initState();
    if (widget.allowedOrientations != null) {
      SystemChrome.setPreferredOrientations(widget.allowedOrientations!);
    }
    else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: widget.child),
    );
  }
}

class MarginContainer extends StatelessWidget {
  final Widget? child;
  const MarginContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}
