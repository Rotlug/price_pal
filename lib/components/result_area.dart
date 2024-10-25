import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:price_pal/components/revealer.dart';
import 'package:price_pal/providers/history_provider.dart';
import 'package:provider/provider.dart';

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

  const ResultArea(
      {super.key, required this.productName, required this.analysing});

  @override
  Widget build(BuildContext context) {
    List<Purchase> history = Provider.of<HistoryProvider>(context).history;

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
                style: Theme.of(context).textTheme.displaySmall!,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: analysing
                    ? const ProcessingText()
                    : Text(
                        productName,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                              color: const Color.fromRGBO(255, 255, 255, 0.7),
                            ),
                      ),
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
          Expanded(
            child: history.isEmpty
                ? const NoHistory()
                : Revealer(
                    revealed: history.isNotEmpty,
                    duration: 800,
                    hiddenOffset: const Offset(0, 400),
                    child: Receipt(
                      child: HistoryList(history: history),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class ProcessingText extends StatelessWidget {
  const ProcessingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Analysing...",
      style: Theme.of(context)
          .textTheme
          .displayLarge!
          .copyWith(color: Colors.grey.shade800),
    )
        .animate(
          onPlay: (controller) => controller.loop(),
        )
        .shimmer(
          duration: const Duration(seconds: 2),
          color: Colors.white.withOpacity(0.2),
        );
  }
}

class Receipt extends StatelessWidget {
  final Widget? child;

  const Receipt({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            child: child,
          ),
        ),
      ],
    );
  }
}

class HistoryList extends StatelessWidget {
  final List<Purchase> history;

  const HistoryList({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          reverse: false,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "History of Products",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              );
            }
            return PurchaseTile(purchase: history[history.length - index]);
          },
          itemCount: history.length + 1,
        ),
        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(0),
              Theme.of(context).colorScheme.secondaryContainer
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
        )
      ],
    );
  }
}

class NoHistory extends StatelessWidget {
  const NoHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset("assets/images/nohistory.png"),
        Center(
          child: Text(
            "No History",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        )
      ],
    );
  }
}

class PurchaseTile extends StatelessWidget {
  final Purchase purchase;

  const PurchaseTile({super.key, required this.purchase});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 12, right: 12),
      child: Row(
        children: [
          Text(
            purchase.item,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const AsteriskSeparator(),
          Text(
            purchase.price,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}

class AsteriskSeparator extends StatelessWidget {
  const AsteriskSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Get available width
            double totalWidth = constraints.maxWidth;

            // Calculate how many asterisks will fit
            double asteriskWidth = _getTextWidth('*', context);
            int numAsterisks = (totalWidth / asteriskWidth).floor();

            // Create a string of asterisks
            String asterisks = '*' * numAsterisks;

            // Return the calculated asterisks as a Text widget
            return Text(
              asterisks,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: const Color.fromRGBO(
                      255, 255, 255, 0.05)), // Apply the same style
            );
          },
        ),
      ),
    );
  }

  // Calculate width of text
  double _getTextWidth(String text, BuildContext context) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: text, style: Theme.of(context).textTheme.displayMedium),
      // maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }
}
