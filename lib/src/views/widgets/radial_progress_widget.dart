// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Particle {
  double orbit;
  late double originalOrbit;
  late double theta;
  late double opacity;
  late Color color;
  Particle(this.orbit) {
    originalOrbit = orbit;
    theta = getRandomRange(0.0, 360.0) * pi / 180;
    opacity = getRandomRange(0.3, 1.0);
    color = Colors.white;
  }

  void update() {
    orbit += 0.1;
    opacity -= 0.0025;
    if (opacity <= 0) {
      orbit = originalOrbit;
      opacity = getRandomRange(0.1, 1.0);
    }
  }
}

final random = Random();
double getRandomRange(double min, double max) {
  return random.nextDouble() * (max - min) + min;
}

Offset polarToCartesian(double r, double theta) {
  final dx = r * cos(theta);
  final dy = r * sin(theta);

  return Offset(dx, dy);
}

const double radialProgress = 100.0;
const double thickness = 10.0;

class RadialProgressWidget extends StatefulWidget {
  final double percentage;
  const RadialProgressWidget(this.percentage, {super.key});

  @override
  State<RadialProgressWidget> createState() => _RadialProgressWidgetState();
}

class _RadialProgressWidgetState extends State<RadialProgressWidget> {
  var value = 0.0;
  var speed = 0.5;
  late Timer timer;

  final List<Particle> particles = List<Particle>.generate(
      200, (index) => Particle(radialProgress + thickness / 2));

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
      var v = value;
      if (v <= widget.percentage) {
        v += speed;
      } else {
        setState(() {
          for (var p in particles) {
            p.update();
          }
        });
      }
      setState(() {
        value = v;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RadialProgressPainter(value, particles),
      child: Container(),
    );
  }
}

const TextStyle textStyle =
    TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold);

class RadialProgressPainter extends CustomPainter {
  final double percentage;
  final List<Particle> particles;
  RadialProgressPainter(this.percentage, this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    drawBackground(canvas, center, size.height / 2);
    final rect = Rect.fromCenter(
        center: center, width: 2 * radialProgress, height: 2 * radialProgress);

    drawGuide(canvas, center, radialProgress);
    drawArc(canvas, rect);
    drawTextCentered(canvas, center, "${percentage.toInt()}", textStyle,
        radialProgress * 2 * 0.8, (size) => null);

    if (percentage >= 100) {
      drawParticles(canvas, center);
    }
  }

  void drawBackground(Canvas canvas, Offset c, double extent) {
    final rect = Rect.fromCenter(center: c, width: extent, height: extent);
    final bgPaint = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xff110f14), Color(0xff2a2732)])
              .createShader(rect)
      ..style = PaintingStyle.fill;
    canvas.drawPaint(bgPaint);
  }

  void drawParticles(Canvas canvas, Offset c) {
    for (var element in particles) {
      final cc = polarToCartesian(element.orbit, element.theta) + c;
      final paint = Paint()..color = element.color.withOpacity(element.opacity);
      canvas.drawCircle(cc, 1.0, paint);
    }
  }

  void drawArc(Canvas canvas, Rect rect) {
    final fgPaint = Paint()
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..shader = const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 71, 97, 245),
                Color.fromARGB(255, 176, 187, 248),
              ],
              tileMode: TileMode.mirror)
          .createShader(rect);
    const startAngle = -90 * pi / 180;
    final sweepAngle = 360 * percentage / 100 * pi / 180;
    canvas.drawArc(rect, startAngle, sweepAngle, false, fgPaint);
  }

  Size drawTextCentered(Canvas canvas, Offset position, String text,
      TextStyle style, double maxWidth, Function(Size size) bgCb) {
    final textPainter = measureText(text, style, maxWidth, TextAlign.center);
    final pos =
        position + Offset(-textPainter.width / 2, -textPainter.height / 2);
    bgCb(textPainter.size);
    textPainter.paint(canvas, pos);
    return textPainter.size;
  }

  TextPainter measureText(
      String text, TextStyle style, double maxWidth, TextAlign align) {
    final span = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
        text: span, textAlign: align, textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: maxWidth, minWidth: 0);
    return textPainter;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void drawGuide(Canvas canvas, Offset c, double radius) {
    Paint paint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(c, radius, paint);
  }
}
