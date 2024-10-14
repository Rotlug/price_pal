import 'package:flutter/material.dart';


class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    var x = -18.0;
    var numberOfWaves = 20;
    var increment = size.width / numberOfWaves;
    bool startFromTop = false;

    while (x < size.width) {
      if (startFromTop) {
        path.lineTo(x, 0);
        path.cubicTo(x + increment / 2, 0, x + increment / 2, size.height,
            x + increment, size.height);
      } else {
        path.lineTo(x, size.height);
        path.cubicTo(x + increment / 2, size.height, x + increment / 2, 0,
            x + increment, 0);
      }
      x += increment;
      startFromTop = !startFromTop;
    }

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

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

  const ResultArea({super.key, required this.productName});

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
                    .titleSmall!
                    .copyWith(fontFamily: "FakeReceipt"),
              ),
              Text(
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
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 0),
                color: const Color(0xff282828),
                child: const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Center(child: Text("Hell",)),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -0.1), // Fixes some visual bug
                child: ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: 15,
                    color: const Color(0xff1B1B1B),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
