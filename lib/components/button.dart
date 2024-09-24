import 'package:flutter/material.dart';

enum DecoratedButtonStyle { normal, suggested }

class DecoratedButtonTest extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool suggestedAction;
  final String text;

  const DecoratedButtonTest({super.key, required this.text, this.onPressed, required this.suggestedAction});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 0)),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Theme.of(context).colorScheme.onSecondaryFixed;
              }
              else if (!suggestedAction) {
                return const Color(0xff1B1B1B);
              }
              return Theme.of(context).colorScheme.primaryContainer; // Use the component's default.
            }),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(text),
        ),
    );
  }
}
