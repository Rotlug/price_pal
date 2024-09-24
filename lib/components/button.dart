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
          elevation: const WidgetStatePropertyAll(0),
          minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 0)),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Theme.of(context).colorScheme.onSecondaryFixed;
              }
              else if (!suggestedAction) {
                return Colors.transparent;
              }
              return Theme.of(context).colorScheme.primaryContainer;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (suggestedAction) {
                  return Theme.of(context).colorScheme.onPrimary;
                }
                return null;
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
