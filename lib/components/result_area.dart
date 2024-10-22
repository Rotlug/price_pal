import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
              analysing
                  ? const ProcessingText()
                  : Text(productName,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: const Color.fromRGBO(255, 255, 255, 0.7)))
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
          history.isNotEmpty
              ? Receipt(
                  child: HistoryList(history: history),
                )
              : const NoHistory(),
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
            color: Colors.white.withOpacity(0.2));
  }
}

class Receipt extends StatelessWidget {
  final Widget? child;

  const Receipt({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
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
      ),
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
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "History of Products",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              );
            }
            return PurchaseTile(purchase: history[history.length - index]);
          },
          itemCount: history.length,
        ),
        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.secondaryContainer.withOpacity(0),
                Theme.of(context).colorScheme.secondaryContainer
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
            ),
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
    return Expanded(
      child: Stack(
        children: [
          Center(child: Image.asset("assets/images/nohistory.png")),
          Center(
            child: Text(
              "No History",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          )
        ],
      ),
    );
  }
}

class PurchaseTile extends StatelessWidget {
  final Purchase purchase;

  const PurchaseTile({super.key, required this.purchase});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Text(
            purchase.item,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const Spacer(),
          Text(
            purchase.price,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}
