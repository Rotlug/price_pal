import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

enum DecoratedButtonStyle { normal, suggested }

class DecoratedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool suggestedAction;
  final String text;

  const DecoratedButton(
      {super.key,
      required this.text,
      this.onPressed,
      required this.suggestedAction});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 0)),
            padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
            visualDensity: VisualDensity.compact,
            backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Theme.of(context).colorScheme.onSecondaryFixed;
              } else if (!suggestedAction) {
                return Colors.transparent;
              }
              return Theme.of(context).colorScheme.primaryContainer;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (suggestedAction) {
                return Colors.white;
              }
              return null;
            }),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(text),
          ),
        ),
        const ButtonInnerShadows(),
      ],
    );
  }
}

class ButtonInnerShadows extends StatelessWidget {
  const ButtonInnerShadows({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow( // Black BoxShadow
                    inset: true,
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 2,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                  BoxShadow( // White BoxShadow
                    inset: true,
                    color: Colors.white.withOpacity(0.15),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: Colors.white.withOpacity(0.05), width: 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
