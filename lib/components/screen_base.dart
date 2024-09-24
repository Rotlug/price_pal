import 'package:flutter/material.dart';

class ScreenBase extends StatelessWidget {
  final Widget child;
  const ScreenBase({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: child),
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
