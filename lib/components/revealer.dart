import 'package:flutter/material.dart';

class Revealer extends StatelessWidget {
  final bool revealed;
  final Offset hiddenOffset;
  final Widget? child;
  final int duration;

  const Revealer(
      {super.key,
      required this.revealed,
      required this.hiddenOffset,
      this.duration = 450,
      this.child});

  @override
  Widget build(BuildContext context) {
    final destination = revealed ? const Offset(0, 0) : hiddenOffset;

    return TweenAnimationBuilder(
      tween: Tween(begin: hiddenOffset, end: destination),
      duration: Duration(milliseconds: duration),
      curve: Curves.easeOutQuart,
      builder: (context, value, c) {
        return IgnorePointer(
          ignoring: !revealed,
          child: Transform.translate(
            offset: value,
            child: child,
          ),
        );
      },
    );
  }
}
