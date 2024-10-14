import 'package:flutter/material.dart';

class Revealer extends StatelessWidget {
  final bool revealed;
  final Offset hiddenOffset;
  final Widget? child;

  const Revealer(
      {super.key,
        required this.revealed,
        required this.hiddenOffset,
        this.child});

  @override
  Widget build(BuildContext context) {
    final destination = revealed ? const Offset(0, 0) : hiddenOffset;

    return TweenAnimationBuilder(
      tween: Tween(begin: hiddenOffset, end: destination),
      duration: const Duration(milliseconds: 450),
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