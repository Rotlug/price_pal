import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = const Color(0xff282828)
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ResultArea extends StatelessWidget {
  final String productName;
  final bool analysing;
  final List<String>? history = [];

  ResultArea({super.key, required this.productName, required this.analysing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cheapest Product",
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
              ),
              analysing ? const ProcessingText() : Text(
                productName,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: const Color.fromRGBO(255, 255, 255, 0.7)),
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CustomPaint(
              painter: DashedLinePainter(),
            ),
          ),
          const SizedBox(height: 10),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.secondaryContainer,
              BlendMode.modulate,
            ),
            child: Image.asset("assets/images/intersect.png"),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class ProcessingText extends StatelessWidget {
  const ProcessingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Analysing...", style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.grey.shade800),)
        .animate(
          onPlay: (controller) => controller.loop(),
        )
        .shimmer(duration: const Duration(seconds: 2), color: Colors.white.withOpacity(0.2));
  }
}
