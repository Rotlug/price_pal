import 'package:flutter/material.dart';

class ScreenBase extends StatelessWidget {
  final Widget? child;
  const ScreenBase({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: child,
      ),
    );
  }

}